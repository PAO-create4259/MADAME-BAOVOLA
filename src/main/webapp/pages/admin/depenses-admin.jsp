<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Dépenses & Consommation</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&family=Raleway:wght@400;500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../../assets/css/style7a.css">
</head>

<body>

<div class="wrapper">

    <!-- Sidebar -->
    <aside class="sidebar">

        <div class="logo-section">
            <div class="logo-placeholder"></div>
            <h5 class="logo-title">LavAdmin</h5>
        </div>

        <div class="menu-section">

            <h6 class="menu-category">SUIVI</h6>

            <a href="suivi.html" class="menu-link">
                ● Suivi en cours
            </a>

            <a href="historique-lavage.html" class="menu-link">
                ● Historique lavage
            </a>

            <a href="livraisons.html" class="menu-link">
                ● Livraisons
            </a>

            <a href="historique-livraisons.html" class="menu-link">
                ● Hist. livraisons
            </a>

            <hr>

            <h6 class="menu-category">GESTION</h6>

            <a href="clients.html" class="menu-link">
                ● Clients
            </a>

            <a href="dashboard.html" class="menu-link">
                ● Dashboard
            </a>

            <a href="Admin7.html" class="menu-link active">
                ● Dépenses
            </a>

            <a href="Admin8.html" class="menu-link">
                ● Statistiques
            </a>

            <a href="Admin9.html" class="menu-link">
                ● Tarifs
            </a>

        </div>

    </aside>

    <!-- Main -->
    <main class="main-content">

        <!-- Header -->
        <header class="topbar">

            <h3 class="page-title">
                Dépenses & Consommation
            </h3>

            <div class="admin-profile">
                <span>Admin</span>
                <div class="profile-picture"></div>
            </div>

        </header>

        <!-- Filtres -->
        <div class="card shadow-sm border-0 filter-card">

            <div class="card-body">

                <div class="d-flex flex-wrap align-items-center gap-2">

                    <span class="filter-label">
                        Période :
                    </span>

                    <button class="btn btn-primary">
                        Aujourd'hui
                    </button>

                    <button class="btn btn-outline-primary">
                        Cette semaine
                    </button>

                    <button class="btn btn-outline-primary">
                        Ce mois
                    </button>

                    <button class="btn btn-outline-primary">
                        Ce trimestre
                    </button>

                    <button class="btn btn-outline-primary">
                        Cette année
                    </button>

                </div>

                <div class="row mt-4 align-items-end">

                    <div class="col-md-4">
                        <label class="form-label">
                            Du :
                        </label>

                        <input
                                type="date"
                                class="form-control">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">
                            Au :
                        </label>

                        <input
                                type="date"
                                class="form-control">
                    </div>

                    <div class="col-md-4">
                        <button class="btn btn-primary w-100">
                            Appliquer
                        </button>
                    </div>

                </div>

            </div>

        </div>

        <!-- Total -->
        <div class="card shadow-sm border-0 total-card">

            <div class="card-body">

                <p class="mb-2">
                    Total des dépenses sur la période :
                </p>

                <h1 id="totalDepenses">
                    — Ar
                </h1>

            </div>

        </div>

        <!-- Détail + Graphique -->
        <div class="row g-4">

            <!-- Tableau -->
            <div class="col-lg-6">

                <div class="card shadow-sm h-100">

                    <div class="card-header section-title">
                        Détail par catégorie
                    </div>

                    <div class="card-body p-0">

                        <table class="table table-hover mb-0">

                            <tbody>

                            <tr>
                                <td>Facture JIRAMA (eau + électricité)</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            <tr>
                                <td>Loyer</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            <tr>
                                <td>Salaires des employés</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            <tr>
                                <td>Achat produits (savon, lessive...)</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            <tr>
                                <td>Carburant (motos livreurs)</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            <tr>
                                <td>Entretien machines à laver & motos</td>
                                <td class="text-end fw-bold">— Ar</td>
                            </tr>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

            <!-- Graphique -->
            <div class="col-lg-6">

                <div class="card shadow-sm h-100">

                    <div class="card-header section-title">
                        Répartition par catégorie
                    </div>

                    <div class="card-body">

                        <div class="chart-placeholder">

                            [ Graphique camembert —
                            répartition des dépenses ]

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </main>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>