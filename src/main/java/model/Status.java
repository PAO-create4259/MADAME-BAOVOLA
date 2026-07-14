package model;

public enum Status {
    LIVRE("Livré"),
    RECUPERE("Récupéré"),
    RECUPERATION("Récupération"),
    LIVRAISON("Livraison"),
    EN_ATTENTE("En attente");

    private final String label;
    Status(String label) { this.label = label; }
    @Override public String toString(){ return label; }
    public String toLower(){ return label.toLowerCase(); }
}
