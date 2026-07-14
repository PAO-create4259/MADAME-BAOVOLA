package dao;

import model.LivraisonHistorique;
import model.Status;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LivraisonDAO {

    public List<LivraisonHistorique> getHistoriqueLivraison() {
        List<LivraisonHistorique> liste = new ArrayList<>();

        String sql = "SELECT l.id_lavage, c.telephone, r.lieu_recuperation as adresse, " +
                "r.date_recuperation as date, 'Récupéré' as statut " +
                "FROM recuperation r " +
                "JOIN lavage l ON r.id_lavage = l.id_lavage " +
                "JOIN client c ON l.id_client = c.id_client " +
                "UNION ALL " +
                "SELECT l.id_lavage, c.telephone, ld.lieu_livraison as adresse, " +
                "ld.date_livraison as date, 'Livré' as statut " +
                "FROM livraison ld " +
                "JOIN lavage l ON ld.id_lavage = l.id_lavage " +
                "JOIN client c ON l.id_client = c.id_client " +
                "ORDER BY date DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                LivraisonHistorique hist = new LivraisonHistorique();
                hist.setIdLavage(rs.getString("id_lavage"));
                hist.setTelephone(rs.getString("telephone"));
                hist.setAdresse(rs.getString("adresse"));
                hist.setDate(rs.getDate("date"));
                hist.setStatut(rs.getString("statut"));
                liste.add(hist);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

    public boolean existeLivraison(String idLavage) {
        String sql = "SELECT 1 FROM livraison WHERE id_lavage = ?";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idLavage);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<LivraisonHistorique> getLivraisonsEnCours() {
        List<LivraisonHistorique> liste = new ArrayList<>();
        String sql = "SELECT l.id_lavage, c.telephone, r.lieu_recuperation as adresse, r.date_recuperation as date, 'Récupéré' as statut " +
                "FROM recuperation r JOIN lavage l ON r.id_lavage = l.id_lavage JOIN client c ON l.id_client = c.id_client " +
                "WHERE l.statut <> 'Prêt à récupérer' AND l.statut <> 'Annulé' " +
                "UNION ALL " +
                "SELECT l.id_lavage, c.telephone, ld.lieu_livraison as adresse, ld.date_livraison as date, 'Livré' as statut " +
                "FROM livraison ld JOIN lavage l ON ld.id_lavage = l.id_lavage JOIN client c ON l.id_client = c.id_client " +
                "WHERE l.statut <> 'Prêt à récupérer' AND l.statut <> 'Annulé' ORDER BY date DESC";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LivraisonHistorique hist = new LivraisonHistorique();
                hist.setIdLavage(rs.getString("id_lavage"));
                hist.setTelephone(rs.getString("telephone"));
                hist.setAdresse(rs.getString("adresse"));
                hist.setDate(rs.getDate("date"));
                hist.setStatut(rs.getString("statut"));
                liste.add(hist);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    public boolean enregistrerLivraison(String idLavage, String adresse, String numeroAppeler, String idLivreur) {
        if (adresse == null || adresse.trim().isEmpty() || numeroAppeler == null || numeroAppeler.trim().isEmpty()) return false;
        String sql = "INSERT INTO livraison (id_lavage, date_livraison, lieu_livraison, numero_appeler, id_livreur) " +
                "VALUES (?, CURRENT_DATE, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idLavage); ps.setString(2, adresse); ps.setString(3, numeroAppeler); ps.setString(4, idLivreur);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<LivraisonHistorique> getEnAttenteAssignation() {
        List<LivraisonHistorique> liste = new ArrayList<>();
        String sql = "SELECT 'recuperation' AS type, r.id_recuperation AS id_record, r.id_lavage, c.telephone, " +
                "r.lieu_recuperation AS adresse, r.date_recuperation AS date " +
                "FROM recuperation r JOIN lavage l ON r.id_lavage = l.id_lavage JOIN client c ON l.id_client = c.id_client " +
                "WHERE r.id_livreur IS NULL " +
                "UNION ALL " +
                "SELECT 'livraison' AS type, ld.id_livraison AS id_record, ld.id_lavage, c.telephone, " +
                "ld.lieu_livraison AS adresse, ld.date_livraison AS date " +
                "FROM livraison ld JOIN lavage l ON ld.id_lavage = l.id_lavage JOIN client c ON l.id_client = c.id_client " +
                "WHERE ld.id_livreur IS NULL ORDER BY date ASC";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LivraisonHistorique h = new LivraisonHistorique();
                h.setIdRecord(rs.getString("id_record"));
                h.setStatut("recuperation".equals(rs.getString("type")) ? Status.RECUPERATION.toString() : Status.LIVRAISON.toString());
                h.setIdLavage(rs.getString("id_lavage"));
                h.setTelephone(rs.getString("telephone"));
                h.setAdresse(rs.getString("adresse"));
                h.setDate(rs.getDate("date"));
                liste.add(h);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    public boolean assignerLivreur(String type, String idRecord, String idLivreur) {
        String table = "recuperation".equals(type) ? "recuperation" : "livraison";
        String colonneId = "recuperation".equals(type) ? "id_recuperation" : "id_livraison";
        String sql = "UPDATE " + table + " SET id_livreur = ? WHERE " + colonneId + " = ?";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, idLivreur); ps.setString(2, idRecord);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public java.util.Map<String, double[]> getCommissionsParLivreur(java.sql.Date debut, java.sql.Date fin) {
        java.util.Map<String, double[]> resultat = new java.util.LinkedHashMap<>();
        String sql = "SELECT u.nom, COUNT(*) AS nb, " +
                "COALESCE((SELECT t.prix_unitaire * t.part_livreur / 100.0 FROM tarif_livraison t ORDER BY t.id_tarif_livraison DESC LIMIT 1), 0) AS commission_unitaire " +
                "FROM utilisateur u JOIN (" +
                "  SELECT id_livreur, date_recuperation AS date FROM recuperation WHERE id_livreur IS NOT NULL " +
                "  UNION ALL SELECT id_livreur, date_livraison AS date FROM livraison WHERE id_livreur IS NOT NULL" +
                ") courses ON courses.id_livreur = u.id_utilisateur " +
                "WHERE u.role = 'Livreur' AND courses.date BETWEEN ? AND ? GROUP BY u.nom";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDate(1, debut); ps.setDate(2, fin);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    double nb = rs.getDouble("nb");
                    double cu = rs.getDouble("commission_unitaire");
                    resultat.put(rs.getString("nom"), new double[]{ nb, nb * cu });
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return resultat;
    }
}