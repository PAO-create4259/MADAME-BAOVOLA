package model;

import utils.Utilitaires;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Depense {
    private int idDepense;
    private int idCategorie;
    private String nomCategorie;
    private double montant;
    private Timestamp dateDepense;
    private String description;

    public Depense() {}

    
    public int getIdDepense() { return idDepense; }
    public void setIdDepense(int idDepense) { this.idDepense = idDepense; }

    public int getIdCategorie() { return idCategorie; }
    public void setIdCategorie(int idCategorie) { this.idCategorie = idCategorie; }
    
    public String getNomCategorie() { return nomCategorie; }
    public void setNomCategorie(String nomCategorie) { this.nomCategorie = nomCategorie; }
    
    public double getMontant() { return montant; }
    public void setMontant(double montant) { this.montant = montant; }
    
    public Timestamp getDateDepense() { return dateDepense; }
    public void setDateDepense(Timestamp dateDepense) { this.dateDepense = dateDepense; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getMontantFormate() { return Utilitaires.formaterNombre(this.montant); }
    
    public String getDateFormatee() {
        return this.dateDepense != null ? new SimpleDateFormat("dd/MM/yyyy").format(this.dateDepense) : "";
    }
}