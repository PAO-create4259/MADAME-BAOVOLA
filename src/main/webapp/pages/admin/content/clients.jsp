<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Client" %>
<%@ page import="dao.LavageDAO" %>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-person-lines-fill"></i> Liste des clients</h1>
</div>

<div class="content-area">
    <div class="section-label">Tous les clients enregistrés</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <a href="${pageContext.request.contextPath}/admin/clients?filtre=tous"
           class="btn btn-filter active">Tous</a>

        <a href="${pageContext.request.contextPath}/admin/clients?filtre=nom"
           class="btn btn-filter">Par nom</a>

        <a href="${pageContext.request.contextPath}/admin/clients?filtre=telephone"
           class="btn btn-filter">Par téléphone</a>

        <span class="label">Rechercher :</span>

        <form class="d-flex gap-2" action="${pageContext.request.contextPath}/admin/clients" method="get">
            <input type="hidden" name="filtre" value="telephone">
            <input
                    type="text"
                    name="telephone"
                    class="form-control search-box"
                    placeholder="Entrer le numéro complet">

            <button type="submit" class="btn btn-filter" style="background-color: #111; color: white;">
                Rechercher
            </button>
        </form>
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom & Prénom</th>
                <th>Téléphone</th>
                <th>Lavages terminés</th>
                <th>En cours</th>
            </tr>
            </thead>
            <tbody>

            <%
                List<Client> listeClients = (List<Client>) request.getAttribute("clients");
                LavageDAO daoLavage = (LavageDAO) request.getAttribute("lavageDAO");

                if (listeClients != null) {
                    for (Client client : listeClients) {
            %>
            <tr>
                <td><%= client.getIdClient() %></td>
                <td><%= client.getNom() %> <%= client.getPrenom() %></td>
                <td><%= client.getTelephone() %></td>
                <td>
                    <%= daoLavage.countTermines(client.getIdClient()) %>
                </td>
                <td>
                    <%= daoLavage.countEnCours(client.getIdClient()) %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center text-muted">Aucun client trouvé.</td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
    </div>
</div>