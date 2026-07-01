package model;

import utils.Utilitaires;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Lavage {

    private String idLavage;
    private String idClient;
    private Timestamp dateCommande;
    private String statut;
    private Timestamp dateRetrait;

    // Attributs supplémentaires provenant de la table facture pour l'affichage
    private double montantTotal;
    private String statutPaiement;

    // NOUVEL ATTRIBUT (N'oublie pas d'importer java.util.List et java.util.ArrayList en haut)
    private java.util.List<DetailLavage> details = new java.util.ArrayList<>();

    public java.util.List<DetailLavage> getDetails() { return details; }
    public void setDetails(java.util.List<DetailLavage> details) { this.details = details; }

    public Lavage() {
    }

    public Lavage(String idLavage, String idClient, Timestamp dateCommande, String statut, double montantTotal, String statutPaiement) {
        this.setIdLavage(idLavage);
        this.setIdClient(idClient);
        this.setDateCommande(dateCommande);
        this.setStatut(statut);
        this.setMontantTotal(montantTotal);
        this.setStatutPaiement(statutPaiement);
    }

    // Méthodes pratiques pour l'affichage JSP
    public String getPrixFormate() {
        return Utilitaires.formaterNombre(this.montantTotal);
    }

    public String getDateFormatee() {
        if (this.dateCommande != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy à HH:mm");
            return sdf.format(this.dateCommande);
        }
        return "";
    }

    // Getters et Setters
    public String getIdLavage() { return idLavage; }
    public void setIdLavage(String idLavage) { this.idLavage = idLavage; }

    public String getIdClient() { return idClient; }
    public void setIdClient(String idClient) { this.idClient = idClient; }

    public Timestamp getDateCommande() { return dateCommande; }
    public void setDateCommande(Timestamp dateCommande) { this.dateCommande = dateCommande; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public Timestamp getDateRetrait() { return dateRetrait; }
    public void setDateRetrait(Timestamp dateRetrait) { this.dateRetrait = dateRetrait; }

    public double getMontantTotal() { return montantTotal; }
    public void setMontantTotal(double montantTotal) { this.montantTotal = montantTotal; }

    public String getStatutPaiement() { return statutPaiement; }
    public void setStatutPaiement(String statutPaiement) { this.statutPaiement = statutPaiement; }

    // Attribut calculé (nombre de pièces de linge) pour les tableaux de suivi admin
    private int quantiteLinge;
    public int getQuantiteLinge() { return quantiteLinge; }
    public void setQuantiteLinge(int quantiteLinge) { this.quantiteLinge = quantiteLinge; }

    // Choix du client une fois "Prêt à récupérer" : 'sur_place' ou 'domicile' (persisté en base)
    private String modeRetrait;
    public String getModeRetrait() { return modeRetrait; }
    public void setModeRetrait(String modeRetrait) { this.modeRetrait = modeRetrait; }
}