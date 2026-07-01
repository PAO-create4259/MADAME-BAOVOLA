package controller;

import dao.LivraisonDAO;
import model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "ChoixLivraisonController", urlPatterns = {"/choix-livraison"})
public class ChoixLivraisonController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client client = (Client) session.getAttribute("clientConnecte");
        if (client == null) { response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); return; }

        String idLavage = request.getParameter("idLavage");
        String mode = request.getParameter("mode"); // "domicile" ou "surplace"
        if (idLavage == null || idLavage.trim().isEmpty()) { response.setStatus(HttpServletResponse.SC_BAD_REQUEST); return; }

        LivraisonDAO livraisonDAO = new LivraisonDAO();
        dao.LavageDAO lavageDAO = new dao.LavageDAO();

        if (livraisonDAO.existeLivraison(idLavage)) { response.setStatus(HttpServletResponse.SC_CONFLICT); return; }

        model.Lavage lavageActuel = lavageDAO.getLavageCompletById(idLavage);
        if (lavageActuel != null && lavageActuel.getModeRetrait() != null) {
            response.setStatus(HttpServletResponse.SC_CONFLICT); return;
        }

        if ("domicile".equals(mode)) {
            String adresse = request.getParameter("adresse");
            String telephone = "autre".equals(request.getParameter("choixNumero"))
                    ? request.getParameter("autreNumero") : client.getTelephone();
            boolean succes = livraisonDAO.enregistrerLivraison(idLavage, adresse, telephone, null);
            if (succes) lavageDAO.definirModeRetrait(idLavage, "domicile");
            response.setStatus(succes ? HttpServletResponse.SC_OK : HttpServletResponse.SC_BAD_REQUEST);

        } else if ("surplace".equals(mode)) {
            boolean succes = lavageDAO.definirModeRetrait(idLavage, "sur_place");
            response.setStatus(succes ? HttpServletResponse.SC_OK : HttpServletResponse.SC_CONFLICT);

        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}