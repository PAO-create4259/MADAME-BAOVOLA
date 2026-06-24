<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>


<div class="topbar">
    <h1 class="page-title"><i class="bi bi-truck"></i> Historique — Livraisons</h1>
    <div class="admin-area">
        <span>Admin</span>
        <div class="avatar-circle"></div>
    </div>
</div>

<div class="content-area">

    <div class="section-label">Historique complet des livraisons et récupérations</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Période</button>
        <button class="btn btn-filter">Par date</button>
        <button class="btn btn-filter">Par client</button>
        <button class="btn btn-filter">Par adresse</button>
        <button class="btn btn-filter">Par N° suivi</button>
        <button class="btn btn-filter">Récupéré</button>
        <button class="btn btn-filter">Livré</button>
        <input type="text" class="form-control search-box" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° client</th>
                <th>Tél contact livreur</th>
                <th>Adresse</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>05/06/2026</td>
                <td>034 00 010</td>
                <td>034 00 010</td>
                <td>Lot XX, Antananarivo</td>
                <td><span class="badge-status status-recupere"><i class="bi bi-arrow-up-circle"></i> Récupéré</span></td>
            </tr>
            <tr>
                <td>04/06/2026</td>
                <td>033 00 009</td>
                <td>033 00 009</td>
                <td>Lot YY, Antananarivo</td>
                <td><span class="badge-status status-livre"><i class="bi bi-check-circle"></i> Livré</span></td>
            </tr>
            <tr>
                <td>03/06/2026</td>
                <td>032 00 008</td>
                <td>032 00 008</td>
                <td>Lot ZZ, Antananarivo</td>
                <td><span class="badge-status status-livre"><i class="bi bi-check-circle"></i> Livré</span></td>
            </tr>
            <tr>
                <td>02/06/2026</td>
                <td>038 00 007</td>
                <td>038 00 007</td>
                <td>Lot WW, Antananarivo</td>
                <td><span class="badge-status status-recupere"><i class="bi bi-arrow-up-circle"></i> Récupéré</span></td>
            </tr>
            </tbody>
        </table>
    </div>

</div>