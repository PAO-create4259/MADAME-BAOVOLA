<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LavAdmin - Suivi en cours</title>
<link href="../../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../assets/vendor/bootstrap/css/Style-Admin1.css" rel="stylesheet">
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <div class="brand">
    <div class="logo-box"></div>
    <span>LavAdmin</span>
  </div>

  <div class="section-title">SUIVI</div>
  <nav class="nav flex-column">
    <a href="#" class="nav-link active">Suivi en cours</a>
    <a href="Admin2.html" class="nav-link">Historique lavage</a>
    <a href="Admin3.html" class="nav-link">Livraisons</a>
    <a href="#" class="nav-link">Hist. livraisons</a>
  </nav>

  <div class="section-title">GESTION</div>
  <nav class="nav flex-column">
    <a href="#" class="nav-link">Clients</a>
    <a href="#" class="nav-link">Dashboard</a>
    <a href="#" class="nav-link">Dépenses</a>
    <a href="#" class="nav-link">Statistiques</a>
    <a href="#" class="nav-link">Tarifs</a>
  </nav>
</div>

<!-- Main content -->
<div class="main-content">

  <div class="topbar">
    <h1 class="page-title">Suivi en cours</h1>
    <div class="admin-area">
      <span>Admin</span>
      <div class="avatar-circle"></div>
    </div>
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

</div>

<script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
