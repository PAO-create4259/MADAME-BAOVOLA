package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "ClientController", urlPatterns = {"/"})
public class ClientController extends HttpServlet {

    private static final List<String> PAGES_AUTORISEES = Arrays.asList(
            "accueil", "tarif", "apropos","lavage"
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        // 1. On laisse passer les fichiers CSS, JS et images
        if (path != null && path.startsWith("/assets/")) {
            // "default" permet de rendre la main au serveur (Tomcat) pour gérer les fichiers statiques
            request.getServletContext().getNamedDispatcher("default").forward(request, response);
            return; // On arrête l'exécution ici pour ne pas charger le layout
        }

        String page = "accueil";

        if (path != null && path.length() > 1) {
            page = path.substring(1);
        }

        if (!PAGES_AUTORISEES.contains(page)) {
            page = "accueil";
        }

        request.setAttribute("pageClient", page);
        this.getServletContext().getRequestDispatcher("/pages/client/layout.jsp").forward(request, response);
    }
}