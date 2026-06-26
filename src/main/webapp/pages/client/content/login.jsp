<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
    <div class="card p-5 shadow-sm" style="width: 100%; max-width: 400px;">


        <%-- SI LE NUMÉRO EST NOUVEAU, ON AFFICHE LE FORMULAIRE D'INSCRIPTION --%>
        <% if (request.getAttribute("telephoneNouveau") != null) { %>

        <p class="text-center text-muted mb-4">Ce numéro n'est pas enregistré. Veuillez créer votre compte.</p>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="hidden" name="action" value="inscrire">
            <input type="hidden" name="telephone" value="<%= request.getAttribute("telephoneNouveau") %>">

            <div class="mb-3">
                <label class="form-label">Nom</label>
                <input type="text" class="form-control" name="nom" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Prénom</label>
                <input type="text" class="form-control" name="prenom" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Téléphone</label>
                <input type="text" class="form-control" value="<%= request.getAttribute("telephoneNouveau") %>" disabled>
            </div>

            <button type="submit" class="btn btn-primary w-100">Continuer</button>
        </form>

        <%-- SINON, ON AFFICHE LA DEMANDE DE NUMÉRO --%>
        <% } else { %>

        <p class="text-center text-muted mb-4">Entrez votre numéro pour continuer.</p>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <input type="hidden" name="action" value="verifierTelephone">

            <div class="mb-4">
                <label class="form-label">Numéro de téléphone</label>
                <input type="tel" class="form-control" name="telephone" placeholder="Ex: 0340000000" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Suivant</button>
        </form>

        <% } %>

    </div>
</div>