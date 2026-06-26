<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Client" %>

<%
  Client client = (Client) session.getAttribute("clientConnecte");
  String nomClient = (client != null) ? client.getNom() : "";
  String prenomClient = (client != null) ? client.getPrenom() : "";
  String telClient = (client != null) ? client.getTelephone() : "";
%>

<div class="container py-5" style="min-height: 100vh;">
  <div class="row g-5 py-5">

    <div class="col-lg-5">
      <h3 class="mb-4 fw-bold" style="color: #2c3e50;">Recapitulation</h3>

      <div class="mb-5">
        <p class="mb-2 fw-bold text-muted">Nom : <span class="fw-normal text-dark"><%= nomClient %></span></p>
        <p class="mb-2 fw-bold text-muted">Prénom : <span class="fw-normal text-dark"><%= prenomClient %></span></p>
        <p class="mb-2 fw-bold text-muted">Téléphone : <span class="fw-normal text-dark"><%= telClient %></span></p>
      </div>

      <h4 class="mb-3 fw-bold" style="color: #2c3e50;">Facture</h4>
      <div class="mb-4">
        <p class="mb-2 fw-bold text-muted">Total : <span class="fw-normal text-dark" id="recapTotalPanier">0 Ar</span></p>
        <p class="mb-2 fw-bold" style="color: #2c3e50;">Total a payer : <span id="recapTotalPayer">0 Ar</span></p>
      </div>

      <div id="sectionRecuperation" class="mb-5 d-none">
        <h4 class="mb-3 fw-bold" style="color: #2c3e50;">Adresse de récupération :</h4>
        <p class="mb-1 text-dark fw-bold" id="recapAdresse"></p>
        <p class="mb-1 text-dark fw-bold" id="recapTelRecup"></p>
      </div>

      <div class="d-flex gap-3 mt-5">
        <a href="${pageContext.request.contextPath}/lavage" class="btn text-white px-4 py-2" style="background-color: #0d47a1;">
          Modifier
        </a>
        <button type="button" id="btnAnnuler" class="btn text-white px-4 py-2" style="background-color: #0d47a1;">
          Annuler
        </button>
        <button type="button" id="btnConfirmer" class="btn text-white px-4 py-2" style="background-color: #0d47a1;">
          Confirmer
        </button>
      </div>
    </div>

    <div class="col-lg-7">
      <h3 class="mb-4 fw-bold" style="color: #2c3e50;">Liste du linge</h3>

      <div class="table-responsive mb-4">
        <table class="table table-borderless align-middle">
          <thead style="background-color: #eee9e0;">
          <tr>
            <th scope="col" class="py-3 text-muted">Designation</th>
            <th scope="col" class="py-3 text-muted">Quantite</th>
            <th scope="col" class="py-3 text-muted">Prix unitaire(Ar)</th>
            <th scope="col" class="py-3 text-muted">Total(Ar)</th>
          </tr>
          </thead>
          <tbody class="text-muted" id="tbodyRecapitulatif">
          </tbody>
        </table>
      </div>
    </div>

  </div>
</div>

<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1100;">
  <div id="toastConfirmation" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body fw-bold" id="toastMessage">
        <i class="bi bi-check-circle-fill me-2"></i> Lavage confirmé avec succès !
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  </div>
</div>

<script>
  function formaterNombre(nombre) {
    return new Intl.NumberFormat('fr-FR').format(nombre);
  }

  document.addEventListener("DOMContentLoaded", function() {
    document.getElementById('btnAnnuler').addEventListener('click', function() {
      // On efface le panier stocké en mémoire
      sessionStorage.removeItem('commandeData');
      // On redirige vers l'accueil
      window.location.href = '${pageContext.request.contextPath}/';
    });

    // 1. Récupération des données depuis le SessionStorage
    const dataJson = sessionStorage.getItem('commandeData');

    if (!dataJson) {
      // Si pas de données, c'est que l'utilisateur est arrivé ici par hasard, on le renvoie au lavage
      window.location.href = '${pageContext.request.contextPath}/lavage';
      return;
    }

    const commande = JSON.parse(dataJson);
    const tbody = document.getElementById('tbodyRecapitulatif');

    // 2. Affichage des articles
    commande.panier.forEach(item => {
      const totalLigne = item.prixUnitaire * item.quantite;
      const tr = document.createElement('tr');
      tr.innerHTML = `
                <td class="py-3">\${item.nomTissu}</td>
                <td>\${item.quantite}</td>
                <td>\${formaterNombre(item.prixUnitaire)}</td>
                <td class="fw-bold">\${formaterNombre(totalLigne)}</td>
            `;
      tbody.appendChild(tr);
    });

    // 3. Affichage de la livraison si applicable
    if (commande.avecRecuperation && commande.prixLivraison > 0) {
      const trLivr = document.createElement('tr');
      trLivr.innerHTML = `
                <td class="py-3">Frais de récupération & livraison</td>
                <td>1</td>
                <td>\${formaterNombre(commande.prixLivraison)}</td>
                <td class="fw-bold">\${formaterNombre(commande.prixLivraison)}</td>
            `;
      tbody.appendChild(trLivr);

      // Afficher le bloc d'adresse
      document.getElementById('sectionRecuperation').classList.remove('d-none');
      document.getElementById('recapAdresse').innerText = commande.adresse;
      document.getElementById('recapTelRecup').innerText = commande.telephone;
    }

    // 4. Affichage des totaux
    document.getElementById('recapTotalPanier').innerText = formaterNombre(commande.montantTotal) + " Ar";
    document.getElementById('recapTotalPayer').innerText = formaterNombre(commande.montantTotal) + " Ar";

    // 5. Gestion de l'envoi au serveur lors du clic sur "Confirmer"
    document.getElementById('btnConfirmer').addEventListener('click', function() {
      const btn = document.getElementById('btnConfirmer');
      btn.disabled = true;
      btn.innerText = "Traitement...";

      // Préparation des données pour le POST Java
      const formData = new URLSearchParams();
      formData.append('avecRecuperation', commande.avecRecuperation);
      formData.append('adresse', commande.adresse);
      formData.append('telephone', commande.telephone);
      formData.append('prixLivraison', commande.prixLivraison);
      formData.append('montantTotal', commande.montantTotal);

      // On ajoute les éléments du panier sous forme de listes (arrays) pour Java
      commande.panier.forEach(item => {
        formData.append('idCategorie[]', item.idCategorie);
        formData.append('quantite[]', item.quantite);
        formData.append('prixUnitaire[]', item.prixUnitaire);
      });

      // Envoi de la requête au CommandeController
      fetch('${pageContext.request.contextPath}/confirmer-commande', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: formData.toString()
      })
              .then(response => {
                if (response.ok) {
                  // Nettoyage du panier
                  sessionStorage.removeItem('commandeData');

                  // Toast de succès
                  const toast = new bootstrap.Toast(document.getElementById('toastConfirmation'));
                  toast.show();

                  // Redirection
                  setTimeout(() => {
                    window.location.href = '${pageContext.request.contextPath}/suivi';
                  }, 2000);
                } else {
                  alert("Une erreur s'est produite lors de la validation.");
                  btn.disabled = false;
                  btn.innerText = "Confirmer";
                }
              })
              .catch(error => {
                console.error("Erreur serveur :", error);
                alert("Impossible de joindre le serveur.");
                btn.disabled = false;
                btn.innerText = "Confirmer";
              });
    });
  });
</script>