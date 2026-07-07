<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Lavage" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title">Suivi en cours</h1>
</div>

<div class="content-area">

    <!-- Section 1: Linge en attente -->
    <div class="section-label">Linge en attente de récupération</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <input type="text" class="form-control search-box" data-target="tableAttente" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° de suivi</th>
                <th>Client</th>
                <th>Qté linge</th>
                <th>Prix total</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody id="tableAttente">
            <%
                List<Lavage> lingeEnAttente = (List<Lavage>) request.getAttribute("lingeEnAttente");
                if (lingeEnAttente != null && !lingeEnAttente.isEmpty()) {
                    for (Lavage l : lingeEnAttente) {
                        String dateLavage = l.getDateFormatee().split(" ")[0];
            %>
            <tr data-recherche="<%= l.getIdLavage() %> <%= l.getIdClient() %>">
                <td><%= dateLavage %></td>
                <td><%= l.getIdLavage() %></td>
                <td><%= l.getIdClient() %></td>
                <td><%= l.getQuantiteLinge() %> pcs</td>
                <td><%= l.getPrixFormate() %> Ar</td>
                <td><button class="btn btn-recuperer" data-id="<%= l.getIdLavage() %>" data-action="recuperer">Récupérer</button></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="6" class="text-center">Aucun linge en attente de récupération</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <div class="info-note" style="margin-top:-22px; margin-bottom:20px;">
        ℹ️ Cliquer « Récupérer » déplace la ligne vers la section ci-dessous.
    </div>

    <!-- Section 2: Linge récupéré -->
    <div class="section-label">Linge récupéré — en cours de traitement</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <input type="text" class="form-control search-box" data-target="tableEnCours" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° de suivi</th>
                <th>Client</th>
                <th>Qté linge</th>
                <th>Prix total</th>
                <th>Statut</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="tableEnCours">
            <%
                List<Lavage> lingeEnCours = (List<Lavage>) request.getAttribute("lingeEnCours");
                if (lingeEnCours != null && !lingeEnCours.isEmpty()) {
                    for (Lavage l : lingeEnCours) {
                        String dateLavage = l.getDateFormatee().split(" ")[0];
                        String statutActuel = l.getStatut();
                        String badge = "En lavage".equals(statutActuel) ? "badge-cours" : "badge-attente";

                        String btnLaverDisabled = "En lavage".equals(statutActuel) ? "disabled" : "";
                        String btnTerminerDisabled = !"En lavage".equals(statutActuel) ? "disabled" : "";
            %>
            <tr data-recherche="<%= l.getIdLavage() %> <%= l.getIdClient() %>">
                <td><%= dateLavage %></td>
                <td><%= l.getIdLavage() %></td>
                <td><%= l.getIdClient() %></td>
                <td><%= l.getQuantiteLinge() %> pcs</td>
                <td><%= l.getPrixFormate() %> Ar</td>
                <td><span class="badge-status <%= badge %>"><%= statutActuel %></span></td>
                <td>
                    <button class="btn btn-action btn-laver" data-id="<%= l.getIdLavage() %>" data-action="laver" <%= btnLaverDisabled %>>Laver</button>
                    <button class="btn btn-action btn-terminer" data-id="<%= l.getIdLavage() %>" data-action="terminer" <%= btnTerminerDisabled %>>Terminer</button>
                    <button class="btn btn-action btn-annuler" data-id="<%= l.getIdLavage() %>" data-action="annuler">Annuler</button>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="7" class="text-center">Aucun linge en cours de traitement</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Boutons d'action (Récupérer / Laver / Terminer / Annuler) -> appel AJAX vers /admin/action
        document.querySelectorAll('button[data-action]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                const idLavage = this.getAttribute('data-id');
                const action = this.getAttribute('data-action');

                fetch('<%= request.getContextPath() %>/admin/action', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=' + encodeURIComponent(action) + '&idLavage=' + encodeURIComponent(idLavage)
                }).then(function (resp) {
                    if (resp.ok) {
                        location.reload();
                    } else {
                        alert("Une erreur est survenue, veuillez réessayer.");
                    }
                });
            });
        });

        // Recherche texte par tableau
        document.querySelectorAll('.search-box[data-target]').forEach(function (input) {
            input.addEventListener('input', function () {
                const term = this.value.toLowerCase();
                const target = this.getAttribute('data-target');
                document.querySelectorAll('#' + target + ' tr').forEach(function (row) {
                    const recherche = row.getAttribute('data-recherche');
                    row.style.display = (!recherche || recherche.toLowerCase().includes(term)) ? '' : 'none';
                });
            });
        });
    });
</script>
