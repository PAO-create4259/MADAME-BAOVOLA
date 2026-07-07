package controller;

import dao.DepenseDAO;
import dao.FactureDAO;
import dao.LavageDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "AdminActionController", urlPatterns = {"/admin/action"})
public class AdminActionController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("utilisateur") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); return;
        }

        String action = request.getParameter("action");
        if (action == null) { response.setStatus(HttpServletResponse.SC_BAD_REQUEST); return; }

        boolean succes;
        switch (action) {
            case "recuperer": succes = new LavageDAO().changerStatut(request.getParameter("idLavage"), "Linge récupéré"); break;
            case "laver": succes = new LavageDAO().changerStatut(request.getParameter("idLavage"), "En lavage"); break;
            case "terminer": succes = new LavageDAO().changerStatut(request.getParameter("idLavage"), "Prêt à récupérer"); break;
            case "annuler": succes = new LavageDAO().changerStatut(request.getParameter("idLavage"), "Annulé"); break;

            case "payer" : succes = new FactureDAO().updateStatut(request.getParameter("idLavage"), "Payé"); break;

            case "ajouterDepense": succes = ajouterDepense(request); break;
            case "assignerLivreur":
                succes = new dao.LivraisonDAO().assignerLivreur(
                        request.getParameter("type"), request.getParameter("idRecord"), request.getParameter("idLivreur"));
                break;
            case "modifierTarifLivraison": succes = modifierTarifLivraison(request); break;
            case "modifierPrixVetement": succes = modifierPrixVetement(request); break;
            default: response.setStatus(HttpServletResponse.SC_BAD_REQUEST); return;
        }
        response.setStatus(succes ? HttpServletResponse.SC_OK : HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }

    private boolean ajouterDepense(HttpServletRequest request) {
        try {
            int idCategorie = Integer.parseInt(request.getParameter("idCategorie"));
            double montant = Double.parseDouble(request.getParameter("montant"));
            String description = request.getParameter("description");
            String dateStr = request.getParameter("dateDepense");
            java.sql.Date date = (dateStr != null && !dateStr.isEmpty())
                    ? java.sql.Date.valueOf(dateStr) : new java.sql.Date(System.currentTimeMillis());
            return new DepenseDAO().ajouterDepense(idCategorie, montant, description, date);
        } catch (IllegalArgumentException e) { return false; }
    }

    private boolean modifierTarifLivraison(HttpServletRequest request) {
        try {
            double prixUnitaire = Double.parseDouble(request.getParameter("prixUnitaire"));
            int partLivreur = Integer.parseInt(request.getParameter("partLivreur"));
            if (prixUnitaire < 0 || partLivreur < 0 || partLivreur > 100) return false;

            dao.TarifLivraisonDAO tarifDAO = new dao.TarifLivraisonDAO();
            model.TarifLivraison actuel = tarifDAO.getTarifActuel();
            model.TarifLivraison tarif = new model.TarifLivraison();
            tarif.setPrixUnitaire(prixUnitaire);
            tarif.setPartLivreur(partLivreur);
            if (actuel != null) { tarif.setIdTarifLivraison(actuel.getIdTarifLivraison()); return tarifDAO.update(tarif); }
            return tarifDAO.insert(tarif);
        } catch (NumberFormatException e) { return false; }
    }

    private boolean modifierPrixVetement(HttpServletRequest request) {
        try {
            int idTarif = Integer.parseInt(request.getParameter("idTarif"));
            double prix = Double.parseDouble(request.getParameter("prix"));
            return new dao.CategorieDAO().updatePrix(idTarif, prix);
        } catch (NumberFormatException e) { return false; }
    }
}