package dao;

import model.Client;
import utils.DatabaseConnection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClientDAO extends BaseDAO<Client> {

    @Override
    protected String getNomTable() {
        return "client";
    }

    @Override
    protected String getNomId() {
        return "id_client";
    }

    @Override
    protected Client mapResultSet(ResultSet rs) throws SQLException {
        Client client = new Client();
        client.setIdClient(rs.getString("id_client"));
        client.setNom(rs.getString("nom"));
        client.setPrenom(rs.getString("prenom"));
        client.setTelephone(rs.getString("telephone"));
        return client;
    }

    @Override
    protected String getRequeteInsert() {
        return "INSERT INTO client (nom, prenom, telephone) VALUES (?, ?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Client objet) throws SQLException {
        ps.setString(1, objet.getNom());
        ps.setString(2, objet.getPrenom());
        ps.setString(3, objet.getTelephone());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE client SET nom = ?, prenom = ?, telephone = ? WHERE id_client = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Client objet) throws SQLException {
        ps.setString(1, objet.getNom());
        ps.setString(2, objet.getPrenom());
        ps.setString(3, objet.getTelephone());
        ps.setString(4, objet.getIdClient());
    }

    public boolean isClientExist(String telephone) throws SQLException {
        String sql = "SELECT COUNT(*) FROM " + getNomTable() + " WHERE telephone = ?";
        try (PreparedStatement ps = DatabaseConnection.getConnection().prepareStatement(sql)) {
            ps.setString(1, telephone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
}