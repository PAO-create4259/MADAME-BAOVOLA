package model;

public class TarifLivraison {

    private int idTarifLivraison;
    private double prixUnitaire;
    private int partLivreur;

    public TarifLivraison() {
    }

    public int getIdTarifLivraison() { return idTarifLivraison; }
    public void setIdTarifLivraison(int idTarifLivraison) { this.idTarifLivraison = idTarifLivraison; }

    public double getPrixUnitaire() { return prixUnitaire; }
    public void setPrixUnitaire(double prixUnitaire) { this.prixUnitaire = prixUnitaire; }

    public int getPartLivreur() { return partLivreur; }
    public void setPartLivreur(int partLivreur) { this.partLivreur = partLivreur; }
}