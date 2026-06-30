package dao;

import model.LivraisonHistorique;
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
}