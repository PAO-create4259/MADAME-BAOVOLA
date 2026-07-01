<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.LivraisonHistorique" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-truck"></i> Livraisons &amp; Récupérations — En cours</h1>
</div>

<div class="content-area">
    <div class="section-label">Liste des livraisons et récupérations en cours de traitement</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active" data-filter="all">Tous</button>
        <button class="btn btn-filter" data-filter="récupéré">Récupéré</button>
        <button class="btn btn-filter" data-filter="livré">Livré</button>
        <input type="text" id="searchInputLivraisonsEnCours" class="form-control search-box" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° lavage</th>
                <th>Téléphone client</th>
                <th>Adresse</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody id="livraisonsEnCoursBody">
            <%
                List<LivraisonHistorique> livraisonsEnCours = (List<LivraisonHistorique>) request.getAttribute("livraisonsEnCours");
                if (livraisonsEnCours != null && !livraisonsEnCours.isEmpty()) {
                    for (LivraisonHistorique hist : livraisonsEnCours) {
            %>
            <tr data-statut="<%= hist.getStatut().toLowerCase() %>"
                data-recherche="<%= hist.getIdLavage() %> <%= hist.getTelephone() %> <%= hist.getAdresse() %>">
                <td><%= hist.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(hist.getDate()) : "" %></td>
                <td><%= hist.getIdLavage() %></td>
                <td><%= hist.getTelephone() %></td>
                <td><%= hist.getAdresse() %></td>
                <td><span class="badge-status <%= "Livré".equals(hist.getStatut()) ? "badge-livre" : "badge-recupere" %>">
                    <i class="bi <%= "Livré".equals(hist.getStatut()) ? "bi-check-circle" : "bi-arrow-up-circle" %>"></i>
                    <%= hist.getStatut() %>
                </span></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="5" class="text-center">Aucune livraison/récupération en cours</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const filterButtons = document.querySelectorAll('.btn-filter');
        const searchInput = document.getElementById('searchInputLivraisonsEnCours');
        const rows = document.querySelectorAll('#livraisonsEnCoursBody tr');

        filterButtons.forEach(function (btn) {
            btn.addEventListener('click', function () {
                filterButtons.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                applyFilters();
            });
        });
        if (searchInput) searchInput.addEventListener('input', applyFilters);

        function applyFilters() {
            const activeFilter = document.querySelector('.btn-filter.active').getAttribute('data-filter');
            const term = searchInput ? searchInput.value.toLowerCase() : '';
            rows.forEach(function (row) {
                let show = true;
                const recherche = row.getAttribute('data-recherche');
                if (term && recherche && !recherche.toLowerCase().includes(term)) show = false;
                if (show && activeFilter !== 'all' && row.getAttribute('data-statut') !== activeFilter) show = false;
                row.style.display = show ? '' : 'none';
            });
        }
    });
</script>
