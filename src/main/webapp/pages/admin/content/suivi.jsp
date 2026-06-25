<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title">Suivi en cours</h1>
</div>

<div class="content-area">

    <!-- Section 1: Linge en attente -->
    <div class="section-label">Linge en attente de récupération</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Aujourd'hui</button>
        <button class="btn btn-filter">Par date</button>
        <button class="btn btn-filter">Par client</button>
        <button class="btn btn-filter">Par statut</button>
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
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-001</td>
                    <td>034 00 001</td>
                    <td>3 pcs</td>
                    <td>— Ar</td>
                    <td><button class="btn btn-recuperer">Récupérer</button></td>
                </tr>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-002</td>
                    <td>033 00 002</td>
                    <td>5 pcs</td>
                    <td>— Ar</td>
                    <td><button class="btn btn-recuperer">Récupérer</button></td>
                </tr>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-003</td>
                    <td>032 00 003</td>
                    <td>2 pcs</td>
                    <td>— Ar</td>
                    <td><button class="btn btn-recuperer">Récupérer</button></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="info-note" style="margin-top:-22px; margin-bottom:20px;">
        ℹ️ Cliquer « Récupérer » déplace la ligne vers la section ci-dessous.
    </div>

    <!-- Section 2: Linge récupéré -->
    <div class="section-label">Linge récupéré — en cours de traitement</div>

    <div class="filter-bar">
        <span class="label">Filtre :</span>
        <button class="btn btn-filter active">Aujourd'hui</button>
        <button class="btn btn-filter">Par date</button>
        <button class="btn btn-filter">Par client</button>
        <button class="btn btn-filter">Par statut</button>
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
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-004</td>
                    <td>034 00 004</td>
                    <td>4 pcs</td>
                    <td>— Ar</td>
                    <td><span class="badge-status badge-attente">En attente</span></td>
                    <td>
                        <button class="btn btn-action btn-laver">Laver</button>
                        <button class="btn btn-action btn-terminer">Terminer</button>
                        <button class="btn btn-action btn-annuler">Annuler</button>
                    </td>
                </tr>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-005</td>
                    <td>033 00 005</td>
                    <td>6 pcs</td>
                    <td>— Ar</td>
                    <td><span class="badge-status badge-cours">En cours</span></td>
                    <td>
                        <button class="btn btn-action btn-laver">Laver</button>
                        <button class="btn btn-action btn-terminer">Terminer</button>
                        <button class="btn btn-action btn-annuler">Annuler</button>
                    </td>
                </tr>
                <tr>
                    <td>10/06/2026</td>
                    <td>LAV-006</td>
                    <td>032 00 006</td>
                    <td>2 pcs</td>
                    <td>— Ar</td>
                    <td><span class="badge-status badge-cours">En cours</span></td>
                    <td>
                        <button class="btn btn-action btn-laver">Laver</button>
                        <button class="btn btn-action btn-terminer">Terminer</button>
                        <button class="btn btn-action btn-annuler">Annuler</button>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>

</div>
