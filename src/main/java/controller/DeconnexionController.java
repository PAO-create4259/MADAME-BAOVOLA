package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DeconnexionController", urlPatterns = {"/deconnexion"})
public class DeconnexionController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // On récupère la session actuelle. Le "false" évite d'en créer une nouvelle si elle n'existe pas.
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Invalidate détruit la session et vide toutes les données qu'elle contient
            session.invalidate();
        }

        // Une fois déconnecté, on redirige vers l'accueil
        response.sendRedirect(request.getContextPath() + "/");
    }
}