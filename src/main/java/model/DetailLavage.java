package model;

import utils.Utilitaires;

public class DetailLavage {
    private String nomCategorie;
    private int quantite;
    private double prixUnitaire;

    public DetailLavage() {}

    public String getNomCategorie() { return nomCategorie; }
    public void setNomCategorie(String nomCategorie) { this.nomCategorie = nomCategorie; }

    public int getQuantite() { return quantite; }
    public void setQuantite(int quantite) { this.quantite = quantite; }

    public double getPrixUnitaire() { return prixUnitaire; }
    public void setPrixUnitaire(double prixUnitaire) { this.prixUnitaire = prixUnitaire; }

    public String getPrixUnitaireFormate() {
        return Utilitaires.formaterNombre(this.prixUnitaire);
    }

    public String getTotalFormate() {
        return Utilitaires.formaterNombre(this.prixUnitaire * this.quantite);
    }
}