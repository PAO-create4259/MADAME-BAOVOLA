<%--
  Created by IntelliJ IDEA.
  User: Rtony
  Date: 24/06/2026
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
    Page à afficher dans la zone de contenu.
    Définie par le contrôleur via request.setAttribute("page", "...")
    ou via le paramètre ?page=... . Valeur par défaut : dashboard.
--%>
<c:set var="page" value="${not empty page ? page : (not empty param.page ? param.page : 'dashboard')}" />

<%-- Liste blanche : empêche d'inclure un fichier hors de content/ (traversée de chemin) --%>
<c:set var="pagesAutorisees" value=",dashboard,clients,depenses,statistiques,tarifs,suivi,historique-lavage,livraisons,historique-livraison," />
<c:if test="${not fn:contains(pagesAutorisees, ','.concat(page).concat(','))}">
    <c:set var="page" value="dashboard" />
</c:if>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CleanCare Backoffice</title>
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Style-Admin1.css">
    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="brand">
        <div class="logo-box"></div>
        <span>CleanCare</span>
    </div>

    <div class="section-title">SUIVI</div>
    <nav class="nav flex-column">
        <a href="?page=suivi" class="nav-link ${page == 'suivi' ? 'active' : ''}">Suivi en cours</a>
        <a href="?page=historique-lavage" class="nav-link ${page == 'historique-lavage' ? 'active' : ''}">Historique lavage</a>
        <a href="?page=livraisons" class="nav-link ${page == 'livraisons' ? 'active' : ''}">Livraisons</a>
        <a href="?page=historique-livraison" class="nav-link ${page == 'historique-livraison' ? 'active' : ''}">Hist. livraisons</a>
    </nav>

    <div class="section-title">GESTION</div>
    <nav class="nav flex-column">
        <a href="?page=clients" class="nav-link ${page == 'clients' ? 'active' : ''}">Clients</a>
        <a href="?page=dashboard" class="nav-link ${page == 'dashboard' ? 'active' : ''}">Dashboard</a>
        <a href="?page=depenses" class="nav-link ${page == 'depenses' ? 'active' : ''}">Dépenses</a>
        <a href="?page=statistiques" class="nav-link ${page == 'statistiques' ? 'active' : ''}">Statistiques</a>
        <a href="?page=tarifs" class="nav-link ${page == 'tarifs' ? 'active' : ''}">Tarifs</a>
    </nav>
</div>

<!-- Main content -->
<main class="main-content">
    <%-- Inclusion dynamique : le fichier change selon la variable "page" --%>
    <jsp:include page="content/${page}.jsp" />
</main>

</body>
</html>
