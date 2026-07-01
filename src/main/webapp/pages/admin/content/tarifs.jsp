<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-tags"></i> Modification des tarifs</h1>
</div>

<div class="content-area">

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Prix par vêtement</div>
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Vêtement</th>
                <th>Prix</th>
            </tr>
            </thead>
            <tbody>
            <%
                java.util.List<model.Categorie> categoriesTarifs = (java.util.List<model.Categorie>) request.getAttribute("categoriesTarifs");
                if (categoriesTarifs != null && !categoriesTarifs.isEmpty()) {
                    for (model.Categorie cat : categoriesTarifs) {
            %>
            <tr>
                <td><%= cat.getNomCategorie() %></td>
                <td>
                    <div style="display:flex; align-items:center; gap:10px;">
                        <input type="number" min="0" step="1" class="form-control search-box input-prix-vetement"
                               data-id-tarif="<%= cat.getIdTarif() %>"
                               value="<%= (int) cat.getPrix() %>" style="width: 140px;">
                        <span style="color:#888; font-size:13px;">Ar</span>
                    </div>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="2" class="text-center">Aucun vêtement configuré</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Frais de livraison & récupération</div>
        <form id="formTarifLivraison" style="display: flex; gap: 30px; align-items: flex-end;">
            <%
                model.TarifLivraison tarifLivraison = (model.TarifLivraison) request.getAttribute("tarifLivraison");
                double prixActuel = (tarifLivraison != null) ? tarifLivraison.getPrixUnitaire() : 0;
                int partActuelle = (tarifLivraison != null) ? tarifLivraison.getPartLivreur() : 75;
            %>
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Frais de livraison / récupération à domicile</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="number" min="0" step="1" name="prixUnitaire" class="form-control search-box" style="flex: 1;" value="<%= prixActuel %>">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / course</span>
                </div>
            </div>
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Part reversée au livreur (commission, RG30)</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="number" min="0" max="100" step="1" name="partLivreur" class="form-control search-box" style="flex: 1;" value="<%= partActuelle %>">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">% du tarif</span>
                </div>
            </div>
            <button type="submit" class="btn btn-filter" style="background-color: #111; color: white;">Enregistrer</button>
        </form>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Récupérations / livraisons à assigner à un livreur</div>
        <table class="table lav-table">
            <thead><tr><th>Type</th><th>N° lavage</th><th>Téléphone</th><th>Adresse</th><th>Date</th><th>Assigner</th></tr></thead>
            <tbody>
            <%
                java.util.List<model.LivraisonHistorique> nonAssignees = (java.util.List<model.LivraisonHistorique>) request.getAttribute("livraisonsNonAssignees");
                java.util.List<model.Utilisateur> livreurs = (java.util.List<model.Utilisateur>) request.getAttribute("livreurs");
                if (nonAssignees != null && !nonAssignees.isEmpty()) {
                    for (model.LivraisonHistorique h : nonAssignees) {
                        String type = "Récupération".equals(h.getStatut()) ? "recuperation" : "livraison";
            %>
            <tr>
                <td><%= h.getStatut() %></td>
                <td><%= h.getIdLavage() %></td>
                <td><%= h.getTelephone() %></td>
                <td><%= h.getAdresse() %></td>
                <td><%= h.getDate() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(h.getDate()) : "" %></td>
                <td>
                    <select class="form-control search-box select-livreur" data-type="<%= type %>" data-id="<%= h.getIdRecord() %>" style="width: auto; display:inline-block;">
                        <option value="" disabled selected>Choisir un livreur</option>
                        <% if (livreurs != null) { for (model.Utilisateur liv : livreurs) { %>
                        <option value="<%= liv.getIdUtilisateur() %>"><%= liv.getNom() %></option>
                        <% } } %>
                    </select>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="6" class="text-center">Aucune course en attente d'assignation</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Commissions des livreurs — période du <%= request.getAttribute("dateDebut") %> au <%= request.getAttribute("dateFin") %></div>
        <table class="table lav-table">
            <thead><tr><th>Livreur</th><th>Nb. courses</th><th>Commission</th></tr></thead>
            <tbody>
            <%
                java.util.Map<String, double[]> commissions = (java.util.Map<String, double[]>) request.getAttribute("commissionsParLivreur");
                if (commissions != null && !commissions.isEmpty()) {
                    for (java.util.Map.Entry<String, double[]> entry : commissions.entrySet()) {
            %>
            <tr>
                <td><%= entry.getKey() %></td>
                <td><%= (int) entry.getValue()[0] %></td>
                <td style="text-align:right; font-weight:bold;"><%= utils.Utilitaires.formaterNombre(entry.getValue()[1]) %> Ar</td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="3" class="text-center">Aucune commission sur cette période</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Suivi des coûts d'entretien (machines / motos)</div>
        <p style="color:#888; font-size: 13px;">Saisis depuis la page « Dépenses & Consommation », catégorie « Entretien matériel ».</p>
        <table class="table lav-table">
            <thead><tr><th>Date</th><th>Catégorie</th><th>Description</th><th>Montant</th></tr></thead>
            <tbody>
            <%
                java.util.List<model.Depense> entretien = (java.util.List<model.Depense>) request.getAttribute("entretien");
                boolean aucun = true;
                if (entretien != null) {
                    for (model.Depense d : entretien) {
                        if (!"Entretien matériel".equals(d.getNomCategorie())) continue;
                        aucun = false;
            %>
            <tr>
                <td><%= d.getDateFormatee() %></td>
                <td><%= d.getNomCategorie() %></td>
                <td><%= d.getDescription() != null ? d.getDescription() : "" %></td>
                <td style="text-align:right; font-weight:bold;"><%= d.getMontantFormate() %> Ar</td>
            </tr>
            <%
                    }
                }
                if (aucun) {
            %>
            <tr><td colspan="4" class="text-center">Aucune dépense d'entretien sur cette période</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            document.querySelectorAll('.input-prix-vetement').forEach(function (input) {
                input.addEventListener('change', function () {
                    fetch('<%= request.getContextPath() %>/admin/action', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: 'action=modifierPrixVetement&idTarif=' + encodeURIComponent(this.getAttribute('data-id-tarif')) +
                            '&prix=' + encodeURIComponent(this.value)
                    }).then(function (resp) {
                        if (!resp.ok) { alert("Prix invalide."); }
                    });
                });
            });

            document.querySelectorAll('.select-livreur').forEach(function (sel) {
                sel.addEventListener('change', function () {
                    fetch('<%= request.getContextPath() %>/admin/action', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: 'action=assignerLivreur&type=' + encodeURIComponent(this.getAttribute('data-type')) +
                            '&idRecord=' + encodeURIComponent(this.getAttribute('data-id')) +
                            '&idLivreur=' + encodeURIComponent(this.value)
                    }).then(function (resp) {
                        if (resp.ok) { location.reload(); } else { alert("Erreur lors de l'assignation."); }
                    });
                });
            });

            const formTarif = document.getElementById('formTarifLivraison');
            if (formTarif) {
                formTarif.addEventListener('submit', function (e) {
                    e.preventDefault();
                    const formData = new URLSearchParams(new FormData(this));
                    formData.append('action', 'modifierTarifLivraison');
                    fetch('<%= request.getContextPath() %>/admin/action', {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: formData.toString()
                    }).then(function (resp) {
                        if (resp.ok) { location.reload(); } else { alert("Valeurs invalides."); }
                    });
                });
            }
        });
    </script>

</div>
