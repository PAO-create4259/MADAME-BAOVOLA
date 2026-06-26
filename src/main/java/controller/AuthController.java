package controller;

import dao.ClientDAO;
import model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AuthController", urlPatterns = {"/login"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Affiche la page de login à l'intérieur du layout
        request.setAttribute("pageClient", "login");
        this.getServletContext().getRequestDispatcher("/pages/client/layout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String telephone = request.getParameter("telephone");

        ClientDAO clientDAO = new ClientDAO();
        HttpSession session = request.getSession();

        if ("verifierTelephone".equals(action)) {

            Client clientExistant = null;
            try {
                clientExistant = clientDAO.getByTelephone(telephone);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

            if (clientExistant != null) {
                session.setAttribute("clientConnecte", clientExistant);
                response.sendRedirect(request.getContextPath() + "/lavage");
            } else {
                request.setAttribute("telephoneNouveau", telephone);
                request.setAttribute("pageClient", "login");
                this.getServletContext().getRequestDispatcher("/pages/client/layout.jsp").forward(request, response);
            }

        } else if ("inscrire".equals(action)) {
            String nom = request.getParameter("nom");
            String prenom = request.getParameter("prenom");

            Client nouveauClient = new Client();
            nouveauClient.setNom(nom);
            nouveauClient.setPrenom(prenom);
            nouveauClient.setTelephone(telephone);

            clientDAO.insert(nouveauClient);

            session.setAttribute("clientConnecte", nouveauClient);
            response.sendRedirect(request.getContextPath() + "/lavage");
        }
    }
}