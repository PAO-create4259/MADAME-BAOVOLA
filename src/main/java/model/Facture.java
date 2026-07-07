package model;

import java.sql.Date;

public class Facture {
    String idFacture;
    Lavage lavage;
    Date dateFacture;
    double montantTotal;
    boolean paye;

    public Facture() {}

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    public Lavage getLavage() {
        return lavage;
    }

    public void setLavage(Lavage lavage) {
        this.lavage = lavage;
    }

    public Date getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(Date dateFacture) {
        this.dateFacture = dateFacture;
    }

    public double getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(double montantTotal) {
        this.montantTotal = montantTotal;
    }

    public boolean isPaye() {
        return paye;
    }

    public void setPaye(boolean paye) {
        this.paye = paye;
    }
}
