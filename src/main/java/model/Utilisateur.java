package model;

public class Utilisateur {
    private String  idUtilisateur;
    private String  nom;
    private String  identifiant;
    private String  motDePasse;
    private String  role;
    private boolean actif;

    public Utilisateur() {
    }

    public Utilisateur(String idUtilisateur, String nom, String identifiant, String motDePasse, String role, boolean actif) {
        this.setIdUtilisateur(idUtilisateur);
        this.setNom(nom);
        this.setIdentifiant(identifiant);
        this.setMotDePasse(motDePasse);
        this.setRole(role);
        this.setActif(actif);
    }

    public String getIdUtilisateur() { return idUtilisateur; }
    public void setIdUtilisateur(String idUtilisateur) { this.idUtilisateur = idUtilisateur; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getIdentifiant() { return identifiant; }
    public void setIdentifiant(String identifiant) { this.identifiant = identifiant; }

    public String getMotDePasse() { return motDePasse; }
    public void setMotDePasse(String motDePasse) { this.motDePasse = motDePasse; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public boolean isActif() { return actif; }
    public void setActif(boolean actif) { this.actif = actif; }

}
