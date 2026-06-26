package dao;

import model.Client;
import utils.DatabaseConnection;
import java.sql.*;
import java.time.LocalDate;

public class CommandeDAO {

    public boolean creerCommande(Client client, String[] idCategories, String[] quantites, String[] prixUnitaires,
                                 boolean avecRecuperation, String adresse, String telephone,
                                 double montantTotal, double prixLivraison) {

        Connection con = null;
        try {
            con = DatabaseConnection.getConnection();
            con.setAutoCommit(false); // 1. On bloque l'enregistrement automatique (Début de la transaction)

            // --- ÉTAPE A : Créer le Lavage et récupérer son ID ---
            String sqlLavage = "INSERT INTO lavage (id_client, statut) VALUES (?, 'En attente') RETURNING id_lavage";
            PreparedStatement psLavage = con.prepareStatement(sqlLavage);
            psLavage.setString(1, client.getIdClient());

            ResultSet rsLavage = psLavage.executeQuery();
            String idLavage = "";
            if (rsLavage.next()) {
                idLavage = rsLavage.getString("id_lavage");
            }
            rsLavage.close();
            psLavage.close();

            // --- ÉTAPE B : Insérer les détails du lavage ---
            String sqlDetail = "INSERT INTO detail_lavage (id_lavage, id_categorie, quantite, prix_unitaire) VALUES (?, ?, ?, ?)";
            PreparedStatement psDetail = con.prepareStatement(sqlDetail);

            for (int i = 0; i < idCategories.length; i++) {
                psDetail.setString(1, idLavage);
                psDetail.setInt(2, Integer.parseInt(idCategories[i]));
                psDetail.setInt(3, Integer.parseInt(quantites[i]));
                psDetail.setDouble(4, Double.parseDouble(prixUnitaires[i]));
                psDetail.addBatch(); // On prépare un tir groupé
            }
            psDetail.executeBatch(); // On exécute toutes les insertions de la liste d'un coup
            psDetail.close();

            // --- ÉTAPE C : Insérer la facture ---
            String sqlFacture = "INSERT INTO facture (id_lavage, prix_livraison, montant_total, statut_paiement) VALUES (?, ?, ?, 'Non payé')";
            PreparedStatement psFacture = con.prepareStatement(sqlFacture);
            psFacture.setString(1, idLavage);
            psFacture.setDouble(2, prixLivraison);
            psFacture.setDouble(3, montantTotal);
            psFacture.executeUpdate();
            psFacture.close();

            // --- ÉTAPE D : Insérer la récupération (Si cochée) ---
            if (avecRecuperation) {
                String sqlRecup = "INSERT INTO recuperation (id_lavage, date_recuperation, lieu_recuperation, numero_appeler) VALUES (?, ?, ?, ?)";
                PreparedStatement psRecup = con.prepareStatement(sqlRecup);

                // Calcul de la date de demain en Java
                Date dateDemain = Date.valueOf(LocalDate.now().plusDays(1));

                psRecup.setString(1, idLavage);
                psRecup.setDate(2, dateDemain);
                psRecup.setString(3, adresse);
                psRecup.setString(4, telephone);
                psRecup.executeUpdate();
                psRecup.close();
            }

            // 2. Si tout s'est bien passé jusqu'ici, on valide définitivement toutes les insertions
            con.commit();
            return true;

        } catch (SQLException e) {
            // 3. En cas d'erreur, on annule tout ce qui a été fait dans ce bloc (Rollback)
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            return false;
        } finally {
            // 4. On remet la connexion dans son état normal avant de la fermer
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}