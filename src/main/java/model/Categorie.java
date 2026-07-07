package model;

import utils.Utilitaires;

public class Categorie {

    private int idCategorie;
    private String nomCategorie;
    private int idTarif;
    private double prix;

    public Categorie() {
    }

    public int getIdCategorie() { return idCategorie; }
    public void setIdCategorie(int idCategorie) { this.idCategorie = idCategorie; }
    
    public String getNomCategorie() { return nomCategorie; }
    public void setNomCategorie(String nomCategorie) { this.nomCategorie = nomCategorie; }
    
    public int getIdTarif() { return idTarif; }
    public void setIdTarif(int idTarif) { this.idTarif = idTarif; }
    
    public double getPrix() { return prix; }
    public void setPrix(double prix) { this.prix = prix;}
    
    public String getPrixFormate() { return Utilitaires.formaterNombre(this.prix); }
}