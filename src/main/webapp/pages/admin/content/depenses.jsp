<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-wallet2"></i> Dépenses & Consommation</h1>
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

    <div class="card-table" style="margin-bottom: 20px; padding: 25px;">
        <div style="color: #666; font-size: 14px; font-weight: bold;">Total des dépenses sur la période :</div>
        <h1 id="totalDepenses" style="margin: 10px 0 0 0; font-size: 28px;">— Ar</h1>
    </div>

    <div style="display: flex; gap: 20px; align-items: stretch;">

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Détail par catégorie</div>
            <table class="table lav-table">
                <tbody>
                <tr>
                    <td>Facture JIRAMA (eau + électricité)</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                <tr>
                    <td>Loyer</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                <tr>
                    <td>Salaires des employés</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                <tr>
                    <td>Achat produits (savon, lessive...)</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                <tr>
                    <td>Carburant (motos livreurs)</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                <tr>
                    <td>Entretien machines à laver & motos</td>
                    <td style="text-align: right; font-weight: bold;">— Ar</td>
                </tr>
                </tbody>
            </table>
        </div>

        <div class="card-table" style="flex: 1; margin: 0; padding: 20px;">
            <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Répartition par catégorie</div>
            <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; height: 80%; color: #888;">
                <i class="bi bi-pie-chart" style="font-size: 40px; margin-bottom: 15px;"></i>
                <p>[ Graphique camembert — répartition des dépenses ]</p>
            </div>
        </div>

    </div>
</div>