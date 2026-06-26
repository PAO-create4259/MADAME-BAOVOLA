package controller;

import dao.CommandeDAO;
import model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CommandeController", urlPatterns = {"/confirmer-commande"})
public class CommandeController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("clientConnecte");

        // Sécurité : On vérifie que le client est bien connecté
        if (client == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        // On récupère les tableaux envoyés par le Javascript
        String[] idCategories = request.getParameterValues("idCategorie[]");
        String[] quantites = request.getParameterValues("quantite[]");
        String[] prixUnitaires = request.getParameterValues("prixUnitaire[]");

        // On récupère les informations globales
        boolean avecRecuperation = Boolean.parseBoolean(request.getParameter("avecRecuperation"));
        String adresse = request.getParameter("adresse");
        String telephone = request.getParameter("telephone");
        double montantTotal = Double.parseDouble(request.getParameter("montantTotal"));
        double prixLivraison = Double.parseDouble(request.getParameter("prixLivraison"));

        CommandeDAO commandeDAO = new CommandeDAO();
        boolean succes = commandeDAO.creerCommande(
                client, idCategories, quantites, prixUnitaires,
                avecRecuperation, adresse, telephone, montantTotal, prixLivraison
        );

        // On renvoie un code de statut au Javascript pour qu'il affiche le Toast ou une erreur
        if (succes) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}