package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", urlPatterns = {"/admin/logout"})
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // On récupère la session actuelle
        HttpSession session = request.getSession();

        // On détruit la session (supprime toutes les données, y compris l'utilisateur)
        session.invalidate();

        // On renvoie vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/admin/login");
    }
}