package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/cleancareclothes";
    private static final String UTILISATEUR = "postgres";
    private static final String MOT_DE_PASSE = "130601";

    /**
     * Méthode pour obtenir la connexion à la base de données
     * @return Connection
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");

            connection = DriverManager.getConnection(URL, UTILISATEUR, MOT_DE_PASSE);
            System.out.println("Connexion réussie à la base de données !");

        } catch (ClassNotFoundException e) {
            System.err.println("Erreur : Le pilote PostgreSQL est introuvable.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Erreur : Impossible de se connecter à la base de données.");
            e.printStackTrace();
        }
        return connection;
    }
}