package dao;

import model.TarifLivraison;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class TarifLivraisonDAO extends BaseDAO<TarifLivraison> {

    @Override
    protected String getNomTable() {
        return "tarif_livraison";
    }

    @Override
    protected String getNomId() {
        return "id_tarif_livraison";
    }

    @Override
    protected TarifLivraison mapResultSet(ResultSet rs) throws SQLException {
        TarifLivraison tarif = new TarifLivraison();

        tarif.setIdTarifLivraison(rs.getInt("id_tarif_livraison"));
        tarif.setPrixUnitaire(rs.getDouble("prix_unitaire"));
        tarif.setPartLivreur(rs.getInt("part_livreur"));

        return tarif;
    }

    @Override
    protected String getRequeteInsert() {
        return "INSERT INTO tarif_livraison (prix_unitaire, part_livreur) VALUES (?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, TarifLivraison objet) throws SQLException {
        ps.setDouble(1, objet.getPrixUnitaire());
        ps.setInt(2, objet.getPartLivreur());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE tarif_livraison SET prix_unitaire = ?, part_livreur = ? WHERE id_tarif_livraison = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, TarifLivraison objet) throws SQLException {
        ps.setDouble(1, objet.getPrixUnitaire());
        ps.setInt(2, objet.getPartLivreur());
        ps.setInt(3, objet.getIdTarifLivraison());
    }

    // Méthode personnalisée pour récupérer le tarif de livraison actif
    public TarifLivraison getTarifActuel() {
        List<TarifLivraison> liste = this.getAll();
        if (liste != null && !liste.isEmpty()) {
            return liste.get(0); // On prend le premier de la liste
        }
        return null;
    }
}