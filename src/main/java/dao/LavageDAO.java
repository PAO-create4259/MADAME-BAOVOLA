package dao;

import model.Lavage;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class LavageDAO extends BaseDAO<Lavage> {

    @Override
    protected String getNomTable() {
        return "lavage";
    }

    @Override
    protected String getNomId() {
        return "id_lavage";
    }

    @Override
    protected Lavage mapResultSet(ResultSet rs) throws SQLException {
        Lavage lavage = new Lavage();
        lavage.setIdLavage(rs.getString("id_lavage"));
        lavage.setIdClient(rs.getString("id_client"));

        // Conversion du Timestamp SQL vers LocalDateTime Java
        Timestamp tsCommande = rs.getTimestamp("date_commande");
        if (tsCommande != null) {
            lavage.setDateCommande(tsCommande.toLocalDateTime());
        }

        lavage.setStatut(rs.getString("statut"));

        Timestamp tsRetrait = rs.getTimestamp("date_retrait");
        if (tsRetrait != null) {
            lavage.setDateRetrait(tsRetrait.toLocalDateTime());
        }

        return lavage;
    }

    @Override
    protected String getRequeteInsert() {
        // L'identifiant et la date de commande sont gérés par la base de données
        return "INSERT INTO lavage (id_client, statut) VALUES (?, ?)";
    }

    @Override
    protected void parametrerInsert(PreparedStatement ps, Lavage objet) throws SQLException {
        ps.setString(1, objet.getIdClient());
        ps.setString(2, objet.getStatut());
    }

    @Override
    protected String getRequeteUpdate() {
        return "UPDATE lavage SET id_client = ?, statut = ?, date_retrait = ? WHERE id_lavage = ?";
    }

    @Override
    protected void parametrerUpdate(PreparedStatement ps, Lavage objet) throws SQLException {
        ps.setString(1, objet.getIdClient());
        ps.setString(2, objet.getStatut());

        // Gestion de la date de retrait qui peut être vide (null)
        if (objet.getDateRetrait() != null) {
            ps.setTimestamp(3, Timestamp.valueOf(objet.getDateRetrait()));
        } else {
            ps.setNull(3, java.sql.Types.TIMESTAMP);
        }

        ps.setString(4, objet.getIdLavage());
    }
}