<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-clock-history"></i> Historique — Linge terminé</h1>
</div>

<div class="content-area">
    <div class="section-label">Liste du linge terminé et annulé</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Aujourd'hui</button>
        <button class="btn btn-filter">Par date</button>
        <button class="btn btn-filter">Par client</button>
        <button class="btn btn-filter">Terminé</button>
        <button class="btn btn-filter">Annulé</button>
        <input type="text" class="form-control search-box" placeholder="Rechercher...">
    </div>

    <div class="card-table">
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Date</th>
                <th>N° de suivi</th>
                <th>Client (tél / ordre)</th>
                <th>Qté linge</th>
                <th>Prix total</th>
                <th>Statut</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>09/06/2026</td>
                <td>LAV-010</td>
                <td>034 00 010</td>
                <td>3 pcs</td>
                <td>— Ar</td>
                <td><span class="badge-status badge-termine">Terminé</span></td>
            </tr>
            <tr>
                <td>09/06/2026</td>
                <td>LAV-011</td>
                <td>033 00 011</td>
                <td>1 pc</td>
                <td>— Ar</td>
                <td><span class="badge-status badge-annule">Annulé</span></td>
            </tr>
            <tr>
                <td>08/06/2026</td>
                <td>LAV-009</td>
                <td>032 00 009</td>
                <td>6 pcs</td>
                <td>— Ar</td>
                <td><span class="badge-status badge-termine">Terminé</span></td>
            </tr>
            <tr>
                <td>08/06/2026</td>
                <td>LAV-008</td>
                <td>038 00 008</td>
                <td>4 pcs</td>
                <td>— Ar</td>
                <td><span class="badge-status badge-termine">Terminé</span></td>
            </tr>
            <tr>
                <td>07/06/2026</td>
                <td>LAV-007</td>
                <td>034 00 007</td>
                <td>2 pcs</td>
                <td>— Ar</td>
                <td><span class="badge-status badge-annule">Annulé</span></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>