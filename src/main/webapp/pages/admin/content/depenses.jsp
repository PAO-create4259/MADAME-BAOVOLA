<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<%@ page import="model.Categorie" %>
<%@ page import="java.util.List" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-wallet2"></i> Dépenses & Consommation</h1>
</div>

<div class="content-area">

    <form id="formPeriodeDepenses" class="filter-bar" method="get" action="${pageContext.request.contextPath}/admin/depenses">
        <span class="label">Période :</span>
        <span style="margin-left: 15px; margin-right: 5px;">Du :</span>
        <input type="date" name="debut" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateDebut") %>">
        <span style="margin: 0 5px;">Au :</span>
        <input type="date" name="fin" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateFin") %>">
        <button type="submit" class="btn btn-filter" style="background-color: #111; color: white;">Appliquer</button>
    </form>

    <div class="card-table" style="margin-bottom: 20px; padding: 25px;">
        <div style="color: #666; font-size: 14px; font-weight: bold;">Total des dépenses sur la période :</div>
        <h1 id="totalDepenses" style="margin: 10px 0 0 0; font-size: 28px;">
            <%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("totalDepenses")) %> Ar
        </h1>
    </div>

    <div style="display: flex; gap: 20px; align-items: stretch;">

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Détail par catégorie</div>
            <table class="table lav-table">
                <tbody>
                <%
                    Map<String, Double> parCategorie = (Map<String, Double>) request.getAttribute("depensesParCategorie");
                    if (parCategorie != null) {
                        for (Map.Entry<String, Double> entry : parCategorie.entrySet()) {
                %>
                <tr>
                    <td><%= entry.getKey() %></td>
                    <td style="text-align: right; font-weight: bold;"><%= utils.Utilitaires.formaterNombre(entry.getValue()) %> Ar</td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Ajouter une dépense / consommation</div>
            <form id="formAjoutDepense">
                <div class="mb-2">
                    <label class="form-label text-muted">Catégorie</label>
                    <select class="form-control search-box" name="idCategorie" required>
                        <%
                            List<Categorie> categories = (List<Categorie>) request.getAttribute("categoriesDepense");
                            if (categories != null) {
                                for (Categorie c : categories) {
                        %>
                        <option value="<%= c.getIdCategorie() %>"><%= c.getNomCategorie() %></option>
                        <%
                                }
                            }
                        %>
                    </select>
                </div>
                <div class="mb-2">
                    <label class="form-label text-muted">Montant (Ar)</label>
                    <input type="number" min="1" step="0.01" class="form-control search-box" name="montant" required>
                </div>
                <div class="mb-2">
                    <label class="form-label text-muted">Date</label>
                    <input type="date" class="form-control search-box" name="dateDepense" required>
                </div>
                <div class="mb-2">
                    <label class="form-label text-muted">Description</label>
                    <input type="text" class="form-control search-box" name="description">
                </div>
                <button type="submit" class="btn btn-filter" style="background-color: #111; color: white; margin-top: 10px;">Enregistrer la dépense</button>
            </form>
        </div>

    </div>

    <div class="card-table" style="margin-top: 20px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Liste des dépenses de la période</div>
        <table class="table lav-table">
            <thead>
            <tr><th>Date</th><th>Catégorie</th><th>Description</th><th>Montant</th></tr>
            </thead>
            <tbody>
            <%
                java.util.List<model.Depense> depenses = (java.util.List<model.Depense>) request.getAttribute("depenses");
                if (depenses != null && !depenses.isEmpty()) {
                    for (model.Depense d : depenses) {
            %>
            <tr>
                <td><%= d.getDateFormatee() %></td>
                <td><%= d.getNomCategorie() %></td>
                <td><%= d.getDescription() != null ? d.getDescription() : "" %></td>
                <td style="text-align:right; font-weight:bold;"><%= d.getMontantFormate() %> Ar</td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="4" class="text-center">Aucune dépense enregistrée sur cette période</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.getElementById('formAjoutDepense').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new URLSearchParams(new FormData(this));
        formData.append('action', 'ajouterDepense');

        fetch('<%= request.getContextPath() %>/admin/action', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: formData.toString()
        }).then(function (resp) {
            if (resp.ok) {
                location.reload();
            } else {
                alert("Le montant doit être positif et tous les champs obligatoires renseignés.");
            }
        });
    });
</script>
