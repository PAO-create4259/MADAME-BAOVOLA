package dao;

import utils.DatabaseConnection;
import java.sql.*;
import java.util.LinkedHashMap;
import java.util.Map;

public class StatistiqueDAO {

    public double getChiffreAffaires(Date debut, Date fin) {
        String sql = "SELECT COALESCE(SUM(f.montant_total), 0) AS total " +
                "FROM facture f JOIN lavage l ON f.id_lavage = l.id_lavage " +
                "WHERE l.statut IN ('Prêt à récupérer', 'Linge récupéré') AND l.date_commande::date BETWEEN ? AND ?";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return rs.getDouble("total"); }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public int getNombreLavages(Date debut, Date fin) {
        String sql = "SELECT COUNT(*) AS nb FROM lavage WHERE date_commande::date BETWEEN ? AND ? AND statut <> 'Annulé'";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return rs.getInt("nb"); }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // Évolution hebdomadaire : clé = lundi de la semaine, valeur = [ca, depenses]
    public Map<Date, double[]> getEvolutionHebdomadaire(Date debut, Date fin) {
        Map<Date, double[]> evolution = new LinkedHashMap<>();

        String sqlSemaines = "SELECT generate_series(date_trunc('week', ?::date), date_trunc('week', ?::date), interval '1 week')::date AS semaine";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sqlSemaines)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) evolution.put(rs.getDate("semaine"), new double[]{0, 0});
            }
        } catch (SQLException e) { e.printStackTrace(); }

        String sqlCa = "SELECT date_trunc('week', l.date_commande)::date AS semaine, COALESCE(SUM(f.montant_total), 0) AS total " +
                "FROM facture f JOIN lavage l ON f.id_lavage = l.id_lavage " +
                "WHERE l.statut IN ('Prêt à récupérer', 'Linge récupéré') AND l.date_commande::date BETWEEN ? AND ? GROUP BY semaine";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sqlCa)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double[] v = evolution.computeIfAbsent(rs.getDate("semaine"), k -> new double[]{0, 0});
                    v[0] = rs.getDouble("total");
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }

        String sqlDepenses = "SELECT date_trunc('week', date_depense)::date AS semaine, COALESCE(SUM(montant), 0) AS total " +
                "FROM depense WHERE date_depense::date BETWEEN ? AND ? GROUP BY semaine";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sqlDepenses)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double[] v = evolution.computeIfAbsent(rs.getDate("semaine"), k -> new double[]{0, 0});
                    v[1] = rs.getDouble("total");
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }

        return evolution;
    }
}