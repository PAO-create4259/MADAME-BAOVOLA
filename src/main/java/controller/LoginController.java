package controller;

import dao.UtilisateurDAO;
import model.Utilisateur;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/admin/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameForm = request.getParameter("username");
        String passwordForm = request.getParameter("password");

        UtilisateurDAO utilisateurDAO = new UtilisateurDAO();
        Utilisateur utilisateur = null;

        try {
            utilisateur = utilisateurDAO.getByUsername(usernameForm);
        } catch (SQLException e) {
            System.out.println("Erreur SQL détéctée :");
            e.printStackTrace();
        }

        if (utilisateur != null && utilisateur.getMotDePasse().equals(passwordForm)) {

            HttpSession session = request.getSession();
            session.setAttribute("utilisateur", utilisateur);

            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } else {
            request.setAttribute("erreur", "Nom d'utilisateur ou mot de passe incorrect.");

            this.getServletContext().getRequestDispatcher("/pages/admin/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.getServletContext().getRequestDispatcher("/pages/admin/login.jsp").forward(request, response);
    }
}