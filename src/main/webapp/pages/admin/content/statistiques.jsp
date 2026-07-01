<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-bar-chart-steps"></i> Statistiques & Bénéfices</h1>
</div>

<div class="content-area">

    <form class="filter-bar" method="get" action="${pageContext.request.contextPath}/admin/statistiques">
        <span class="label">Période :</span>
        <span style="margin-left: 15px; margin-right: 5px;">Du :</span>
        <input type="date" name="debut" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateDebut") %>">
        <span style="margin: 0 5px;">Au :</span>
        <input type="date" name="fin" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateFin") %>">
        <button type="submit" class="btn btn-filter" style="background-color: #111; color: white;">Appliquer</button>
    </form>

    <div class="section-label" style="margin-bottom: 15px; font-weight: bold;">Indicateurs clés</div>
    <div style="display: flex; gap: 20px; margin-bottom: 30px;">
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Nb. lavages</div>
            <h2 style="margin: 10px 0; font-size: 24px;"><%= request.getAttribute("nbLavages") %></h2>
            <div style="color: #999; font-size: 12px;">sur la période</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Chiffre d'affaires</div>
            <h2 style="margin: 10px 0; font-size: 24px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("chiffreAffaires")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">commandes terminées (RG36)</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Dépenses</div>
            <h2 style="margin: 10px 0; font-size: 24px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("totalDepenses")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">total charges</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Bénéfice net</div>
            <h2 style="margin: 10px 0; font-size: 24px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("beneficeNet")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">CA - dépenses (RG38)</div>
        </div>
    </div>

    <div class="card-table" style="padding: 20px; margin-bottom: 30px;">
        <div class="section-label" style="margin-bottom: 15px; font-weight: bold;">Évolution dans le temps (par semaine)</div>
        <%
            java.util.Map<java.sql.Date, double[]> evolutionHebdo =
                    (java.util.Map<java.sql.Date, double[]>) request.getAttribute("evolutionHebdo");

            double maxValeur = 1; // évite la division par zéro
            if (evolutionHebdo != null) {
                for (double[] v : evolutionHebdo.values()) {
                    maxValeur = Math.max(maxValeur, Math.max(v[0], v[1]));
                }
            }
        %>
        <% if (evolutionHebdo == null || evolutionHebdo.isEmpty()) { %>
        <p style="color:#888;">Aucune donnée sur la période sélectionnée.</p>
        <% } else { %>
        <div style="display:flex; align-items:flex-end; gap:18px; height:220px; padding:10px 5px; overflow-x:auto;">
            <%
                java.text.SimpleDateFormat fmtSemaine = new java.text.SimpleDateFormat("dd/MM");
                for (java.util.Map.Entry<java.sql.Date, double[]> entry : evolutionHebdo.entrySet()) {
                    double ca = entry.getValue()[0];
                    double dep = entry.getValue()[1];
                    int hCa = (int) Math.round((ca / maxValeur) * 160);
                    int hDep = (int) Math.round((dep / maxValeur) * 160);
            %>
            <div style="display:flex; flex-direction:column; align-items:center; min-width:60px;">
                <div style="display:flex; align-items:flex-end; gap:4px; height:160px;">
                    <div title="CA : <%= utils.Utilitaires.formaterNombre(ca) %> Ar"
                         style="width:18px; height:<%= Math.max(hCa,1) %>px; background:#111; border-radius:3px 3px 0 0;"></div>
                    <div title="Dépenses : <%= utils.Utilitaires.formaterNombre(dep) %> Ar"
                         style="width:18px; height:<%= Math.max(hDep,1) %>px; background:#c0392b; border-radius:3px 3px 0 0;"></div>
                </div>
                <div style="margin-top:8px; font-size:11px; color:#666; white-space:nowrap;">
                    Sem. <%= fmtSemaine.format(entry.getKey()) %>
                </div>
            </div>
            <% } %>
        </div>
        <div style="margin-top:10px; font-size:12px; color:#666;">
            <span style="display:inline-block; width:10px; height:10px; background:#111; border-radius:2px; margin-right:5px;"></span> Chiffre d'affaires
            <span style="display:inline-block; width:10px; height:10px; background:#c0392b; border-radius:2px; margin-left:20px; margin-right:5px;"></span> Dépenses
        </div>
        <% } %>
    </div>

    <div class="card-table" style="padding: 20px;">
        <div class="section-label" style="margin-bottom: 10px; font-weight: bold;">Note</div>
        <p style="color:#888;">
            Les statistiques ci-dessus sont calculées uniquement à partir des données réellement enregistrées
            (commandes terminées et dépenses saisies) sur la période sélectionnée (RG39).
        </p>
    </div>

</div>
