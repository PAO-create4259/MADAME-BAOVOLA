<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Lavage" %>
<%@ page import="model.DetailLavage" %>
<%@ page import="model.Client" %>
<%@ page import="java.util.List" %>

<%
    Client client = (Client) session.getAttribute("clientConnecte");
    String nomComplet = (client != null) ? client.getNom() + " " + client.getPrenom() : "";
    String telephone = (client != null) ? client.getTelephone() : "";
    List<Lavage> mesLavages = (List<Lavage>) request.getAttribute("mesLavages");
%>

<div class="container py-5" style="min-height: 100vh;">
    <div class="row py-5 g-5">

        <div class="col-lg-4">
            <div class="card border-0 shadow-sm rounded-4 p-4" style="background-color: #f8f9fc;">
                <h4 class="mb-4 fw-bold" style="color: #2c3e50;">Mon Profil</h4>
                <div class="mb-3">
                    <p class="text-muted mb-1 small">Nom complet</p>
                    <p class="fw-bold fs-5"><%= nomComplet %></p>
                </div>
                <div class="mb-3">
                    <p class="text-muted mb-1 small">Numéro de téléphone</p>
                    <p class="fw-bold fs-5"><%= telephone %></p>
                </div>
                <hr>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <span class="text-muted">Total des commandes</span>
                    <span class="badge bg-primary rounded-pill fs-6"><%= (mesLavages != null) ? mesLavages.size() : 0 %></span>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <h3 class="mb-4 fw-bold" style="color: #2c3e50;">Historique & Suivi</h3>

            <% if (mesLavages == null || mesLavages.isEmpty()) { %>
            <div class="alert alert-info py-3">Vous n'avez passé aucune commande pour le moment.</div>
            <% } else { %>

            <div class="table-responsive shadow-sm rounded-3">
                <table class="table table-hover align-middle mb-0 bg-white">
                    <thead style="background-color: #eee9e0;">
                    <tr>
                        <th scope="col" class="py-3 px-4 text-muted">N° Commande</th>
                        <th scope="col" class="py-3 text-muted">Date</th>
                        <th scope="col" class="py-3 text-muted">Statut</th>
                        <th scope="col" class="py-3 text-muted">Paiement</th>
                        <th scope="col" class="py-3 text-muted">Total</th>
                    </tr>
                    </thead>
                    <tbody id="tableLavages">
                    <% for (Lavage lavage : mesLavages) { %>
                    <tr class="ligne-lavage" data-id="<%= lavage.getIdLavage() %>" style="cursor: pointer;">
                        <td class="px-4 fw-bold" style="color: #0d47a1;"><%= lavage.getIdLavage() %></td>
                        <td><%= lavage.getDateFormatee() %></td>
                        <td>
                            <%
                                String couleurStatut = "text-secondary";
                                if("En lavage".equals(lavage.getStatut())) couleurStatut = "text-primary";
                                if("Prêt à récupérer".equals(lavage.getStatut())) couleurStatut = "text-success";
                            %>
                            <span class="fw-bold <%= couleurStatut %>"><%= lavage.getStatut() %></span>
                        </td>
                        <td>
                                        <span class="badge <%= "Payé".equals(lavage.getStatutPaiement()) ? "bg-success" : "bg-danger" %>">
                                            <%= lavage.getStatutPaiement() %>
                                        </span>
                        </td>
                        <td class="fw-bold"><%= lavage.getPrixFormate() %> Ar</td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-4">
                <span class="text-muted small" id="infoPagination">Affichage des résultats</span>
                <nav>
                    <ul class="pagination pagination-sm mb-0" id="paginationControls">
                    </ul>
                </nav>
            </div>
            <% } %>

        </div>
    </div>
</div>

<div class="modal fade" id="modalDetailsLavage" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0 shadow">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold" style="color: #2c3e50;" id="titreModal">Détails de la commande</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fermer"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-borderless table-sm mb-0">
                        <thead class="border-bottom">
                        <tr>
                            <th class="text-muted pb-2">Désignation</th>
                            <th class="text-muted pb-2 text-center">Qté</th>
                            <th class="text-muted pb-2 text-end">Total</th>
                        </tr>
                        </thead>
                        <tbody id="tbodyDetailsModal">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // --- 1. Injection des détails de lavage depuis Java vers un objet JavaScript ---
    const tousLesDetails = {
        <%
            if (mesLavages != null) {
                for (Lavage l : mesLavages) {
        %>
        "<%= l.getIdLavage() %>": [
            <% for (DetailLavage d : l.getDetails()) { %>
            {
                nom: "<%= d.getNomCategorie() %>",
                quantite: <%= d.getQuantite() %>,
                totalFormate: "<%= d.getTotalFormate() %>"
            },
            <% } %>
        ],
        <%
                }
            }
        %>
    };

    // --- 2. Logique de la fenêtre modale (Détails au clic) ---
    const lignesTableau = document.querySelectorAll('.ligne-lavage');
    const modalElement = document.getElementById('modalDetailsLavage');
    let bootstrapModal;

    lignesTableau.forEach(ligne => {
        ligne.addEventListener('click', function() {
            const idLavage = this.getAttribute('data-id');
            // Redirection vers la vraie page de détails
            window.location.href = '${pageContext.request.contextPath}/detail?id=' + idLavage;
        });
    });

    if (modalElement) {
        bootstrapModal = new bootstrap.Modal(modalElement);
    }

    lignesTableau.forEach(ligne => {
        ligne.addEventListener('click', function() {
            const idLavage = this.getAttribute('data-id');
            const details = tousLesDetails[idLavage];

            document.getElementById('titreModal').innerText = "Commande " + idLavage;
            const tbodyModal = document.getElementById('tbodyDetailsModal');
            tbodyModal.innerHTML = '';

            if (details) {
                details.forEach(item => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = `
                        <td class="py-2">\${item.nom}</td>
                        <td class="py-2 text-center fw-bold">\${item.quantite}</td>
                        <td class="py-2 text-end fw-bold">\${item.totalFormate} Ar</td>
                    `;
                    tbodyModal.appendChild(tr);
                });
            }

            bootstrapModal.show();
        });
    });

    // --- 3. Logique de Pagination (10 lignes) ---
    const lignesPerPage = 10;
    let pageActuelle = 1;
    const totalLignes = lignesTableau.length;
    const totalPages = Math.ceil(totalLignes / lignesPerPage);

    function afficherPage(page) {
        if(totalLignes === 0) return;

        const debut = (page - 1) * lignesPerPage;
        const fin = debut + lignesPerPage;

        lignesTableau.forEach((ligne, index) => {
            if (index >= debut && index < fin) {
                ligne.style.display = ''; // Afficher
            } else {
                ligne.style.display = 'none'; // Cacher
            }
        });

        // Mise à jour du texte d'information
        const itemFin = Math.min(fin, totalLignes);
        document.getElementById('infoPagination').innerText = `Affichage de \${debut + 1} à \${itemFin} sur \${totalLignes} commandes`;

        genererBoutonsPagination();
    }

    function genererBoutonsPagination() {
        if(totalPages <= 1) return; // Pas de pagination si une seule page

        const ul = document.getElementById('paginationControls');
        ul.innerHTML = '';

        // Bouton Précédent
        ul.innerHTML += `
            <li class="page-item \${pageActuelle === 1 ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="changerPage(\${pageActuelle - 1}); return false;">&laquo;</a>
            </li>
        `;

        // Numéros de page
        for (let i = 1; i <= totalPages; i++) {
            ul.innerHTML += `
                <li class="page-item \${pageActuelle === i ? 'active' : ''}">
                    <a class="page-link" href="#" onclick="changerPage(\${i}); return false;">\${i}</a>
                </li>
            `;
        }

        // Bouton Suivant
        ul.innerHTML += `
            <li class="page-item \${pageActuelle === totalPages ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="changerPage(\${pageActuelle + 1}); return false;">&raquo;</a>
            </li>
        `;
    }

    // Exposer la fonction dans l'environnement global pour les onclick
    window.changerPage = function(nouvellePage) {
        if (nouvellePage >= 1 && nouvellePage <= totalPages) {
            pageActuelle = nouvellePage;
            afficherPage(pageActuelle);
        }
    };

    // Initialisation au chargement
    afficherPage(1);

</script>