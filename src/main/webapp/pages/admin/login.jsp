<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Backoffice - CleanCare</title>

    <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style-admin.css">
    <script src="${pageContext.request.contextPath}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>

    <style>
        /* Centrage de la page de connexion */
        body {
            background-color: #f4f5f7;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        /* Style de la boîte de connexion */
        .login-box {
            width: 100%;
            max-width: 400px;
            padding: 40px;
            text-align: center;
        }

        .login-logo {
            width: 45px;
            height: 45px;
            background: #d9dde3;
            border-radius: 8px;
            margin: 0 auto 15px auto;
        }

        .login-title {
            font-size: 22px;
            font-weight: 700;
            color: #111827;
            margin-bottom: 30px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }

        .form-group label {
            font-size: 13.5px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
            display: block;
        }

        .form-group input {
            width: 100%;
            padding: 10px 15px;
        }

        .error {
            color: #c0392b;
            font-size: 12px;
            margin-top: 5px;
            font-weight: 500;
        }
    </style>
</head>
<body>

<main class="login-box card-table">
    <h1 class="login-title">CleanCare Admin</h1>

    <form method="post" action="${pageContext.request.contextPath}/admin/login">

        <div class="form-group">
            <label for="username">Nom d'utilisateur</label>
            <input type="text" id="username" name="username" class="form-control search-box" placeholder="Entrez votre nom d'utilisateur" required>
        </div>

        <div class="form-group">
            <label for="password">Mot de passe</label>
            <input type="password" id="password" name="password" class="form-control search-box" placeholder="Entrez votre mot de passe" required>
        </div>

        <button type="submit" class="btn btn-filter active w-100" style="padding: 10px; font-size: 14px; margin-top: 10px;">
            Se connecter
        </button>
    </form>
    <%
        String erreur = (String) request.getAttribute("erreur");
        if (erreur != null && !erreur.trim().isEmpty()) {
    %>
    <div style="color: #c0392b; background: #fdeded; padding: 10px; border-radius: 6px; margin-bottom: 20px; font-size: 13px; font-weight: 600; text-align: center;">
        <%= erreur %>
    </div>
    <%
        }
    %>
</main>

</body>
</html>