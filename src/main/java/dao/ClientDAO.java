package dao;

import model.Client;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

    public Client getByTelephone(String telephone) throws SQLException {
        Client client = null;

        String sql = "SELECT * FROM " + getNomTable() + " WHERE telephone = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, telephone);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    client = mapResultSet(rs);
                }
            }
        }
        return client;
    }

    public List<Client> getClientsParNom() {
        List<Client> liste = new ArrayList<>();
        String sql = "SELECT * FROM " + getNomTable() + " ORDER BY nom ASC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                liste.add(mapResultSet(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return liste;
    }
}