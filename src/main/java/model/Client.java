package model;

public class Client {
    private String idClient;
    private String nom;
    private String prenom;
    private String telephone;

    public Client() {
    }

    public Client(String idClient, String nom, String prenom, String telephone) {
        this.setIdClient(idClient);
        this.setNom(nom);
        this.setPrenom(prenom);
        this.setTelephone(telephone);
    }

    public String getIdClient() { return idClient; }
    public void setIdClient(String idClient) { this.idClient = idClient; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
}