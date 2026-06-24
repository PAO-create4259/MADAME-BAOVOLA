package controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminController", urlPatterns = {"/admin/*"})
public class AdminController extends HttpServlet {

    // On déplace la liste blanche ici pour sécuriser côté serveur
    private static final List<String> PAGES_AUTORISEES = Arrays.asList(
            "dashboard", "clients", "depenses", "statistiques",
            "tarifs", "suivi", "historique-lavage", "livraisons", "historique-livraison"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Récupérer la fin de l'URL (ex: "/clients" devient "clients")
        String pathInfo = request.getPathInfo();
        String page = "dashboard"; // Page par défaut

        if (pathInfo != null && pathInfo.length() > 1) {
            page = pathInfo.substring(1);
        }

        // 2. Vérifier si la page demandée est dans la liste blanche
        if (!PAGES_AUTORISEES.contains(page)) {
            page = "dashboard";
        }

        // 3. Envoyer la variable "page" à la vue (layout.jsp)
        request.setAttribute("page", page);

        // 4. Faire suivre la requête vers le fichier layout.jsp physique
        this.getServletContext().getRequestDispatcher("/pages/admin/layout.jsp").forward(request, response);
    }
}