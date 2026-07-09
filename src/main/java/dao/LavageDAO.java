package dao;

import model.DetailLavage;
import model.Lavage;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class LavageDAO extends BaseDAO<Lavage> {

    @Override
    protected String getNomTable() {
        return "lavage";
    }

    @Override
    protected String getNomId() {
        return "id_lavage";
    }

    @Override
    protected Lavage mapResultSet(ResultSet rs) throws SQLException {
        Lavage lavage = new Lavage();
        lavage.setIdLavage(rs.getString("id_lavage"));
        lavage.setIdClient(rs.getString("id_client"));

        // Conversion du Timestamp SQL vers LocalDateTime Java
        Timestamp tsCommande = rs.getTimestamp("date_commande");
        if (tsCommande != null) {
            lavage.setDateCommande(Timestamp.valueOf(tsCommande.toLocalDateTime()));
        }

        lavage.setStatut(rs.getString("statut"));

        Timestamp tsRetrait = rs.getTimestamp("date_retrait");
        if (tsRetrait != null) {
            lavage.setDateRetrait(Timestamp.valueOf(tsRetrait.toLocalDateTime()));
        }

        try {
            lavage.setModeRetrait(rs.getString("mode_retrait"));
        } catch (SQLException ignored) {
            // Colonne absente si migration_v3 pas encore exécutée
        }

        return lavage;
    }

    @Override
    protected String getRequeteInsert() {
        // L'identifiant et la date de commande sont gérés par la base de données
        return "INSERT INTO lavage (id_client, statut) VALUES (?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Lavage objet) throws SQLException {
        ps.setString(1, objet.getIdClient());
        ps.setString(2, objet.getStatut());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE lavage SET id_client = ?, statut = ?, date_retrait = ? WHERE id_lavage = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Lavage objet) throws SQLException {
        ps.setString(1, objet.getIdClient());
        ps.setString(2, objet.getStatut());

        // Gestion de la date de retrait qui peut être vide (null)
        if (objet.getDateRetrait() != null) {
            ps.setTimestamp(3, Timestamp.valueOf(objet.getDateRetrait().toLocalDateTime()));
        } else {
            ps.setNull(3, java.sql.Types.TIMESTAMP);
        }

        ps.setString(4, objet.getIdLavage());
    }

    // Méthode spécifique pour la page de suivi
    public List<Lavage> getLavagesByClient(String idClient) {
        List<Lavage> liste = new ArrayList<>();

        String sql = "SELECT l.*, f.montant_total, f.statut_paiement " +
                "FROM " + getNomTable() + " l " +
                "LEFT JOIN facture f ON l.id_lavage = f.id_lavage " +
                "WHERE l.id_client = ? " +
                "ORDER BY l.date_commande DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, idClient);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Lavage lavage = mapResultSet(rs);
                    lavage.setMontantTotal(rs.getDouble("montant_total"));
                    lavage.setStatutPaiement(rs.getString("statut_paiement"));
                    liste.add(lavage);
                }
            }

            // NOUVEAU : On récupère les détails pour chaque lavage trouvé
            String sqlDetails = "SELECT c.nom, d.quantite, d.prix_unitaire " +
                    "FROM detail_lavage d " +
                    "JOIN categorie c ON d.id_categorie = c.id_categorie " +
                    "WHERE d.id_lavage = ?";

            try (PreparedStatement psDet = con.prepareStatement(sqlDetails)) {
                for (Lavage l : liste) {
                    psDet.setString(1, l.getIdLavage());
                    try (ResultSet rsDet = psDet.executeQuery()) {
                        List<DetailLavage> details = new ArrayList<>();
                        while (rsDet.next()) {
                            DetailLavage detail = new DetailLavage();
                            detail.setNomCategorie(rsDet.getString("nom"));
                            detail.setQuantite(rsDet.getInt("quantite"));
                            detail.setPrixUnitaire(rsDet.getDouble("prix_unitaire"));
                            details.add(detail);
                        }
                        l.setDetails(details);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }// Méthode pour récupérer une commande spécifique avec tous ses détails
    public Lavage getLavageCompletById(String idLavage) {
        Lavage lavage = null;

        String sql = "SELECT l.*, f.montant_total, f.statut_paiement " +
                "FROM " + getNomTable() + " l " +
                "LEFT JOIN facture f ON l.id_lavage = f.id_lavage " +
                "WHERE l.id_lavage = ?";

        try (java.sql.Connection con = utils.DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, idLavage);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lavage = mapResultSet(rs);
                    lavage.setMontantTotal(rs.getDouble("montant_total"));
                    lavage.setStatutPaiement(rs.getString("statut_paiement"));
                }
            }

            // Si le lavage existe, on récupère ses détails (les vêtements)
            if (lavage != null) {
                String sqlDetails = "SELECT c.nom, d.quantite, d.prix_unitaire " +
                        "FROM detail_lavage d " +
                        "JOIN categorie c ON d.id_categorie = c.id_categorie " +
                        "WHERE d.id_lavage = ?";

                try (PreparedStatement psDet = con.prepareStatement(sqlDetails)) {
                    psDet.setString(1, idLavage);
                    try (ResultSet rsDet = psDet.executeQuery()) {
                        java.util.List<model.DetailLavage> details = new java.util.ArrayList<>();
                        while (rsDet.next()) {
                            model.DetailLavage detail = new model.DetailLavage();
                            detail.setNomCategorie(rsDet.getString("nom"));
                            detail.setQuantite(rsDet.getInt("quantite"));
                            detail.setPrixUnitaire(rsDet.getDouble("prix_unitaire"));
                            details.add(detail);
                        }
                        lavage.setDetails(details);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lavage;
    }

    public List<Lavage> getLingeEnAttenteRecuperation() {
        List<Lavage> liste = new ArrayList<>();
        String sql = "SELECT l.*, f.montant_total, f.statut_paiement, " +
                "(SELECT SUM(quantite) FROM detail_lavage d WHERE d.id_lavage = l.id_lavage) AS qte " +
                "FROM lavage l JOIN recuperation r ON r.id_lavage = l.id_lavage " +
                "LEFT JOIN facture f ON f.id_lavage = l.id_lavage " +
                "WHERE l.statut = 'En attente' ORDER BY l.date_commande ASC";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Lavage l = mapResultSet(rs);
                l.setMontantTotal(rs.getDouble("montant_total"));
                l.setStatutPaiement(rs.getString("statut_paiement"));
                l.setQuantiteLinge(rs.getInt("qte"));
                liste.add(l);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    public List<Lavage> getLingeEnCoursTraitement() {
        List<Lavage> liste = new ArrayList<>();
        String sql = "SELECT l.*, f.montant_total, f.statut_paiement, " +
                "(SELECT SUM(quantite) FROM detail_lavage d WHERE d.id_lavage = l.id_lavage) AS qte " +
                "FROM lavage l LEFT JOIN facture f ON f.id_lavage = l.id_lavage " +
                "WHERE l.statut IN ('Linge récupéré', 'En lavage') ORDER BY l.date_commande ASC";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Lavage l = mapResultSet(rs);
                l.setMontantTotal(rs.getDouble("montant_total"));
                l.setStatutPaiement(rs.getString("statut_paiement"));
                l.setQuantiteLinge(rs.getInt("qte"));
                liste.add(l);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return liste;
    }

    public boolean changerStatut(String idLavage, String nouveauStatut) {
        String sql = "Prêt à récupérer".equals(nouveauStatut)
                ? "UPDATE lavage SET statut = ?, date_retrait = CURRENT_TIMESTAMP WHERE id_lavage = ?"
                : "UPDATE lavage SET statut = ? WHERE id_lavage = ?";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nouveauStatut); ps.setString(2, idLavage);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean definirModeRetrait(String idLavage, String modeRetrait) {
        String sql = "UPDATE lavage SET mode_retrait = ? WHERE id_lavage = ? AND mode_retrait IS NULL";
        try (Connection con = DatabaseConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, modeRetrait); ps.setString(2, idLavage);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public int countEnCours(String idClient) {

        String sql = "SELECT COUNT(*) FROM lavage " +
                "WHERE id_client = ? " +
                "AND statut IN ('En attente','Linge récupéré','En lavage')";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, idClient);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int countTermines(String idClient) {

        String sql = "SELECT COUNT(*) FROM lavage " +
                "WHERE id_client = ? " +
                "AND statut = 'Prêt à récupérer'";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, idClient);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Lavage> getHistoriqueLavages() {
        List<Lavage> liste = new ArrayList<>();
        String sql = "SELECT l.*, f.montant_total, f.statut_paiement," +
                "(SELECT SUM(quantite) FROM detail_lavage d WHERE d.id_lavage = l.id_lavage) AS qte " +
                "FROM lavage l " +
                "JOIN facture f ON l.id_lavage = f.id_lavage " +
                "WHERE l.statut IN ('Prêt à récupérer', 'Linge récupéré', 'Annulé') " +
                "ORDER BY l.date_commande DESC";

        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Lavage lavage = mapResultSet(rs);
                lavage.setMontantTotal(rs.getDouble("montant_total"));
                lavage.setStatutPaiement(rs.getString("statut_paiement"));
                lavage.setQuantiteLinge(rs.getInt("qte"));
                liste.add(lavage);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return liste;
    }

}