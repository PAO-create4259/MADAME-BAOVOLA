<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Categorie" %>
<%@ page import="java.util.List" %>

<%
  List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
  Double prixLivraison = (Double) request.getAttribute("prixLivraison");
%>

<section class="page-hero parallax-wrap">

  <div class="container position-relative" style="z-index:1;">
    <div class="row justify-content-center text-center">
      <div class="col-lg-8">
        <h1 class="display-1 mt-5" style="font-size:clamp(2.6rem, 6vw, 4.2rem);">
          <span class="text-reveal-line">Un prix juste,</span>
          <span class="text-reveal-line"><em style="font-style:italic; color:var(--color-blue-light);">pour chaque tissu</em></span>
        </h1>
        <p class="lead text-muted-soft mt-4 mx-auto" style="max-width:560px;" data-reveal="up">
          Du coton au lin, en passant par le satin délicat — chaque vêtement reçoit le soin et le tarif qu'il mérite. Récupération et livraison incluses, en option.
        </p>
      </div>
    </div>
  </div>
</section>

<section class="section-pad">
  <div class="container">

    <div class="row mb-5">
      <div class="col-lg-6" data-reveal="up">
        <p class="eyebrow">Grille tarifaire</p>
        <h2 class="mt-3" style="font-size:clamp(1.8rem, 3vw, 2.6rem);">Prix par vêtement</h2>
      </div>
      <div class="col-lg-5 offset-lg-1 d-flex align-items-end" data-reveal="up" data-reveal-class="delay-1">
        <p class="text-muted-soft mb-0">
          Nos tarifs sont transparents et s'adaptent à la matière de votre linge. Chaque article nécessite un traitement spécifique pour préserver sa qualité.
        </p>
      </div>
    </div>

    <div class="table-responsive" data-reveal="up" data-reveal-class="delay-2">
      <table class="table align-middle" style="border-collapse:separate; border-spacing:0 12px;">
        <thead>
        <tr style="font-family:var(--font-body); font-size:0.78rem; letter-spacing:0.1em; text-transform:uppercase; color:var(--color-blue-light);">
          <th class="border-0 ps-4">Désignation</th>
          <th class="border-0 text-end pe-4">Prix Unitaire</th>
        </tr>
        </thead>
        <tbody>
        <%
          if (categories != null && !categories.isEmpty()) {
            for (model.Categorie cat : categories) {
        %>
        <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
          <td class="ps-4 rounded-start-4 py-3 fw-bold" style="color:var(--color-blue-dark);">
            <i class="bi bi-tag-fill me-3 text-orange"></i><%= cat.getNomCategorie() %>
          </td>
          <td class="text-end pe-4 rounded-end-4 py-3 fw-bold">
            <%= cat.getPrixFormate() %> Ar
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="2" class="text-center py-4 text-muted">Aucun tarif n'est disponible pour le moment.</td>
        </tr>
        <%
          }
        %>
        </tbody>
      </table>
    </div>
    <p class="text-muted-soft small mt-3" data-reveal="fade">* Tarifs indicatifs en ariary (Ar), pour un lavage standard.</p>

    <% if (prixLivraison != null && prixLivraison > 0) { %>
    <div class="mt-5 p-4 rounded-4" style="background-color: var(--color-cream);" data-reveal="up">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h5 class="mb-1" style="color:var(--color-blue-dark);">Service de récupération et livraison</h5>
          <p class="mb-0 text-muted-soft small">Prise en charge à domicile aller-retour</p>
        </div>
        <div class="fs-4 fw-bold text-orange">
          <%= utils.Utilitaires.formaterNombre(prixLivraison) %> Ar
        </div>
      </div>
    </div>
    <% } %>

  </div>
</section>