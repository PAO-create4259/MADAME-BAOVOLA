<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-person-lines-fill"></i> Liste des clients</h1>
</div>

<div class="content-area">
    <div class="section-label">Tous les clients enregistrés</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Tous</button>
        <button class="btn btn-filter">Par nom</button>
        <button class="btn btn-filter">Par téléphone</button>
        <button class="btn btn-filter">Activités</button>
        <input type="text" class="form-control search-box" placeholder="Rechercher un client...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Nom / Prénom</th>
                <th>Téléphone</th>
                <th>Date d'inscription</th>
                <th>Lavages terminés</th>
                <th>En cours</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="client-name">Rakoto Jean</td>
                <td>034 00 001</td>
                <td>01/01/2026</td>
                <td>12</td>
                <td><span class="badge-status badge-cours">1</span></td>
            </tr>
            <tr>
                <td class="client-name">Rabe Marie</td>
                <td>033 00 002</td>
                <td>15/02/2026</td>
                <td>5</td>
                <td>0</td>
            </tr>
            <tr>
                <td class="client-name">Andry Solo</td>
                <td>032 00 003</td>
                <td>03/03/2026</td>
                <td>9</td>
                <td><span class="badge-status badge-cours">2</span></td>
            </tr>
            <tr>
                <td class="client-name">Rasoa Hanta</td>
                <td>038 00 004</td>
                <td>22/03/2026</td>
                <td>3</td>
                <td><span class="badge-status badge-cours">1</span></td>
            </tr>
            <tr>
                <td class="client-name">Tovo Naina</td>
                <td>034 00 005</td>
                <td>10/04/2026</td>
                <td>7</td>
                <td>0</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>