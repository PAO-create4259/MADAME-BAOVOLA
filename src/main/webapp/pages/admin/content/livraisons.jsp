<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-truck"></i> Livraisons &amp; Récupérations — En cours</h1>
</div>

<div class="content-area">
    <div class="section-label">Liste des livraisons et récupérations</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Aujourd'hui</button>
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
                <td>10/06/2026</td>
                <td>034 00 001</td>
                <td>034 00 001</td>
                <td>Lot II A 42, Andohalalo, Antananarivo</td>
                <td><span class="badge-status badge-livre"><i class="bi bi-check-circle"></i> Livré</span></td>
            </tr>
            <tr>
                <td>10/06/2026</td>
                <td>033 00 002</td>
                <td>033 00 002</td>
                <td>Lot III B 18, Isotry, Antananarivo</td>
                <td><span class="badge-status badge-recupere"><i class="bi bi-arrow-up-circle"></i> Récupéré</span></td>
            </tr>
            <tr>
                <td>10/06/2026</td>
                <td>032 00 003</td>
                <td>038 00 099 (autre n°)</td>
                <td>Lot V C 07, Ankadivato, Antananarivo</td>
                <td><span class="badge-status badge-livre"><i class="bi bi-check-circle"></i> Livré</span></td>
            </tr>
            <tr>
                <td>10/06/2026</td>
                <td>038 00 004</td>
                <td>038 00 004</td>
                <td>Lot I D 33, Ampefiloha, Antananarivo</td>
                <td><span class="badge-status badge-recupere"><i class="bi bi-arrow-up-circle"></i> Récupéré</span></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>