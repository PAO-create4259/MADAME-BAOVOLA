<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-graph-up-arrow"></i> Comptabilité &amp; suivi financier</h1>
    <div class="admin-area">
        <span>Admin</span>
        <div class="avatar-circle"></div>
    </div>
</div>

<div class="content-area">
    <div class="filter-bar" style="margin-bottom: 20px;">
        <span class="label">Sélectionner la période :</span>
        <button class="btn btn-filter active">Ce mois</button>
        <button class="btn btn-filter">Cette semaine</button>
        <button class="btn btn-filter">Aujourd'hui</button>

        <span style="margin-left: 15px; margin-right: 5px;">Du :</span>
        <input type="date" class="form-control search-box" style="width: auto;">
        <span style="margin: 0 5px;">Au :</span>
        <input type="date" class="form-control search-box" style="width: auto;">
    </div>

    <div style="display: flex; gap: 20px; margin-bottom: 20px;">
        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Chiffre d'affaires</div>
            <h2 style="margin: 10px 0; font-size: 28px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">Total encaissé sur la période</div>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Dépenses</div>
            <h2 style="margin: 10px 0; font-size: 28px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">Charges totales sur la période</div>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 25px;">
            <div style="color: #666; font-size: 14px; font-weight: bold;">Bénéfice net</div>
            <h2 style="margin: 10px 0; font-size: 28px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">CA – Dépenses</div>
        </div>
    </div>

    <div class="card-table" style="padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Évolution sur la période</div>

        <div style="text-align: center; padding: 50px; color: #888;">
            <i class="bi bi-bar-chart-line" style="font-size: 40px;"></i>
            <p style="margin-top: 15px;">Graphique d'évolution CA / Dépenses / Bénéfices</p>
        </div>
    </div>

</div>