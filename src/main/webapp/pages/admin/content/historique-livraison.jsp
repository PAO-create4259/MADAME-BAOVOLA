<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>


<div class="topbar">
    <h1 class="page-title"><i class="bi bi-truck"></i> Historique — Livraisons</h1>
</div>

<div class="content-area">

    <div class="section-label">Historique complet des livraisons et récupérations</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active" data-filter="all">Période</button>
        <button class="btn btn-filter" data-filter="date">Par date</button>
        <button class="btn btn-filter" data-filter="client">Par client</button>
        <button class="btn btn-filter" data-filter="adresse">Par adresse</button>
        <button class="btn btn-filter" data-filter="livraison">Par N° suivi</button>
        <button class="btn btn-filter" data-filter="recupere">Récupéré</button>
        <button class="btn btn-filter" data-filter="livre">Livré</button>
        <input type="text" id="searchInputLivraison" class="form-control search-box" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° client</th>
                <th>Tél contact livreur</th>
                <th>Adresse</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody id="livraisonTableBody">
            <%
                java.util.List<model.LivraisonHistorique> historiqueLivraisons =
                        (java.util.List<model.LivraisonHistorique>) request.getAttribute("historiqueLivraisons");
                if (historiqueLivraisons != null && !historiqueLivraisons.isEmpty()) {
                    for (model.LivraisonHistorique hist : historiqueLivraisons) {
            %>
            <tr data-date="<%= hist.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(hist.getDate()) : "" %>"
                data-statut="<%= hist.getStatut().toLowerCase() %>"
                data-recherche="<%= hist.getIdLavage() %> <%= hist.getTelephone() %> <%= hist.getAdresse() %>">
                <td><%= hist.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(hist.getDate()) : "" %></td>
                <td><%= hist.getIdLavage() %></td>
                <td><%= hist.getTelephone() %></td>
                <td><%= hist.getAdresse() %></td>
                <td><span class="badge-status <%= "Livré".equals(hist.getStatut()) ? "status-livre" : "status-recupere" %>">
                    <i class="bi <%= "Livré".equals(hist.getStatut()) ? "bi-check-circle" : "bi-arrow-up-circle" %>"></i>
                    <%= hist.getStatut() %>
                </span></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5" class="text-center">Aucun historique disponible</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const filterButtons = document.querySelectorAll('.btn-filter');
        const searchInput = document.getElementById('searchInputLivraison');
        const tableRows = document.querySelectorAll('#livraisonTableBody tr');

        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                filterButtons.forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                applyFilters();
            });
        });

        searchInput.addEventListener('input', applyFilters);

        function applyFilters() {
            const activeFilter = document.querySelector('.btn-filter.active').getAttribute('data-filter');
            const searchTerm = searchInput.value.toLowerCase();

            tableRows.forEach(row => {
                let show = true;

                // Apply search filter
                if (searchTerm && row.getAttribute('data-recherche')) {
                    if (!row.getAttribute('data-recherche').toLowerCase().includes(searchTerm)) {
                        show = false;
                    }
                }

                // Apply statut filter
                if (show && activeFilter !== 'all') {
                    const statut = row.getAttribute('data-statut');
                    if (activeFilter === 'recupere' && statut !== 'récupéré') {
                        show = false;
                    }
                    if (activeFilter === 'livre' && statut !== 'livré') {
                        show = false;
                    }
                }

                row.style.display = show ? '' : 'none';
            });
        }
    });
</script>