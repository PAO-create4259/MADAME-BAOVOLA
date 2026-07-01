package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Supabase
//    private static final String URL = "jdbc:postgresql://aws-0-eu-west-1.pooler.supabase.com:5432/postgres?user=postgres.uwdadgpjwbrodbvlqvfv&password=CleanCare2026";
//    private static final String UTILISATEUR = "postgres";
//    private static final String MOT_DE_PASSE = "CleanCare2026";

    // Local
    private static final String URL = "jdbc:postgresql://localhost:5432/cleancareclothes";
    private static final String UTILISATEUR = "postgres";
    private static final String MOT_DE_PASSE = "130601";

    public static Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection(URL, UTILISATEUR, MOT_DE_PASSE);
            System.out.println("Connexion reussie à la base de donnees !");
        } catch (ClassNotFoundException e) {
            System.err.println("Erreur : Le pilote PostgreSQL est introuvable.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Erreur : Impossible de se connecter a la base de donnees.");
            e.printStackTrace();
        }
        return connection;
    }
}