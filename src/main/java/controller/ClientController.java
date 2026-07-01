package controller;

import dao.CategorieDAO;
import dao.LavageDAO;
import dao.LivraisonDAO;
import dao.TarifLivraisonDAO;
import model.Lavage;
import model.TarifLivraison;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ClientController", urlPatterns = {"/"})
public class ClientController extends HttpServlet {

    private static final List<String> PAGES_AUTORISEES = Arrays.asList(
            "accueil", "tarif", "apropos", "lavage", "profil", "detail", "recapitulatif"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        if (path != null && path.startsWith("/assets/")) {
            // "default" permet de rendre la main au serveur (Tomcat) pour gérer les fichiers statiques
            request.getServletContext().getNamedDispatcher("default").forward(request, response);
            return;
        }

        String page = "accueil";

        if (path != null && path.length() > 1) {
            page = path.substring(1);
        }

        if (!PAGES_AUTORISEES.contains(page)) {
            page = "accueil";
        }

        HttpSession session = request.getSession();

        if ("lavage".equals(page) && session.getAttribute("clientConnecte") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if ("tarif".equals(page) || "lavage".equals(page)) {

            CategorieDAO categorieDAO = new CategorieDAO();

            // On utilise la méthode avec cache au lieu du getAll() classique !
            request.setAttribute("categories", categorieDAO.getAllCached());

            TarifLivraisonDAO tarifLivraisonDAO = new TarifLivraisonDAO();
            model.TarifLivraison tarifActuel = tarifLivraisonDAO.getTarifActuel();
            request.setAttribute("prixLivraison", (tarifActuel != null) ? tarifActuel.getPrixUnitaire() : 0.0);
        }

//        if ("lavage".equals(page) || "tarif".equals(page)) {
//            CategorieDAO categorieDAO = new CategorieDAO();
//            request.setAttribute("categories", categorieDAO.getAll());
//
//            TarifLivraisonDAO tarifLivraisonDAO = new TarifLivraisonDAO();
//            TarifLivraison tarifActuel = tarifLivraisonDAO.getTarifActuel();
//
//            double prixLivraison = (tarifActuel != null) ? tarifActuel.getPrixUnitaire() : 0.0;
//            request.setAttribute("prixLivraison", prixLivraison);
//        }

        if ("profil".equals(page)) {
            if (session.getAttribute("clientConnecte") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            model.Client clientConnecte = (model.Client) session.getAttribute("clientConnecte");
            dao.LavageDAO lavageDAO = new dao.LavageDAO();

            request.setAttribute("mesLavages", lavageDAO.getLavagesByClient(clientConnecte.getIdClient()));
        }

        // ON CHARGE LES DONNÉES POUR LA PAGE DÉTAIL
        if ("detail".equals(page)) {
            if (session.getAttribute("clientConnecte") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String idLavage = request.getParameter("id");
            if (idLavage != null && !idLavage.trim().isEmpty()) {
                LavageDAO lavageDAO = new dao.LavageDAO();
                Lavage lavageActuel = lavageDAO.getLavageCompletById(idLavage);
                request.setAttribute("lavageDetail", lavageActuel);

                LivraisonDAO livraisonDAO = new LivraisonDAO();
                request.setAttribute("livraisonExiste", livraisonDAO.existeLivraison(idLavage));
            } else {
                // Si pas d'ID, on renvoie vers le profil
                response.sendRedirect(request.getContextPath() + "/profil");
                return;
            }
        }

        request.setAttribute("pageClient", page);
        this.getServletContext().getRequestDispatcher("/pages/client/layout.jsp").forward(request, response);
    }
}