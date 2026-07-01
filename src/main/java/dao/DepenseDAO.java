package dao;

import model.Depense;
import utils.DatabaseConnection;
import java.sql.*;
import java.util.*;

public class DepenseDAO {

    public boolean ajouterDepense(int idCategorie, double montant, String description, java.sql.Date dateDepense) {
        if (montant <= 0) return false; // RG33/RG35
        String sql = "INSERT INTO depense (id_categorie, montant, description, date_depense) VALUES (?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCategorie);
            ps.setDouble(2, montant);
            ps.setString(3, description);
            ps.setTimestamp(4, dateDepense != null ? new Timestamp(dateDepense.getTime()) : new Timestamp(System.currentTimeMillis()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Depense> getDepensesParPeriode(java.sql.Date debut, java.sql.Date fin) {
        List<Depense> liste = new ArrayList<>();
        String sql = "SELECT d.id_depense, d.id_categorie, c.nom AS nom_categorie, d.montant, d.date_depense, d.description " +
                "FROM depense d JOIN categorie_depense c ON d.id_categorie = c.id_categorie " +
                "WHERE d.date_depense::date BETWEEN ? AND ? ORDER BY d.date_depense DESC";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) { while (rs.next()) liste.add(mapResultSet(rs)); }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    public double getTotalParPeriode(java.sql.Date debut, java.sql.Date fin) {
        String sql = "SELECT COALESCE(SUM(montant), 0) AS total FROM depense WHERE date_depense::date BETWEEN ? AND ?";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) { if (rs.next()) return rs.getDouble("total"); }
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public Map<String, Double> getTotalParCategorie(java.sql.Date debut, java.sql.Date fin) {
        Map<String, Double> resultat = new LinkedHashMap<>();
        String sql = "SELECT c.nom AS nom_categorie, COALESCE(SUM(d.montant), 0) AS total " +
                "FROM categorie_depense c LEFT JOIN depense d ON d.id_categorie = c.id_categorie " +
                "AND d.date_depense::date BETWEEN ? AND ? GROUP BY c.id_categorie, c.nom ORDER BY c.id_categorie";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) resultat.put(rs.getString("nom_categorie"), rs.getDouble("total"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return resultat;
    }

    public java.util.Map<java.sql.Date, Double> getTotalParSemaine(java.sql.Date debut, java.sql.Date fin) {
        java.util.Map<java.sql.Date, Double> resultat = new LinkedHashMap<>();
        String sql = "SELECT date_trunc('week', date_depense)::date AS semaine, COALESCE(SUM(montant), 0) AS total " +
                "FROM depense WHERE date_depense::date BETWEEN ? AND ? GROUP BY semaine ORDER BY semaine";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) resultat.put(rs.getDate("semaine"), rs.getDouble("total"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return resultat;
    }

    public List<model.Categorie> getCategoriesDepense() {
        List<model.Categorie> liste = new ArrayList<>();
        String sql = "SELECT id_categorie, nom FROM categorie_depense ORDER BY id_categorie";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                model.Categorie c = new model.Categorie();
                c.setIdCategorie(rs.getInt("id_categorie"));
                c.setNomCategorie(rs.getString("nom"));
                liste.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    private Depense mapResultSet(ResultSet rs) throws SQLException {
        Depense d = new Depense();
        d.setIdDepense(rs.getInt("id_depense"));
        d.setIdCategorie(rs.getInt("id_categorie"));
        d.setNomCategorie(rs.getString("nom_categorie"));
        d.setMontant(rs.getDouble("montant"));
        d.setDateDepense(rs.getTimestamp("date_depense"));
        d.setDescription(rs.getString("description"));
        return d;
    }
}