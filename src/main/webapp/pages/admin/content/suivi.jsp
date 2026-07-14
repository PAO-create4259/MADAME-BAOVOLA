<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Lavage" %>
<%-- Fragment inclus dans layout.jsp --%>

<%
    // Optimisation : On déclare le formateur de date une seule fois pour la boucle
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-eye"></i> Suivi en cours</h1>
</div>

<div class="content-area">

    <!-- ========================================== -->
    <!-- SECTION 1 : LINGE EN ATTENTE               -->
    <!-- ========================================== -->
    <div class="section-label">Linge en attente de récupération</div>

    <div class="filter-bar d-flex flex-wrap align-items-center gap-2 mb-3">
        <span class="label">Recherche :</span>
        <input type="text" id="searchAttente" class="form-control search-box" placeholder="Client ou N°..." style="width: 200px;">

        <div class="vr mx-2"></div>

        <span class="label">Période :</span>
        <input type="date" id="dateDebutAttente" class="form-control search-box" style="width: auto;">
        <span>au</span>
        <input type="date" id="dateFinAttente" class="form-control search-box" style="width: auto;">
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
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="tableAttenteBody">
            <%
                List<Lavage> lingeEnAttente = (List<Lavage>) request.getAttribute("lingeEnAttente");
                if (lingeEnAttente != null && !lingeEnAttente.isEmpty()) {
                    for (Lavage l : lingeEnAttente) {
                        String dateLavage = l.getDateFormatee().split(" ")[0];
                        String dateIso = (l.getDateCommande() != null) ? sdf.format(l.getDateCommande()) : "";
            %>
            <tr class="row-attente" data-date="<%= dateIso %>" data-recherche="<%= l.getIdLavage().toLowerCase() %> <%= l.getIdClient().toLowerCase() %>">
                <td><%= dateLavage %></td>
                <td><%= l.getIdLavage() %></td>
                <td><%= l.getIdClient() %></td>
                <td><%= l.getQuantiteLinge() %> pcs</td>
                <td><%= l.getPrixFormate() %> Ar</td>
                <td>
                    <button class="btn btn-recuperer" data-id="<%= l.getIdLavage() %>" data-action="recuperer">Récupérer</button>
                    <button class="btn btn-action btn-annuler" data-id="<%= l.getIdLavage() %>" data-action="annuler">Annuler</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            <tr id="emptyAttente" style="display: none;">
                <td colspan="6" class="text-center">Aucun résultat trouvé</td>
            </tr>
            </tbody>
        </table>

        <!-- Pagination Table 1 -->
        <div class="d-flex justify-content-between align-items-center p-3 border-top">
            <span class="text-muted small" id="infoPaginationAttente"></span>
            <nav>
                <ul class="pagination pagination-sm mb-0" id="paginationAttente"></ul>
            </nav>
        </div>
    </div>

    <div class="info-note" style="margin-top:-22px; margin-bottom:20px;">
        <i class="bi bi-info-circle"></i> Cliquer « Récupérer » déplace la ligne vers la section ci-dessous. Les commandes récupérées ne peuvent plus être annulées.
    </div>

    <!-- ========================================== -->
    <!-- SECTION 2 : LINGE RÉCUPÉRÉ (EN COURS)      -->
    <!-- ========================================== -->
    <div class="section-label">Linge récupéré — en cours de traitement</div>

    <div class="filter-bar d-flex flex-wrap align-items-center gap-2 mb-3">
        <span class="label">Statut :</span>
        <button class="btn btn-filter btn-filter-cours active" data-filter="all">Tous</button>
        <button class="btn btn-filter btn-filter-cours" data-filter="linge récupéré">Récupéré</button>
        <button class="btn btn-filter btn-filter-cours" data-filter="en lavage">En lavage</button>

        <div class="vr mx-2"></div>

        <span class="label">Recherche :</span>
        <input type="text" id="searchCours" class="form-control search-box" placeholder="Client ou N°..." style="width: 200px;">

        <div class="vr mx-2"></div>

        <span class="label">Période :</span>
        <input type="date" id="dateDebutCours" class="form-control search-box" style="width: auto;">
        <span>au</span>
        <input type="date" id="dateFinCours" class="form-control search-box" style="width: auto;">
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
            <tbody id="tableCoursBody">
            <%
                List<Lavage> lingeEnCours = (List<Lavage>) request.getAttribute("lingeEnCours");
                if (lingeEnCours != null && !lingeEnCours.isEmpty()) {
                    for (Lavage l : lingeEnCours) {
                        String dateLavage = l.getDateFormatee().split(" ")[0];
                        String dateIso = (l.getDateCommande() != null) ? sdf.format(l.getDateCommande()) : "";
                        String statutActuel = l.getStatut();

                        String badge = "En lavage".equals(statutActuel) ? "badge-cours" : "badge-attente";
                        String btnLaverDisabled = "En lavage".equals(statutActuel) ? "disabled" : "";
                        String btnTerminerDisabled = !"En lavage".equals(statutActuel) ? "disabled" : "";
            %>
            <tr class="row-cours" data-date="<%= dateIso %>" data-statut="<%= statutActuel.toLowerCase() %>" data-recherche="<%= l.getIdLavage().toLowerCase() %> <%= l.getIdClient().toLowerCase() %>">
                <td><%= dateLavage %></td>
                <td><%= l.getIdLavage() %></td>
                <td><%= l.getIdClient() %></td>
                <td><%= l.getQuantiteLinge() %> pcs</td>
                <td><%= l.getPrixFormate() %> Ar</td>
                <td><span class="badge-status <%= badge %>"><%= statutActuel %></span></td>
                <td>
                    <button class="btn btn-action btn-laver" data-id="<%= l.getIdLavage() %>" data-action="laver" <%= btnLaverDisabled %>>Laver</button>
                    <button class="btn btn-action btn-terminer" data-id="<%= l.getIdLavage() %>" data-action="terminer" <%= btnTerminerDisabled %>>Terminer</button>
                </td>
            </tr>
            <%
                    }
                }
            %>
            <tr id="emptyCours" style="display: none;">
                <td colspan="7" class="text-center">Aucun résultat trouvé</td>
            </tr>
            </tbody>
        </table>

        <!-- Pagination Table 2 -->
        <div class="d-flex justify-content-between align-items-center p-3 border-top">
            <span class="text-muted small" id="infoPaginationCours"></span>
            <nav>
                <ul class="pagination pagination-sm mb-0" id="paginationCours"></ul>
            </nav>
        </div>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {

        // 1. Exécution des requêtes d'action AJAX
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

        // 2. Logique générique de Filtres et de Pagination pour éviter le code redondant
        function initTablePagination(config) {
            let currentPage = 1;
            const itemsPerPage = 5; // Modifiable selon tes besoins
            const rows = Array.from(document.querySelectorAll(config.rowSelector));
            let filteredRows = [...rows];

            const searchInput = document.getElementById(config.searchInput);
            const dateDebutInput = document.getElementById(config.dateDebut);
            const dateFinInput = document.getElementById(config.dateFin);
            const infoText = document.getElementById(config.infoId);
            const paginationUl = document.getElementById(config.paginationId);
            const emptyIndicator = document.getElementById(config.emptyId);

            function filterData() {
                const term = searchInput.value.toLowerCase();
                const startD = dateDebutInput.value;
                const endD = dateFinInput.value;

                let activeStatus = 'all';
                if (config.statusClass) {
                    const activeBtn = document.querySelector('.' + config.statusClass + '.active');
                    if (activeBtn) activeStatus = activeBtn.getAttribute('data-filter').toLowerCase();
                }

                filteredRows = rows.filter(function(row) {
                    let show = true;

                    // Filtre par recherche
                    if (term && row.getAttribute('data-recherche')) {
                        if (!row.getAttribute('data-recherche').includes(term)) show = false;
                    }

                    // Filtre par période de dates
                    const rowDate = row.getAttribute('data-date');
                    if (show && startD && rowDate < startD) show = false;
                    if (show && endD && rowDate > endD) show = false;

                    // Filtre par statut (Boutons)
                    if (show && activeStatus !== 'all') {
                        if (row.getAttribute('data-statut') !== activeStatus) show = false;
                    }

                    return show;
                });

                currentPage = 1;
                render();
            }

            function render() {
                const total = filteredRows.length;
                const totalPages = Math.ceil(total / itemsPerPage) || 1;

                if (currentPage > totalPages) currentPage = totalPages;
                if (currentPage < 1) currentPage = 1;

                // Masquer toutes les lignes
                rows.forEach(function(r) { r.style.display = 'none'; });

                if (total === 0) {
                    emptyIndicator.style.display = '';
                    infoText.innerText = "Aucun résultat";
                    paginationUl.innerHTML = '';
                    return;
                } else {
                    emptyIndicator.style.display = 'none';
                }

                const startIndex = (currentPage - 1) * itemsPerPage;
                const endIndex = Math.min(startIndex + itemsPerPage, total);

                // Afficher uniquement les lignes de la page courante
                for (let i = startIndex; i < endIndex; i++) {
                    filteredRows[i].style.display = '';
                }

                infoText.innerText = "Affichage de " + (startIndex + 1) + " à " + endIndex + " sur " + total + " éléments";
                buildPagination(totalPages);
            }

            function buildPagination(totalPages) {
                paginationUl.innerHTML = '';
                if (totalPages <= 1) return;

                const createLi = function(text, pageNum, disabled, active) {
                    const li = document.createElement('li');
                    li.className = "page-item " + (disabled ? "disabled" : "") + (active ? " active" : "");
                    const a = document.createElement('a');
                    a.className = "page-link";
                    a.href = "#";
                    a.innerText = text;

                    if (!disabled && !active) {
                        a.addEventListener('click', function(e) {
                            e.preventDefault();
                            currentPage = pageNum;
                            render();
                        });
                    } else {
                        a.addEventListener('click', function(e) { e.preventDefault(); });
                    }
                    li.appendChild(a);
                    return li;
                };

                // Bouton Précédent
                paginationUl.appendChild(createLi("Précédent", currentPage - 1, currentPage === 1, false));

                // Numéros de page
                for (let i = 1; i <= totalPages; i++) {
                    if (i === 1 || i === totalPages || (i >= currentPage - 1 && i <= currentPage + 1)) {
                        paginationUl.appendChild(createLi(i, i, false, currentPage === i));
                    } else if (i === currentPage - 2 || i === currentPage + 2) {
                        const dots = document.createElement('li');
                        dots.className = "page-item disabled";
                        dots.innerHTML = '<span class="page-link">...</span>';
                        paginationUl.appendChild(dots);
                    }
                }

                // Bouton Suivant
                paginationUl.appendChild(createLi("Suivant", currentPage + 1, currentPage === totalPages, false));
            }

            // Attacher les événements de filtrage
            searchInput.addEventListener('input', filterData);
            dateDebutInput.addEventListener('change', filterData);
            dateFinInput.addEventListener('change', filterData);

            if (config.statusClass) {
                document.querySelectorAll('.' + config.statusClass).forEach(function(btn) {
                    btn.addEventListener('click', function() {
                        document.querySelectorAll('.' + config.statusClass).forEach(function(b) { b.classList.remove('active'); });
                        this.classList.add('active');
                        filterData();
                    });
                });
            }

            // Rendu initial
            render();
        }

        // Initialisation pour le Tableau 1 (Attente)
        initTablePagination({
            rowSelector: '.row-attente',
            searchInput: 'searchAttente',
            dateDebut: 'dateDebutAttente',
            dateFin: 'dateFinAttente',
            infoId: 'infoPaginationAttente',
            paginationId: 'paginationAttente',
            emptyId: 'emptyAttente'
        });

        // Initialisation pour le Tableau 2 (En Cours)
        initTablePagination({
            rowSelector: '.row-cours',
            searchInput: 'searchCours',
            dateDebut: 'dateDebutCours',
            dateFin: 'dateFinCours',
            statusClass: 'btn-filter-cours', // Active les boutons filtres pour ce tableau
            infoId: 'infoPaginationCours',
            paginationId: 'paginationCours',
            emptyId: 'emptyCours'
        });

    });
</script>