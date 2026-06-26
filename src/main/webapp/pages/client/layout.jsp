<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Client" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CleanCare Clothes</title>

    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/icons/bootstrap-icons.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style-client.css" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
</head>
<body>

<header class="fixed-top bg-dark bg-opacity-75">
    <div class="container d-flex justify-content-between align-items-center py-2">

        <div class="logo">
            <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-white">
                <h5>CleanCare</h5>
            </a>
        </div>

        <nav class="navbar navbar-expand-lg navbar-dark p-0">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav mb-2 mb-lg-0 align-items-center">
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'accueil' ? 'active' : ''}" href="${pageContext.request.contextPath}/">Accueil</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'tarif' ? 'active' : ''}" href="${pageContext.request.contextPath}/tarif">Tarif</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${pageClient == 'apropos' ? 'active' : ''}" href="${pageContext.request.contextPath}/apropos">À propos</a>
                    </li>

                    <li class="nav-item ms-lg-3">
                        <%
                            // On récupère le client depuis la session
                            Client clientConnecte = (Client) session.getAttribute("clientConnecte");

                            // S'il existe, on affiche son nom et son prénom
                            if (clientConnecte != null) {
                        %>
                    <li class="nav-item ms-lg-3 d-flex align-items-center">
                        <a href="${pageContext.request.contextPath}/profil" class="nav-link text-white fw-bold">
                            <i class="bi bi-person-circle me-1"></i>
                            <%= clientConnecte.getNom() %> <%= clientConnecte.getPrenom() %>
                        </a>

                        <a href="${pageContext.request.contextPath}/deconnexion" class="btn btn-outline-danger btn-sm ms-3">
                            <i class="bi bi-box-arrow-right me-1"></i> Déconnexion
                        </a>
                    </li>
                        <%
                            // Sinon, on affiche le bouton de connexion
                        } else {
                        %>
                        <a href="${pageContext.request.contextPath}/login" class="nav-link btn btn-outline-light btn-sm px-3 ms-2">Connexion</a>
                        <%
                            }
                        %>
                    </li>

                </ul>
            </div>
        </nav>

    </div>
</header>

<main>
    <jsp:include page="content/${pageClient}.jsp" />
</main>

<footer class="site-footer" style="padding: 20px 0 20px 0;">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4">
                <span class="brand-mark mb-3" style="color:var(--color-cream); font-weight: bold; font-size: 1.2rem;">
                  CleanCare
                </span>
                <p class="mt-3" style="opacity:0.7; max-width:320px;">Pressing &amp; laverie premium à Antananarivo. Votre linge, notre attention.</p>
            </div>
            <div class="col-6 col-lg-2">
                <h6>Navigation</h6>
                <div class="d-flex flex-column gap-2">
                    <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-muted">Accueil</a>
                    <a href="${pageContext.request.contextPath}/tarif" class="text-decoration-none text-muted">Tarifs</a>
                    <a href="${pageContext.request.contextPath}/profil" class="text-decoration-none text-muted">Profil</a>
                    <a href="${pageContext.request.contextPath}/apropos" class="text-decoration-none text-muted">À propos</a>
                </div>
            </div>
            <div class="col-6 col-lg-3">
                <h6>Contact</h6>
                <div class="d-flex flex-column gap-2 text-muted">
                    <span><i class="bi bi-telephone me-2"></i>034 00 000 00</span>
                    <span><i class="bi bi-envelope me-2"></i>contact@cleancare.mg</span>
                </div>
            </div>
            <div class="col-lg-3">
                <h6>Suivez-nous</h6>
                <div class="d-flex gap-2">
                    <a href="#" class="nav-icon-btn text-muted"><i class="bi bi-facebook fs-4"></i></a>
                    <a href="#" class="nav-icon-btn text-muted"><i class="bi bi-instagram fs-4"></i></a>
                    <a href="#" class="nav-icon-btn text-muted"><i class="bi bi-whatsapp fs-4"></i></a>
                </div>
            </div>
        </div>
        <hr class="footer-divider my-4">
        <div class="d-flex flex-wrap justify-content-between footer-bottom text-muted small">
            <span>© 2026 CleanCare. Tous droits réservés.</span>
            <span>Antananarivo, Madagascar</span>
        </div>
    </div>
</footer>

</body>
</html>