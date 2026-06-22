package dao;

import utils.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public abstract class BaseDAO<Modele> {

    // ==============================================================================
    // 1. MÉTHODES ABSTRAITES (Que les classes filles devront obligatoirement remplir)
    // ==============================================================================

    // Informations de base de la table
    protected abstract String getNomTable();
    protected abstract String getNomId();
    protected abstract Modele mapResultSet(ResultSet rs) throws SQLException;

    // Informations pour l'insertion
    protected abstract String getRequeteInsert();
    protected abstract void parametrerInsert(PreparedStatement ps, Modele objet) throws SQLException;

    // Informations pour la modification
    protected abstract String getRequeteUpdate();
    protected abstract void parametrerUpdate(PreparedStatement ps, Modele objet) throws SQLException;


    // ==============================================================================
    // 2. MÉTHODES COMMUNES (Le code réutilisable pour toutes les tables)
    // ==============================================================================

    // --------------------------------------------------------
    // C - CREATE (Insérer une nouvelle ligne)
    // --------------------------------------------------------
    public boolean insert(Modele objet) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(getRequeteInsert())) {

            // On demande à la classe fille de remplir les "?" de la requête
            parametrerInsert(ps, objet);

            int lignesModifiees = ps.executeUpdate();
            return lignesModifiees > 0;

        } catch (SQLException e) {
            System.err.println("Erreur lors de l'insertion dans la table " + getNomTable());
            e.printStackTrace();
            return false;
        }
    }

    // --------------------------------------------------------
    // R - READ (Lire et récupérer des données)
    // --------------------------------------------------------

    // Récupérer toutes les lignes de la table
    public List<Modele> getAll() {
        List<Modele> liste = new ArrayList<>();
        String sql = "SELECT * FROM " + getNomTable();

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // On transforme chaque ligne SQL en objet Java
                liste.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la récupération des données de la table " + getNomTable());
            e.printStackTrace();
        }
        return liste;
    }

    // Récupérer une seule ligne grâce à son Identifiant
    public Modele getById(String id) {
        Modele objet = null;
        String sql = "SELECT * FROM " + getNomTable() + " WHERE " + getNomId() + " = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    objet = mapResultSet(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur lors de la recherche de l'ID " + id + " dans " + getNomTable());
            e.printStackTrace();
        }
        return objet;
    }

    // --------------------------------------------------------
    // U - UPDATE (Modifier une ligne existante)
    // --------------------------------------------------------
    public boolean update(Modele objet) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(getRequeteUpdate())) {

            // On demande à la classe fille de remplir les "?" avec les nouvelles valeurs
            parametrerUpdate(ps, objet);

            int lignesModifiees = ps.executeUpdate();
            return lignesModifiees > 0;

        } catch (SQLException e) {
            System.err.println("Erreur lors de la modification dans la table " + getNomTable());
            e.printStackTrace();
            return false;
        }
    }

    // --------------------------------------------------------
    // D - DELETE (Supprimer une ligne)
    // --------------------------------------------------------
    public boolean delete(String id) {
        String sql = "DELETE FROM " + getNomTable() + " WHERE " + getNomId() + " = ?";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id);

            int lignesModifiees = ps.executeUpdate();
            return lignesModifiees > 0;

        } catch (SQLException e) {
            System.err.println("Erreur lors de la suppression de l'ID " + id + " dans " + getNomTable());
            e.printStackTrace();
            return false;
        }
    }
}