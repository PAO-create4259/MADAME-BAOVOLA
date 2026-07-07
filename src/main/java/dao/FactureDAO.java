package dao;

import model.Facture;
import model.Lavage;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FactureDAO extends BaseDAO<Facture> {

    @Override
    protected String getNomTable() {
        return "facture";
    }

    @Override
    protected String getNomId() {
        return "id_facture";
    }

    @Override
    protected Facture mapResultSet(ResultSet rs) throws SQLException {
        Facture facture = new Facture();

        facture.setIdFacture(rs.getString("id_facture"));

        Lavage lavage = new Lavage();
        lavage.setIdLavage(rs.getString("id_lavage"));
        facture.setLavage(lavage);

        facture.setDateFacture(rs.getDate("date_facture"));
        facture.setMontantTotal(rs.getDouble("montant_total"));

        String statut = rs.getString("statut_paiement");
        facture.setPaye("Payé".equalsIgnoreCase(statut));

        return facture;
    }

    @Override
    protected String getRequeteInsert() {
        return "INSERT INTO facture (id_lavage, date_facture, montant_total, statut_paiement) VALUES (?, ?, ?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Facture objet) throws SQLException {
        ps.setString(1, objet.getLavage().getIdLavage());
        ps.setDate(2, objet.getDateFacture());
        ps.setDouble(3, objet.getMontantTotal());
        ps.setString(4, objet.isPaye() ? "Payé" : "Non payé");
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE facture SET id_lavage = ?, date_facture = ?, montant_total = ?, statut_paiement = ? WHERE id_facture = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Facture objet) throws SQLException {
        ps.setString(1, objet.getLavage().getIdLavage());
        ps.setDate(2, objet.getDateFacture());
        ps.setDouble(3, objet.getMontantTotal());
        ps.setString(4, objet.isPaye() ? "Payé" : "Non payé");
        ps.setString(5, objet.getIdFacture());
    }

    public Facture getByLavage(String idLavage) throws SQLException {
        Facture facture = null;
        String sql = "SELECT * FROM " + getNomTable() + " WHERE id_lavage = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, idLavage);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    facture = mapResultSet(rs);
                }
            }
        }
        return facture;
    }

    public boolean updateStatut(String idLavage, String nouveauStatut) {
        String sql = "UPDATE " + getNomTable() + " SET statut_paiement = ? WHERE id_lavage = ?";

        try (Connection con = utils.DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nouveauStatut);
            ps.setString(2, idLavage);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}