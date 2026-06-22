<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LavAdmin - Livraisons</title>
<link href="../../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="../../assets/css/Style-Admin3.css" rel="stylesheet">
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
    <a href="Admin2.html" class="nav-link">Historique lavage</a>
    <a href="#" class="nav-link active">Livraisons</a>
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
    <h1 class="page-title">Livraisons &amp; Récupérations — En cours</h1>
    <div class="admin-area">
      <span>Admin</span>
      <div class="avatar-circle"></div>
    </div>
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
          <td><span class="badge-status badge-livre">Livré</span></td>
        </tr>
        <tr>
          <td>10/06/2026</td>
          <td>033 00 002</td>
          <td>033 00 002</td>
          <td>Lot III B 18, Isotry, Antananarivo</td>
          <td><span class="badge-status badge-recupere">Récupéré</span></td>
        </tr>
        <tr>
          <td>10/06/2026</td>
          <td>032 00 003</td>
          <td>038 00 099 (autre n°)</td>
          <td>Lot V C 07, Ankadivato, Antananarivo</td>
          <td><span class="badge-status badge-livre">Livré</span></td>
        </tr>
        <tr>
          <td>10/06/2026</td>
          <td>038 00 004</td>
          <td>038 00 004</td>
          <td>Lot I D 33, Ampefiloha, Antananarivo</td>
          <td><span class="badge-status badge-recupere">Récupéré</span></td>
        </tr>
      </tbody>
    </table>
  </div>

</div>

<script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
