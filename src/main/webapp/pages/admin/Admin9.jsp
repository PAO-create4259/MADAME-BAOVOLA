<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>LavAdmin - Tarifs</title>
    <link 
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
        rel="stylesheet">
    <link 
        href="https://fonts.googleapis.com/css2?family=Montserrat:wght@700&family=Raleway:wght@400;500;600&display=swap"
        rel="stylesheet">
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
        <a href="Admin8.html" class="menu-link ">
            ● Statistiques
        </a>
        <a href="Admin9.html" class="menu-link active">
            ● Tarifs
        </a>
    </div>

</aside>

        <!-- MAIN -->

        <main class="main-content">



        <header class="topbar">


        <h3 class="page-title">
        Modification des tarifs
        </h3>



        <div class="admin-profile">

        <span>
        Admin
        </span>


        <img 
        class="profile-picture"
        src="https://via.placeholder.com/40">


        </div>


        </header>





        <!-- PRIX VETEMENTS -->


        <section class="card shadow-sm p-4 mb-4">


        <h5 class="section-title">
        Prix par vêtement (en Ar)
        </h5>



        <table class="table">


        <thead>

        <tr>

        <th>Vêtement</th>

        <th>Coton</th>

        <th>Satin</th>

        <th>Lin</th>

        </tr>

        </thead>



        <tbody>


        <tr>

        <td>Chemise</td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>


        </tr>
     <tr>

        <td>Pantalon</td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        </tr>

        <tr>

        <td>Robe</td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        </tr>

         <tr>

        <td>Veste / Manteau</td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>


        </tr>

        <tr>

        <td>Draps / Couvertures</td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>

        <td><input class="form-control" placeholder="— Ar"></td>


        </tr>


        </tbody>


        </table>


        </section>
<!-- FRAIS DE LIVRAISON -->

<section class="card shadow-sm p-4 mb-4">


<h5 class="section-title">
Frais de livraison & récupération
</h5>



<div class="row g-4">


<div class="col-md-6">


<label class="filter-label">
Frais de livraison à domicile
</label>


<div class="input-group">

<input 
class="form-control"
placeholder="— Ar">


<span class="input-group-text">
Ar / livraison
</span>


</div>


</div>





<div class="col-md-6">


<label class="filter-label">
Frais de récupération au domicile
</label>



<div class="input-group">


<input 
class="form-control"
placeholder="— Ar">


<span class="input-group-text">
Ar / récupération
</span>


</div>


</div>


</div>


</section>






<!-- SALAIRES -->

<section class="card shadow-sm p-4 mb-4">


<h5 class="section-title">
Salaires des employés
</h5>



<div class="row g-4">



<div class="col-md-4">


<label class="filter-label">

Salaire mensuel — Employé 1

</label>


<div class="input-group">


<input 
class="form-control"
placeholder="— Ar">


<span class="input-group-text">
Ar / mois
</span>


</div>


</div>





<div class="col-md-4">


<label class="filter-label">

Salaire mensuel — Employé 2

</label>



<div class="input-group">


<input 
class="form-control"
placeholder="— Ar">


<span class="input-group-text">
Ar / mois
</span>


</div>


</div>






<div class="col-md-4">


<label class="filter-label">

Commission livreur

</label>



<div class="input-group">


<input 
class="form-control"
placeholder="— Ar">


<span class="input-group-text">
Ar / livraison
</span>


</div>


</div>



</div>


</section>







<!-- ACTIONS -->


<div class="actions text-end mt-4">


<button class="btn btn-outline-primary me-3">

Annuler

</button>




<button class="btn btn-primary">

Enregistrer les modifications

</button>



</div>
        </main>     
</div>
</body>
</html>