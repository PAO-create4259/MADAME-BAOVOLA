package dao;

import model.Categorie;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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

    private static List<Categorie> cacheCategories = null;
    private static long cacheHeureMiseAJour = 0;
    private static final long DUREE_VALIDITE_CACHE = 60 * 60 * 1000;

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

    public List<Categorie> getAllCached() {
        long maintenant = System.currentTimeMillis();

        // On vérifie si le cache est vide OU si la durée de validité est dépassée
        if (cacheCategories == null || (maintenant - cacheHeureMiseAJour) > DUREE_VALIDITE_CACHE) {

            // Le "sout" te permettra de vérifier dans la console d'IntelliJ quand la BDD est appelée
            System.out.println("--> [CACHE MISS] Récupération des catégories depuis la BDD...");

            // On appelle le getAll() normal de ton BaseDAO
            cacheCategories = super.getAll();
            cacheHeureMiseAJour = maintenant;

        } else {
            System.out.println("--> [CACHE HIT] Catégories servies depuis la mémoire RAM !");
        }

        return cacheCategories;
    }

    public static void viderCache() {
        cacheCategories = null;
    }
}