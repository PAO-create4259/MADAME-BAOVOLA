<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LavAdmin - Historique lavage</title>
<link href="../../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../assets/css/Style-Admin2.css" rel="stylesheet">
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
    <a href="Admin1.html" class="nav-link">Suivi en cours</a>
    <a href="#" class="nav-link active">Historique lavage</a>
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
    <h1 class="page-title">Historique — Linge terminé</h1>
    <div class="admin-area">
      <span>Admin</span>
      <div class="avatar-circle"></div>
    </div>
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

<script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
