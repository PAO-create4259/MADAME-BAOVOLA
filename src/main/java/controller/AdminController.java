package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminController", urlPatterns = {"/admin/*"})
public class AdminController extends HttpServlet {

    private static final List<String> PAGES_AUTORISEES = Arrays.asList(
            "dashboard", "clients", "depenses", "statistiques",
            "tarifs", "suivi", "historique-lavage", "livraisons", "historique-livraison"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if(session.getAttribute("utilisateur") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        String pathInfo = request.getPathInfo();
        String page = "dashboard";

        if (pathInfo != null && pathInfo.length() > 1) {
            page = pathInfo.substring(1);
        }

        if (!PAGES_AUTORISEES.contains(page)) {
            page = "dashboard";
        }

        request.setAttribute("page", page);

        switch (page) {
            case "suivi":
                chargerSuivi(request);
                break;
            case "livraisons":
                chargerLivraisonsEnCours(request);
                break;
            case "historique-lavage":
                chargerHistoriqueLavage(request);
                break;
            case "historique-livraison":
                chargerHistoriqueLivraison(request);
                break;
            case "depenses":
                chargerDepenses(request);
                break;
            case "statistiques":
                chargerStatistiques(request);
                break;
            case "dashboard":
                chargerDashboard(request);
                break;
            case "tarifs":
                chargerTarifs(request);
                break;
        }

        this.getServletContext().getRequestDispatcher("/pages/admin/layout.jsp").forward(request, response);
    }

    private void chargerSuivi(HttpServletRequest request) {
        dao.LavageDAO lavageDAO = new dao.LavageDAO();
        request.setAttribute("lingeEnAttente", lavageDAO.getLingeEnAttenteRecuperation());
        request.setAttribute("lingeEnCours", lavageDAO.getLingeEnCoursTraitement());
    }

    // Page livraisons.jsp : suivi des livraisons/récupérations en cours
    private void chargerLivraisonsEnCours(HttpServletRequest request) {
        dao.LivraisonDAO livraisonDAO = new dao.LivraisonDAO();
        request.setAttribute("livraisonsEnCours", livraisonDAO.getLivraisonsEnCours());
    }

    // Page historique-lavage.jsp : déjà câblée à LavageDAO ailleurs (CommandeController),
    // ici on s'assure que le servlet la fournit aussi en accès direct (RG40)
    private void chargerHistoriqueLavage(HttpServletRequest request) {
        dao.LavageDAO lavageDAO = new dao.LavageDAO();
        request.setAttribute("historiqueLavages", lavageDAO.getAll());
    }

    private void chargerHistoriqueLivraison(HttpServletRequest request) {
        dao.LivraisonDAO livraisonDAO = new dao.LivraisonDAO();
        request.setAttribute("historiqueLivraisons", livraisonDAO.getHistoriqueLivraison());
    }

    // Page depenses.jsp : dépenses + consommations sur une période (RG31-RG37)
    private void chargerDepenses(HttpServletRequest request) {
        java.sql.Date[] periode = resoudrePeriode(request);
        dao.DepenseDAO depenseDAO = new dao.DepenseDAO();

        request.setAttribute("depenses", depenseDAO.getDepensesParPeriode(periode[0], periode[1]));
        request.setAttribute("totalDepenses", depenseDAO.getTotalParPeriode(periode[0], periode[1]));
        request.setAttribute("depensesParCategorie", depenseDAO.getTotalParCategorie(periode[0], periode[1]));
        request.setAttribute("categoriesDepense", depenseDAO.getCategoriesDepense());
        request.setAttribute("dateDebut", periode[0].toString());
        request.setAttribute("dateFin", periode[1].toString());
    }

    // Page statistiques.jsp : indicateurs clés de vente et bénéfices (RG36-RG39)
    private void chargerStatistiques(HttpServletRequest request) {
        java.sql.Date[] periode = resoudrePeriode(request);
        dao.StatistiqueDAO statDAO = new dao.StatistiqueDAO();
        dao.DepenseDAO depenseDAO = new dao.DepenseDAO();

        double chiffreAffaires = statDAO.getChiffreAffaires(periode[0], periode[1]);
        double depenses = depenseDAO.getTotalParPeriode(periode[0], periode[1]);

        request.setAttribute("nbLavages", statDAO.getNombreLavages(periode[0], periode[1]));
        request.setAttribute("chiffreAffaires", chiffreAffaires);
        request.setAttribute("totalDepenses", depenses);
        request.setAttribute("beneficeNet", chiffreAffaires - depenses); // RG38
        request.setAttribute("dateDebut", periode[0].toString());
        request.setAttribute("dateFin", periode[1].toString());

        // Évolution hebdomadaire (graphique) - point manquant signalé dans la liste "reste à faire"
        request.setAttribute("evolutionHebdo", statDAO.getEvolutionHebdomadaire(periode[0], periode[1]));
    }

    // Page dashboard.jsp : tableau de bord financier périodique (RG36-RG39)
    private void chargerDashboard(HttpServletRequest request) {
        java.sql.Date[] periode = resoudrePeriode(request);
        dao.StatistiqueDAO statDAO = new dao.StatistiqueDAO();
        dao.DepenseDAO depenseDAO = new dao.DepenseDAO();

        double chiffreAffaires = statDAO.getChiffreAffaires(periode[0], periode[1]);
        double depenses = depenseDAO.getTotalParPeriode(periode[0], periode[1]);

        request.setAttribute("chiffreAffaires", chiffreAffaires);
        request.setAttribute("totalDepenses", depenses);
        request.setAttribute("beneficeNet", chiffreAffaires - depenses); // RG38
        request.setAttribute("dateDebut", periode[0].toString());
        request.setAttribute("dateFin", periode[1].toString());
    }

    // Page tarifs.jsp : frais de livraison/récupération + gestion des livreurs et commissions (RG30)
    private void chargerTarifs(HttpServletRequest request) {
        // Prix par vêtement (table tarif/categorie), connecté au formulaire de tarifs.jsp
        request.setAttribute("categoriesTarifs", new dao.CategorieDAO().getAllCached());

        dao.TarifLivraisonDAO tarifDAO = new dao.TarifLivraisonDAO();
        request.setAttribute("tarifLivraison", tarifDAO.getTarifActuel());

        dao.LivraisonDAO livraisonDAO = new dao.LivraisonDAO();
        request.setAttribute("livraisonsNonAssignees", livraisonDAO.getEnAttenteAssignation());

        dao.UtilisateurDAO utilisateurDAO = new dao.UtilisateurDAO();
        request.setAttribute("livreurs", utilisateurDAO.getLivreurs());

        java.sql.Date[] periode = resoudrePeriode(request);
        request.setAttribute("commissionsParLivreur", livraisonDAO.getCommissionsParLivreur(periode[0], periode[1]));
        request.setAttribute("dateDebut", periode[0].toString());
        request.setAttribute("dateFin", periode[1].toString());

        // Suivi des coûts d'entretien (motos/machines) : catégorie de dépense dédiée
        dao.DepenseDAO depenseDAO = new dao.DepenseDAO();
        request.setAttribute("entretien", depenseDAO.getDepensesParPeriode(periode[0], periode[1]));
    }

    // Résout la période demandée via les paramètres ?debut=YYYY-MM-DD&fin=YYYY-MM-DD,
    // par défaut : du premier jour du mois courant à aujourd'hui.
    private java.sql.Date[] resoudrePeriode(HttpServletRequest request) {
        String debutParam = request.getParameter("debut");
        String finParam = request.getParameter("fin");

        try {
            if (debutParam != null && !debutParam.isEmpty() && finParam != null && !finParam.isEmpty()) {
                return new java.sql.Date[]{ java.sql.Date.valueOf(debutParam), java.sql.Date.valueOf(finParam) };
            }
        } catch (IllegalArgumentException ignored) {
            // Format invalide -> on retombe sur la période par défaut
        }

        java.time.LocalDate aujourdHui = java.time.LocalDate.now();
        java.sql.Date debut = java.sql.Date.valueOf(aujourdHui.withDayOfMonth(1));
        java.sql.Date fin = java.sql.Date.valueOf(aujourdHui);
        return new java.sql.Date[]{ debut, fin };
    }
}