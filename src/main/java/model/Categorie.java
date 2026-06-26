package model;

import utils.Utilitaires;

public class Categorie {

    private int idCategorie;
    private String nomCategorie;
    private int idTarif;
    private double prix;

    public Categorie() {
    }

    public Categorie(int idCategorie, String nomCategorie, int idTarif, double prix) {
        this.setIdCategorie(idCategorie);
        this.setNomCategorie(nomCategorie);
        this.setIdTarif(idTarif);
        this.setPrix(prix);
    }

    public String getPrixFormate() {
        return Utilitaires.formaterNombre(this.prix);
    }

    public int getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(int idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getNomCategorie() {
        return nomCategorie;
    }

    public void setNomCategorie(String nomCategorie) {
        this.nomCategorie = nomCategorie;
    }

    public int getIdTarif() {
        return idTarif;
    }

    public void setIdTarif(int idTarif) {
        this.idTarif = idTarif;
    }

    public double getPrix() {
        return prix;
    }

    public void setPrix(double prix) {
        this.prix = prix;
    }
}