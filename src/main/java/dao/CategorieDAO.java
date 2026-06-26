package dao;

import model.Categorie;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategorieDAO extends BaseDAO<Categorie> {

    @Override
    protected String getNomTable() {
        return "categorie";
    }

    @Override
    protected String getNomId() {
        return "id_categorie";
    }

    @Override
    protected Categorie mapResultSet(ResultSet rs) throws SQLException {
        Categorie categorie = new Categorie();

        // On récupère les données de la base pour créer l'objet Java
        categorie.setIdCategorie(rs.getString("id_categorie"));
        categorie.setNom(rs.getString("nom"));

        return categorie;
    }

    @Override
    protected String getRequeteInsert() {
        return "INSERT INTO categorie (id_categorie, nom) VALUES (?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Categorie objet) throws SQLException {
        // Remplacement des "?" par les valeurs de l'objet pour l'ajout
        ps.setString(1, objet.getIdCategorie());
        ps.setString(2, objet.getNom());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE categorie SET nom = ? WHERE id_categorie = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Categorie objet) throws SQLException {
        // Remplacement des "?" par les valeurs de l'objet pour la modification
        ps.setString(1, objet.getNom());
        // Le deuxième "?" est pour la condition WHERE
        ps.setString(2, objet.getIdCategorie());
    }
}