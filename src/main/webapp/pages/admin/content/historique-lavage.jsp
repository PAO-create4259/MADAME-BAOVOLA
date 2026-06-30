<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-clock-history"></i> Historique — Linge terminé</h1>
</div>

<div class="content-area">
    <div class="section-label">Liste du linge terminé et annulé</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active" data-filter="all">Aujourd'hui</button>
        <button class="btn btn-filter" data-filter="date">Par date</button>
        <button class="btn btn-filter" data-filter="client">Par client</button>
        <button class="btn btn-filter" data-filter="termine">Terminé</button>
        <button class="btn btn-filter" data-filter="annule">Annulé</button>
        <input type="text" id="searchInput" class="form-control search-box" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° de suivi</th>
                <th>Client (tél / ordre)</th>
                <th>Qté linge</th>
                <th>Prix total</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody id="lavageTableBody">
            <%
                java.util.List<model.Lavage> historiqueLavages = (java.util.List<model.Lavage>) request.getAttribute("historiqueLavages");
                if (historiqueLavages != null && !historiqueLavages.isEmpty()) {
                    for (model.Lavage lavage : historiqueLavages) {
            %>
            <tr data-date="<%= lavage.getDateFormatee().split(" ")[0] %>"
                data-statut="<%= lavage.getStatut().toLowerCase() %>"
                data-client="<%= lavage.getIdClient() %>"
                data-recherche="<%= lavage.getIdLavage() %> <%= lavage.getIdClient() %>">
                <td><%= lavage.getDateFormatee() %></td>
                <td><%= lavage.getIdLavage() %></td>
                <td><%= lavage.getIdClient() %></td>
                <td><%= lavage.getDetails() != null ? lavage.getDetails().size() : 0 %> pcs</td>
                <td><%= lavage.getPrixFormate() %> Ar</td>
                <td><span class="badge-status <%= "Annulé".equals(lavage.getStatut()) ? "badge-annule" : "badge-termine" %>"><%= lavage.getStatut() %></span></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" class="text-center">Aucun historique disponible</td>
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
        const searchInput = document.getElementById('searchInput');
        const tableRows = document.querySelectorAll('#lavageTableBody tr');

        // Get today's date
        const today = new Date().toLocaleDateString('fr-FR');

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
                    if (activeFilter === 'termine' && statut !== 'prêt à récupérer' && statut !== 'linge récupéré') {
                        show = false;
                    }
                    if (activeFilter === 'annule' && statut !== 'annulé') {
                        show = false;
                    }
                }

                row.style.display = show ? '' : 'none';
            });
        }
    });
</script>