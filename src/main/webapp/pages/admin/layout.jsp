<%@ page import="model.Utilisateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CleanCare Backoffice</title>

    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/icons/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/Style-Admin1.css">
    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar" style="display: flex; flex-direction: column; height: 100vh;">
    <div class="brand d-flex align-items-center gap-2">
        <img src="${pageContext.request.contextPath}/assets/img/laverie_linge_icon.png" alt="Logo Backoffice" width="50">
        <span class="fs-5 fw-bold mb-0">CleanCare Backoffice</span>
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

    <div style="margin-top: auto;"></div>

    <div style="padding: 20px; border-top: 1px solid #e5e7eb;">

        <a href="${pageContext.request.contextPath}/admin/logout" style="display: flex; align-items: center; gap: 10px; color: #c0392b; text-decoration: none; font-weight: 600; font-size: 13.5px; margin-bottom: 20px; transition: 0.2s;">
            <i class="bi bi-box-arrow-left" style="font-size: 18px;"></i>
            Déconnexion
        </a>

        <div style="display: flex; align-items: center; gap: 12px;">
            <div style="width: 38px; height: 38px; border-radius: 50%; background: #1f2937; color: white; display: flex; align-items: center; justify-content: center; font-size: 20px;">
                <i class="bi bi-person-fill"></i>
            </div>
            <div style="line-height: 1.3;">
                <div style="font-weight: 700; font-size: 14px; color: #111827;"><%= utilisateur.getNom() %></div>
                <div style="font-size: 11px; color: #6b7280; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px;"><%= utilisateur.getRole() %></div>
            </div>
        </div>

    </div>
</div>

<!-- Main content -->
<main class="main-content">
    <%-- Inclusion dynamique : le fichier change selon la variable "page" fournie par le Controller --%>
    <jsp:include page="content/${page}.jsp" />
</main>

</body>
</html>