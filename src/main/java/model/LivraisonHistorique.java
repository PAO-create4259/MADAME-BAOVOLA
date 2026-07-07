package model;

import java.sql.Date;

public class LivraisonHistorique {
    private String idLavage;
    private String telephone;
    private String adresse;
    private Date date;
    private String statut;
    private String idRecord;
    private String idLivreur;

    public LivraisonHistorique() {}

    public String getIdLavage() { return idLavage; }
    public void setIdLavage(String idLavage) { this.idLavage = idLavage; }

    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }

    public String getAdresse() { return adresse; }
    public void setAdresse(String adresse) { this.adresse = adresse; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public String getIdRecord() { return idRecord; }
    public void setIdRecord(String idRecord) { this.idRecord = idRecord; }
    
    public String getIdLivreur() { return idLivreur; }
    public void setIdLivreur(String idLivreur) { this.idLivreur = idLivreur; }
}