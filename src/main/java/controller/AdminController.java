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

        this.getServletContext().getRequestDispatcher("/pages/admin/layout.jsp").forward(request, response);
    }
}