<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-bar-chart-steps"></i> Statistiques & Bénéfices</h1>
</div>

<div class="content-area">

    <div class="filter-bar">
        <span class="label">Période :</span>
        <button class="btn btn-filter active">Aujourd'hui</button>
        <button class="btn btn-filter">Cette semaine</button>
        <button class="btn btn-filter">Ce mois</button>
        <button class="btn btn-filter">Ce trimestre</button>
        <button class="btn btn-filter">Cette année</button>

        <span style="margin-left: 15px; margin-right: 5px;">Du :</span>
        <input type="date" class="form-control search-box" style="width: auto;">
        <span style="margin: 0 5px;">Au :</span>
        <input type="date" class="form-control search-box" style="width: auto;">
        <button class="btn btn-filter" style="background-color: #111; color: white;">Appliquer</button>
    </div>

    <div class="section-label" style="margin-bottom: 15px; font-weight: bold;">Indicateurs clés</div>
    <div style="display: flex; gap: 20px; margin-bottom: 30px;">
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Nb. lavages</div>
            <h2 style="margin: 10px 0; font-size: 24px;">—</h2>
            <div style="color: #999; font-size: 12px;">sur la période</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Chiffre d'affaires</div>
            <h2 style="margin: 10px 0; font-size: 24px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">total encaissé</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Dépenses</div>
            <h2 style="margin: 10px 0; font-size: 24px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">total charges</div>
        </div>
        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div style="color: #666; font-size: 13px; font-weight: bold;">Bénéfice net</div>
            <h2 style="margin: 10px 0; font-size: 24px;">— Ar</h2>
            <div style="color: #999; font-size: 12px;">CA - dépenses</div>
        </div>
    </div>

    <div style="display: flex; gap: 20px; margin-bottom: 30px; align-items: stretch;">

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Statistiques de vente</div>
            <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 180px; color: #888;">
                <i class="bi bi-bar-chart" style="font-size: 40px; margin-bottom: 15px;"></i>
                <p>[ Graphique barres ]</p>
            </div>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Suivi des bénéfices</div>
            <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 180px; color: #888;">
                <i class="bi bi-graph-up" style="font-size: 40px; margin-bottom: 15px;"></i>
                <p>[ Graphique courbe ]</p>
            </div>
        </div>

    </div>

    <div class="card-table" style="padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Récapitulatif par période</div>
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Période</th>
                <th>Nb. lavages</th>
                <th>Chiffre d'affaires</th>
                <th>Dépenses</th>
                <th>Bénéfice net</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Semaine 24</td>
                <td>—</td>
                <td>— Ar</td>
                <td>— Ar</td>
                <td>— Ar</td>
            </tr>
            <tr>
                <td>Semaine 23</td>
                <td>—</td>
                <td>— Ar</td>
                <td>— Ar</td>
                <td>— Ar</td>
            </tr>
            <tr>
                <td>Semaine 22</td>
                <td>—</td>
                <td>— Ar</td>
                <td>— Ar</td>
                <td>— Ar</td>
            </tr>
            </tbody>
        </table>
    </div>

</div>