<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>LavAdmin - Statistiques</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&family=Raleway:wght@400;500;600&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../../assets/css/style7a.css">
</head>

<body>

<div class="wrapper">

  
    <!-- SIDEBAR -->
<aside class="sidebar">

    <div class="logo-section">

        <div class="logo-placeholder"></div>

        <h5 class="logo-title">
            LavAdmin
        </h5>

    </div>


    <div class="menu-section">

        <p class="menu-category">
            SUIVI
        </p>


        <a href="#" class="menu-link">
            ● Suivi en cours
        </a>

        <a href="#" class="menu-link">
            ● Historique lavage
        </a>

        <a href="#" class="menu-link">
            ● Livraisons
        </a>

        <a href="#" class="menu-link">
            ● Hist. livraisons
        </a>


    </div>


    <hr>


    <div class="menu-section">


        <p class="menu-category">
            GESTION
        </p>


        <a href="#" class="menu-link">
            ● Clients
        </a>


        <a href="#" class="menu-link">
            ● Dashboard
        </a>


        <a href="Admin7.html" class="menu-link">
            ● Dépenses
        </a>


        <a href="Admin8.html" class="menu-link active">
            ● Statistiques
        </a>


        <a href="Admin9.html" class="menu-link">
            ● Tarifs
        </a>


    </div>

</aside>

    <!-- MAIN -->
    <main class="main-content">

        <!-- HEADER -->
        <header class="topbar">

            <h3 class="page-title">
                Statistiques de vente & Bénéfices
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


        <!-- KPI -->
        <section>

            <h5 class="section-title">
                Indicateurs clés
            </h5>

            <div class="row g-4">

                <div class="col-lg-3">
                    <div class="card kpi-card">
                         <small class="form-label">Nb. lavages</small>
                        <h2>—Ar</h2>
                        <p>sur la période</p>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="card kpi-card">
                        <small>Chiffre d'affaires</small>
                        <h2>— Ar</h2>
                        <p>total encaissé</p>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="card kpi-card">
                        <small>Dépenses</small>
                        <h2>— Ar</h2>
                        <p>total charges</p>
                    </div>
                </div>

                <div class="col-lg-3">
                    <div class="card kpi-card">
                        <small>Bénéfice net</small>
                        <h2>— Ar</h2>
                        <p>CA - dépenses</p>
                    </div>
                </div>

            </div>

        </section>

        <!-- GRAPHIQUES -->
        <section class="mt-5">

            <div class="row g-4">

                <div class="col-lg-6">
                      <h5 class="section-title">
                            Statistiques de vente
                        </h5>


                    <div class="card graph-card">

                      
                        <div class="chart-placeholder">

                            [ Graphique barres ]

                        </div>

                    </div>

                </div>

                <div class="col-lg-6">
                        <h5 class="section-title">
                            Suivi des bénéfices
                        </h5>

                    <div class="card graph-card">

                       
                        <div class="chart-placeholder">

                            [ Graphique courbe ]

                        </div>

                    </div>

                </div>

            </div>

        </section>
 
        <!-- TABLEAU -->
        <section class="mt-5">
             <h5 class="section-title">
                    Récapitulatif par période
                </h5>

            <div class="card shadow-sm">

                <div class="table-responsive">

                    <table class="table table-hover mb-0">

                        <thead>

                        <tr>
                            <th>Période</th>
                            <th>Nb. lavages</th>
                            <th>Chiffre d'affaires</th>
                            <th>Dépenses</th>
                            <th>Bénéfice net</th>
                        </tr>

                        </thead>

                        <tbody>

                        <tr>
                            <td>Semaine 24</td>
                            <td>—</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                        </tr>

                        <tr>
                            <td>Semaine 23</td>
                            <td>—</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                        </tr>

                        <tr>
                            <td>Semaine 22</td>
                            <td>—</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                            <td>— Ar</td>
                        </tr>

                        </tbody>

                    </table>

                </div>

            </div>

        </section>

    </main>

</div>

</body>
</html>