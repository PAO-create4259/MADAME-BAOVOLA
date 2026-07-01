<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-graph-up-arrow"></i> Comptabilité &amp; suivi financier</h1>
</div>

<div class="content-area">
    <form class="filter-bar" method="get" action="${pageContext.request.contextPath}/admin/dashboard" style="margin-bottom: 20px;">
        <span class="label">Sélectionner la période :</span>
        <span style="margin-left: 15px; margin-right: 5px;">Du :</span>
        <input type="date" name="debut" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateDebut") %>">
        <span style="margin: 0 5px;">Au :</span>
        <input type="date" name="fin" class="form-control search-box" style="width: auto;" value="<%= request.getAttribute("dateFin") %>">
        <button type="submit" class="btn btn-filter" style="background-color: #111; color: white;">Appliquer</button>
    </form>

    <div style="display: flex; gap: 20px; margin-bottom: 20px;">
        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Chiffre d'affaires</div>
            <h2 style="margin: 10px 0; font-size: 28px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("chiffreAffaires")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">Total encaissé sur la période</div>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Dépenses</div>
            <h2 style="margin: 10px 0; font-size: 28px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("totalDepenses")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">Charges totales sur la période</div>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Bénéfice net</div>
            <h2 style="margin: 10px 0; font-size: 28px;"><%= utils.Utilitaires.formaterNombre((Double) request.getAttribute("beneficeNet")) %> Ar</h2>
            <div style="color: #999; font-size: 12px;">CA – Dépenses</div>
        </div>
    </div>

</div>
