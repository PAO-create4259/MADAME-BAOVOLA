package model;

import java.time.LocalDateTime;

public class Lavage {
    private String        idLavage;
    private String        idClient;
    private LocalDateTime dateCommande;
    private String        statut;
    private LocalDateTime dateRetrait;

    public Lavage() {
    }

    public Lavage(String idLavage, String idClient, LocalDateTime dateCommande, String statut, LocalDateTime dateRetrait) {
        this.setIdLavage(idLavage);
        this.setIdClient(idClient);
        this.setDateCommande(dateCommande);
        this.setStatut(statut);
        this.setDateRetrait(dateRetrait);
    }

    public String getIdLavage() { return idLavage; }
    public void setIdLavage(String idLavage) { this.idLavage = idLavage; }

    public String getIdClient() { return idClient; }
    public void setIdClient(String idClient) { this.idClient = idClient; }

    public LocalDateTime getDateCommande() { return dateCommande; }
    public void setDateCommande(LocalDateTime dateCommande) { this.dateCommande = dateCommande; }

    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }

    public LocalDateTime getDateRetrait() { return dateRetrait; }
    public void setDateRetrait(LocalDateTime dateRetrait) { this.dateRetrait = dateRetrait; }
}
