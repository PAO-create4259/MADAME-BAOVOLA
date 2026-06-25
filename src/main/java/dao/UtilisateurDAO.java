package dao;

import model.Utilisateur;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UtilisateurDAO extends BaseDAO<Utilisateur> {

    @Override
    protected String getNomTable() {
        return "utilisateur";
    }

    @Override
    protected String getNomId() {
        return "id_utilisateur";
    }

    @Override
    protected Utilisateur mapResultSet(ResultSet rs) throws SQLException {
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setIdUtilisateur(rs.getString("id_utilisateur"));
        utilisateur.setNom(rs.getString("nom"));
        utilisateur.setIdentifiant(rs.getString("identifiant"));
        utilisateur.setMotDePasse(rs.getString("mot_de_passe"));
        utilisateur.setRole(rs.getString("role"));
        utilisateur.setActif(rs.getBoolean("actif"));
        return utilisateur;
    }

    @Override
    protected String getRequeteInsert() {
        return "INSERT INTO utilisateur (nom, identifiant, mot_de_passe, role, actif) VALUES (?, ?, ?, ?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Utilisateur objet) throws SQLException {
        ps.setString(1, objet.getNom());
        ps.setString(2, objet.getIdentifiant());
        ps.setString(3, objet.getMotDePasse());
        ps.setString(4, objet.getRole());
        ps.setBoolean(5, objet.isActif());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE utilisateur SET nom = ?, identifiant = ?, mot_de_passe = ?, role = ?, actif = ? WHERE id_utilisateur = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Utilisateur objet) throws SQLException {
        ps.setString(1, objet.getNom());
        ps.setString(2, objet.getIdentifiant());
        ps.setString(3, objet.getMotDePasse());
        ps.setString(4, objet.getRole());
        ps.setBoolean(5, objet.isActif());
        ps.setString(6, objet.getIdUtilisateur());
    }

    public Utilisateur getByUsername(String username) throws SQLException {
        Utilisateur utilisateur = null;
        String sql = "SELECT * FROM " + getNomTable() + " WHERE identifiant = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    utilisateur = mapResultSet(rs);
                }
            }
        }

        return utilisateur;
    }
}