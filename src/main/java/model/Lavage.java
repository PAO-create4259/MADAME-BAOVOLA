package model;

import java.util.List;
import java.util.ArrayList;

import utils.Utilitaires;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Lavage {

    private String idLavage;
    private String idClient;
    private Timestamp dateCommande;
    private String statut;
    private Timestamp dateRetrait;
    private double montantTotal;
    private String statutPaiement;
    private String modeRetrait;
    private int quantiteLinge;
    private List<DetailLavage> details = new ArrayList<>();
    
    public Lavage() {
    }
    
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
    
    public int getQuantiteLinge() { return quantiteLinge; }
    public void setQuantiteLinge(int quantiteLinge) { this.quantiteLinge = quantiteLinge; }
    
    public String getModeRetrait() { return modeRetrait; }
    public void setModeRetrait(String modeRetrait) { this.modeRetrait = modeRetrait; }
    
    public List<DetailLavage> getDetails() { return details; }
    public void setDetails(List<DetailLavage> details) { this.details = details; }
    
    public String getPrixFormate() {
        return Utilitaires.formaterNombre(this.getMontantTotal());
    }

    public String getDateFormatee() {
        if (this.dateCommande != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy à HH:mm");
            return sdf.format(this.dateCommande);
        }
        return "";
    }
}