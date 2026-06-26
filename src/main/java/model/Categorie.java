package model;

public class Categorie {

    private String idCategorie;
    private String nom;

    public Categorie() {
    }

    public Categorie(String idCategorie, String nom) {
        this.setIdCategorie(idCategorie);
        this.setNom(nom);
    }

    public String getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}