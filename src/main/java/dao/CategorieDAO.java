package dao;

import model.Categorie;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategorieDAO extends BaseDAO<Categorie> {

    @Override
    protected String getNomTable() {
        // On lit les données depuis la vue
        return "v_categorie_tarif";
    }

    @Override
    protected String getNomId() {
        return "id_categorie";
    }

    @Override
    protected Categorie mapResultSet(ResultSet rs) throws SQLException {
        Categorie categorie = new Categorie();

        // On récupère toutes les colonnes de la vue
        categorie.setIdCategorie(rs.getInt("id_categorie"));
        categorie.setNomCategorie(rs.getString("nom_categorie"));
        categorie.setIdTarif(rs.getInt("id_tarif"));
        categorie.setPrix(rs.getDouble("prix"));

        return categorie;
    }

    @Override
    protected String getRequeteInsert() {
        // L'insertion se fait toujours dans la table d'origine
        return "INSERT INTO categorie (nom) VALUES (?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Categorie objet) throws SQLException {
        // Un seul paramètre car l'ID est généré automatiquement par la base
        ps.setString(1, objet.getNomCategorie());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE categorie SET nom = ? WHERE id_categorie = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Categorie objet) throws SQLException {
        ps.setString(1, objet.getNomCategorie());
        ps.setInt(2, objet.getIdCategorie());
    }
}