<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Lavage" %>
<%@ page import="model.DetailLavage" %>

<%
  Lavage lavage = (Lavage) request.getAttribute("lavageDetail");

  // Sécurité au cas où l'URL est modifiée manuellement avec un faux ID
  if (lavage == null) {
    response.sendRedirect(request.getContextPath() + "/profil");
    return;
  }

  String statut = lavage.getStatut();
  int pourcentage = 0;
  String couleurBarre = "bg-secondary";

  if ("En attente".equals(statut)) {
    pourcentage = 25;
    couleurBarre = "bg-warning";
  } else if ("Linge récupéré".equals(statut)) {
    pourcentage = 50;
    couleurBarre = "bg-info";
  } else if ("En lavage".equals(statut)) {
    pourcentage = 75;
    couleurBarre = "bg-primary";
  } else if ("Prêt à récupérer".equals(statut)) {
    pourcentage = 100;
    couleurBarre = "bg-success";
  }
%>

<div class="container py-5" style="min-height: 100vh;">
  <div class="row py-5 justify-content-center">

    <div class="col-lg-8">

      <a href="${pageContext.request.contextPath}/profil" class="btn btn-outline-secondary btn-sm mb-4">
        <i class="bi bi-arrow-left me-2"></i>Retour à mon profil
      </a>

      <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold mb-0" style="color: #2c3e50;">Commande <%= lavage.getIdLavage() %></h2>
        <span class="badge <%= "Payé".equals(lavage.getStatutPaiement()) ? "bg-success" : "bg-danger" %> px-3 py-2 rounded-pill fs-6">
                    <%= lavage.getStatutPaiement() %>
                </span>
      </div>

      <div class="card shadow-sm border-0 mb-5 rounded-4 p-4">

        <div class="row mb-4">
          <div class="col-md-6">
            <p class="text-muted mb-1 small">Date de la commande</p>
            <p class="fw-bold"><%= lavage.getDateFormatee() %></p>
          </div>
          <div class="col-md-6 text-md-end">
            <p class="text-muted mb-1 small">Montant total</p>
            <p class="fw-bold fs-4 text-dark mb-0"><%= lavage.getPrixFormate() %> Ar</p>
          </div>
        </div>

        <hr class="text-muted my-4">

        <h5 class="fw-bold mb-3" style="color: #2c3e50;">Suivi de l'état</h5>
        <div class="mb-4">
          <div class="d-flex justify-content-between mb-2 small fw-bold text-muted">
            <span>Statut actuel : <span class="<%= couleurBarre.replace("bg-", "text-") %>"><%= statut %></span></span>
            <span><%= pourcentage %>%</span>
          </div>
          <div class="progress" style="height: 12px; border-radius: 10px;">
            <div class="progress-bar <%= couleurBarre %> progress-bar-striped progress-bar-animated"
                 role="progressbar"
                 style="width: <%= pourcentage %>%"
                 aria-valuenow="<%= pourcentage %>"
                 aria-valuemin="0"
                 aria-valuemax="100">
            </div>
          </div>
        </div>

        <hr class="text-muted my-4">

        <h5 class="fw-bold mb-3" style="color: #2c3e50;">Détails du linge</h5>
        <div class="table-responsive">
          <table class="table table-borderless align-middle mb-0">
            <thead style="border-bottom: 2px solid #eee9e0;">
            <tr>
              <th class="text-muted py-2">Désignation</th>
              <th class="text-muted py-2 text-center">Quantité</th>
              <th class="text-muted py-2 text-end">Total</th>
            </tr>
            </thead>
            <tbody>
            <%
              for (DetailLavage detail : lavage.getDetails()) {
            %>
            <tr>
              <td class="py-3"><%= detail.getNomCategorie() %></td>
              <td class="py-3 text-center fw-bold"><%= detail.getQuantite() %></td>
              <td class="py-3 text-end fw-bold"><%= detail.getTotalFormate() %> Ar</td>
            </tr>
            <%
              }
            %>
            </tbody>
          </table>
        </div>

      </div>

    </div>
  </div>
</div>