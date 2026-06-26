<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CleanCare Clothes</title>

    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/icons/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style-client.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Style-Admin1.css">

    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
</head>
<body>

<header class="fixed-top bg-dark bg-opacity-75">
    <div class="container d-flex justify-content-between align-items-center py-2">

        <div class="logo">
            <a href="${pageContext.request.contextPath}/">
<%--                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="CleanCare" style="height: 50px;">--%>
                CleanCare
            </a>
        </div>

        <nav class="navbar navbar-expand-lg navbar-dark p-0">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'accueil' ? 'active' : ''}" href="${pageContext.request.contextPath}/">Accueil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'tarif' ? 'active' : ''}" href="${pageContext.request.contextPath}/tarif">Tarif</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'apropos' ? 'active' : ''}" href="${pageContext.request.contextPath}/apropos">À propos</a>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link border-0 bg-transparent" data-bs-toggle="modal" data-bs-target="#inscriptionModal">Inscription</button>
                    </li>
                    <li class="nav-item">
                        <button class="nav-link border-0 bg-transparent" data-bs-toggle="modal" data-bs-target="#connexionModal">Connexion</button>
                    </li>
                </ul>
            </div>
        </nav>

    </div>
</header>

<main>
    <jsp:include page="content/${pageClient}.jsp" />
</main>

<div class="modal fade" id="connexionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content auth-box">
            <div class="modal-body p-4">
                <h2 class="text-center mb-4">Authentification</h2>
                <div class="mb-3">
                    <input type="text" class="form-control" placeholder="Téléphone">
                </div>
                <button class="btn btn-auth">Suivant</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="inscriptionModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content auth-box">
            <div class="modal-body p-4">
                <h1 class="text-center inscription-title">CleanCare</h1>
                <h2 class="text-center mb-3">Bienvenue</h2>
                <p class="text-center mb-4">Veuillez vous connecter pour une expérience optimale.</p>
                <form>
                    <div class="mb-3">
                        <input type="text" class="form-control" placeholder="Nom">
                    </div>
                    <div class="mb-3">
                        <input type="text" class="form-control" placeholder="Prénom">
                    </div>
                    <div class="mb-4">
                        <input type="tel" class="form-control" placeholder="Téléphone">
                    </div>
                    <button class="btn btn-auth">Suivant</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>