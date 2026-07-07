<%@ page import="model.Lavage" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-clock-history"></i> Historique de lavage</h1>
</div>

<div class="content-area">
    <div class="section-label">Liste de lavage</div>

    <div class="filter-bar d-flex flex-wrap align-items-center gap-2">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active" data-filter="all">Tous</button>
        <button class="btn btn-filter" data-filter="today">Aujourd'hui</button>
        <button class="btn btn-filter" data-filter="termine">Terminé</button>
        <button class="btn btn-filter" data-filter="annule">Annulé</button>

        <div class="vr mx-2"></div>

        <input type="text" id="searchInput" class="form-control search-box" placeholder="Rechercher (Client ou N°)..." style="width: 250px;">

        <div class="d-flex align-items-center gap-2">
            <span class="label">Date :</span>
            <input type="date" id="dateFilter" class="form-control search-box" style="width: auto;">
        </div>
    </div>

    <div class="card-table mt-3">
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
            <tbody id="lavageTableBody">
            <%
                List<Lavage> historiqueLavages = (List<Lavage>) request.getAttribute("historiqueLavages");
                if (historiqueLavages != null && !historiqueLavages.isEmpty()) {
                    for (model.Lavage lavage : historiqueLavages) {
                        // On formate la date en YYYY-MM-DD pour que la comparaison avec l'input type="date" soit facile
                        String dateIso = "";
                        if(lavage.getDateCommande() != null) {
                            dateIso = new java.text.SimpleDateFormat("yyyy-MM-dd").format(lavage.getDateCommande());
                        }
            %>
            <tr class="lavage-row"
                data-date="<%= dateIso %>"
                data-statut="<%= lavage.getStatut().toLowerCase() %>"
                data-client="<%= lavage.getIdClient().toLowerCase() %>"
                data-recherche="<%= lavage.getIdLavage().toLowerCase() %> <%= lavage.getIdClient().toLowerCase() %>">
                <td><%= lavage.getDateFormatee() %></td>
                <td><%= lavage.getIdLavage() %></td>
                <td><%= lavage.getIdClient() %></td>
                <td><%= lavage.getQuantiteLinge() %> pcs</td>
                <td><%= lavage.getPrixFormate() %> Ar</td>
                <td><span class="badge-status <%= "Annulé".equals(lavage.getStatut()) ? "badge-annule" : "badge-termine" %>"><%= lavage.getStatut() %></span></td>
                <td>
                    <% if ("Payé".equals(lavage.getStatutPaiement())) { %>
                    <span class="text-success fw-bold">Payé</span>
                    <% } else { %>
                    <button class="btn btn-action btn-laver" data-id="<%= lavage.getIdLavage() %>" data-action="payer">Payer</button>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr id="emptyRow">
                <td colspan="7" class="text-center">Aucun historique disponible</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>

        <div class="d-flex justify-content-between align-items-center p-3 border-top">
            <span class="text-muted small" id="infoPagination">Affichage des résultats</span>
            <nav>
                <ul class="pagination pagination-sm mb-0" id="paginationControls">
                </ul>
            </nav>
        </div>

    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // --- 1. GESTION DES BOUTONS D'ACTION (Payer) ---
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

        // --- 2. GESTION DES FILTRES ET DE LA RECHERCHE ---
        const filterButtons = document.querySelectorAll('.btn-filter');
        const searchInput = document.getElementById('searchInput');
        const dateFilter = document.getElementById('dateFilter');
        const tableRows = Array.from(document.querySelectorAll('.lavage-row'));

        // Obtenir la date d'aujourd'hui au format YYYY-MM-DD
        const today = new Date();
        const todayIso = today.getFullYear() + '-' + String(today.getMonth() + 1).padStart(2, '0') + '-' + String(today.getDate()).padStart(2, '0');

        let lignesFiltrees = tableRows; // Stocke les lignes qui correspondent aux filtres

        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                filterButtons.forEach(b => b.classList.remove('active'));
                this.classList.add('active');

                // Si on clique sur un bouton, on réinitialise la date manuelle
                if(this.getAttribute('data-filter') !== 'today') {
                    dateFilter.value = '';
                }
                appliquerFiltres();
            });
        });

        searchInput.addEventListener('input', appliquerFiltres);
        dateFilter.addEventListener('change', function() {
            // Si on choisit une date manuelle, on désactive le bouton "Aujourd'hui"
            filterButtons.forEach(b => b.classList.remove('active'));
            document.querySelector('[data-filter="all"]').classList.add('active');
            appliquerFiltres();
        });

        function appliquerFiltres() {
            const activeFilter = document.querySelector('.btn-filter.active').getAttribute('data-filter');
            const searchTerm = searchInput.value.toLowerCase();
            const selectedDate = dateFilter.value;

            lignesFiltrees = [];

            tableRows.forEach(row => {
                let show = true;

                // Filtre par recherche texte
                if (searchTerm && row.getAttribute('data-recherche')) {
                    if (!row.getAttribute('data-recherche').includes(searchTerm)) {
                        show = false;
                    }
                }

                // Filtre par date exacte (champ date)
                if (show && selectedDate) {
                    if (row.getAttribute('data-date') !== selectedDate) {
                        show = false;
                    }
                }

                // Filtre par boutons (statut ou aujourd'hui)
                if (show && activeFilter !== 'all') {
                    const statut = row.getAttribute('data-statut');
                    const rowDate = row.getAttribute('data-date');

                    if (activeFilter === 'today' && rowDate !== todayIso) {
                        show = false;
                    }
                    if (activeFilter === 'termine' && statut !== 'prêt à récupérer' && statut !== 'linge récupéré') {
                        show = false;
                    }
                    if (activeFilter === 'annule' && statut !== 'annulé') {
                        show = false;
                    }
                }

                if (show) {
                    lignesFiltrees.push(row);
                }
                row.style.display = 'none'; // On cache tout par défaut, la pagination affichera les bonnes
            });

            // Après avoir filtré, on retourne à la page 1 et on affiche
            pageActuelle = 1;
            afficherPage(1);
        }

        // --- 3. GESTION DE LA PAGINATION ---
        const lignesPerPage = 12;
        let pageActuelle = 1;

        function afficherPage(page) {
            const totalLignes = lignesFiltrees.length;
            const totalPages = Math.ceil(totalLignes / lignesPerPage);

            // Cacher toutes les lignes filtrées d'abord
            lignesFiltrees.forEach(row => row.style.display = 'none');

            if(totalLignes === 0) {
                document.getElementById('infoPagination').innerText = "Aucun résultat trouvé";
                document.getElementById('paginationControls').innerHTML = '';
                return;
            }

            // Sécurité si la page demandée est hors limites
            if(page > totalPages) page = totalPages;
            if(page < 1) page = 1;

            pageActuelle = page;

            // Calculer l'index de début et de fin
            const debut = (page - 1) * lignesPerPage;
            const fin = Math.min(debut + lignesPerPage, totalLignes);

            // Afficher les lignes de la page actuelle
            for (let i = debut; i < fin; i++) {
                lignesFiltrees[i].style.display = '';
            }

            document.getElementById('infoPagination').innerText = `Affichage de \${debut + 1} à \${fin} sur \${totalLignes} éléments`;
            genererBoutonsPagination(totalPages);
        }

        function genererBoutonsPagination(totalPages) {
            const ul = document.getElementById('paginationControls');
            ul.innerHTML = '';

            if(totalPages <= 1) return;

            // Bouton Précédent
            ul.innerHTML += `
            <li class="page-item \${pageActuelle === 1 ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="changerPage(\${pageActuelle - 1}); return false;">Précédent</a>
            </li>
        `;

            // Numéros de page
            for (let i = 1; i <= totalPages; i++) {
                // Afficher un maximum de 5 boutons (pour éviter que ça déborde si beaucoup de pages)
                if (i === 1 || i === totalPages || (i >= pageActuelle - 1 && i <= pageActuelle + 1)) {
                    ul.innerHTML += `
                    <li class="page-item \${pageActuelle === i ? 'active' : ''}">
                        <a class="page-link" href="#" onclick="changerPage(\${i}); return false;">\${i}</a>
                    </li>
                `;
                } else if (i === pageActuelle - 2 || i === pageActuelle + 2) {
                    ul.innerHTML += `<li class="page-item disabled"><span class="page-link">...</span></li>`;
                }
            }

            ul.innerHTML += `
            <li class="page-item \${pageActuelle === totalPages ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="changerPage(\${pageActuelle + 1}); return false;">Suivant</a>
            </li>
        `;
        }

        window.changerPage = function(nouvellePage) {
            afficherPage(nouvellePage);
        };

        appliquerFiltres();
    });
</script>