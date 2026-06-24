<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- La variable "page" est envoyée par le AdminController --%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CleanCare Backoffice</title>

    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <%-- Remplacer style-admin.css par Style-Admin1.css si tu n'as pas encore créé le fichier fusionné --%>
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
        <a href="${pageContext.request.contextPath}/admin/suivi" class="nav-link ${page == 'suivi' ? 'active' : ''}">Suivi en cours</a>
        <a href="${pageContext.request.contextPath}/admin/historique-lavage" class="nav-link ${page == 'historique-lavage' ? 'active' : ''}">Historique lavage</a>
        <a href="${pageContext.request.contextPath}/admin/livraisons" class="nav-link ${page == 'livraisons' ? 'active' : ''}">Livraisons</a>
        <a href="${pageContext.request.contextPath}/admin/historique-livraison" class="nav-link ${page == 'historique-livraison' ? 'active' : ''}">Hist. livraisons</a>
    </nav>

    <div class="section-title">GESTION</div>
    <nav class="nav flex-column">
        <a href="${pageContext.request.contextPath}/admin/clients" class="nav-link ${page == 'clients' ? 'active' : ''}">Clients</a>
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link ${page == 'dashboard' ? 'active' : ''}">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/depenses" class="nav-link ${page == 'depenses' ? 'active' : ''}">Dépenses</a>
        <a href="${pageContext.request.contextPath}/admin/statistiques" class="nav-link ${page == 'statistiques' ? 'active' : ''}">Statistiques</a>
        <a href="${pageContext.request.contextPath}/admin/tarifs" class="nav-link ${page == 'tarifs' ? 'active' : ''}">Tarifs</a>
    </nav>
</div>

<!-- Main content -->
<main class="main-content">
    <%-- Inclusion dynamique : le fichier change selon la variable "page" fournie par le Controller --%>
    <jsp:include page="content/${page}.jsp" />
</main>

</body>
</html>