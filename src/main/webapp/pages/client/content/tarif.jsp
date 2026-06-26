<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Tarifs — Pressing & Laverie</title>
  <meta name="description" content="Découvrez nos tarifs de lavage par type de tissu, ainsi que nos frais de récupération et de livraison.">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="page8_9_10.css">
</head>
<body>
  <header class="site-header">
    <div class="container">
      <div class="d-flex align-items-center justify-content-between">
        <a href="page1_accueil.html" class="brand-mark">
          <span class="monogram"><span>L·V</span></span>
          <span class="brand-name-full">
            Lavanda
            <small>Pressing &amp; Laverie</small>
          </span>
        </a>
        <nav class="d-none d-lg-flex align-items-center main-nav">
          <a href="page1_accueil.html" class="nav-link">Accueil</a>
          <a href="page8_tarifs.html" class="nav-link active" aria-current="page">Tarifs</a>
          <a href="profil.jsp" class="nav-icon-btn mx-2" aria-label="Profil">
            <i class="bi bi-person"></i>
          </a>
          <a href="apropos.jsp" class="nav-link">À propos</a>
        </nav>
        <div class="d-flex align-items-center gap-2">
          <button class="d-lg-none btn btn-link text-dark p-1" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileNav" aria-label="Ouvrir le menu">
            <i class="bi bi-list fs-2"></i>
          </button>
          <a href="#connexion" class="btn-login d-none d-sm-inline-flex">Connexion</a>
        </div>

      </div>
    </div>
  </header>

  <div class="offcanvas offcanvas-end" tabindex="-1" id="mobileNav" style="background:var(--color-cream);">
    <div class="offcanvas-header">
      <span class="brand-mark"><span class="monogram"><span>L·V</span></span> Lavanda</span>
      <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Fermer"></button>
    </div>
    <div class="offcanvas-body">
      <a href="page1_accueil.html" class="nav-link d-block py-2 fs-5">Accueil</a>
      <a href="page8_tarifs.html" class="nav-link d-block py-2 fs-5 active">Tarifs</a>
      <a href="profil.jsp" class="nav-link d-block py-2 fs-5">Profil</a>
      <a href="apropos.jsp" class="nav-link d-block py-2 fs-5">À propos</a>
      <a href="#connexion" class="btn-login d-inline-flex mt-3">Connexion</a>
    </div>
  </div>

  <section class="page-hero parallax-wrap">
    <div class="hero-wave-bg">
      <svg viewBox="0 0 1440 600" preserveAspectRatio="xMidYMid slice" class="parallax-layer" data-speed="0.08">
        <path d="M0,420 C280,500 480,340 760,400 C1040,460 1180,360 1440,420 L1440,600 L0,600 Z"
              fill="#659ab9" opacity="0.10"></path>
        <path d="M0,460 C300,380 520,520 800,460 C1080,400 1220,500 1440,460 L1440,600 L0,600 Z"
              fill="#eaa93d" opacity="0.10"></path>
      </svg>
    </div>

    <div class="container position-relative" style="z-index:1;">
      <div class="row justify-content-center text-center">
        <div class="col-lg-8">
          <p class="eyebrow justify-content-center" data-reveal="fade">Nos tarifs</p>
          <h1 class="display-1 mt-3" style="font-size:clamp(2.6rem, 6vw, 4.2rem);">
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
          <h2 class="mt-3" style="font-size:clamp(1.8rem, 3vw, 2.6rem);">Prix par vêtement et par matière</h2>
        </div>
        <div class="col-lg-5 offset-lg-1 d-flex align-items-end" data-reveal="up" data-reveal-class="delay-1">
          <p class="text-muted-soft mb-0">
            Nos tarifs varient selon le type de tissu : coton, satin ou lin. Chaque matière nécessite un traitement spécifique pour préserver sa qualité.
          </p>
        </div>
      </div>

      <div class="table-responsive" data-reveal="up" data-reveal-class="delay-2">
        <table class="table align-middle" style="border-collapse:separate; border-spacing:0 12px;">
          <thead>
            <tr style="font-family:var(--font-body); font-size:0.78rem; letter-spacing:0.1em; text-transform:uppercase; color:var(--color-blue-light);">
              <th class="border-0 ps-4">Vêtement</th>
              <th class="border-0 text-center">Coton</th>
              <th class="border-0 text-center">Satin</th>
              <th class="border-0 text-center">Lin</th>
            </tr>
          </thead>
          <tbody>
            <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
              <td class="ps-4 rounded-start-4 py-3"><i class="bi bi-suit-spade-fill me-2 text-orange"></i>Chemise</td>
              <td class="text-center py-3">3 500 Ar</td>
              <td class="text-center py-3">4 800 Ar</td>
              <td class="text-center py-3">4 200 Ar</td>
              <td class="rounded-end-4"></td>
            </tr>
            <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
              <td class="ps-4 rounded-start-4 py-3"><i class="bi bi-bag-fill me-2 text-orange"></i>Pantalon</td>
              <td class="text-center py-3">4 000 Ar</td>
              <td class="text-center py-3">—</td>
              <td class="text-center py-3">4 600 Ar</td>
              <td class="rounded-end-4"></td>
            </tr>
            <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
              <td class="ps-4 rounded-start-4 py-3"><i class="bi bi-flower2 me-2 text-orange"></i>Robe</td>
              <td class="text-center py-3">5 200 Ar</td>
              <td class="text-center py-3">7 000 Ar</td>
              <td class="text-center py-3">6 100 Ar</td>
              <td class="rounded-end-4"></td>
            </tr>
            <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
              <td class="ps-4 rounded-start-4 py-3"><i class="bi bi-umbrella-fill me-2 text-orange"></i>Veste / Manteau</td>
              <td class="text-center py-3">6 800 Ar</td>
              <td class="text-center py-3">—</td>
              <td class="text-center py-3">7 400 Ar</td>
              <td class="rounded-end-4"></td>
            </tr>
            <tr style="background:#fff; box-shadow:var(--shadow-soft); border-radius:var(--radius-sm);">
              <td class="ps-4 rounded-start-4 py-3"><i class="bi bi-square-fill me-2 text-orange"></i>Draps / Couvertures</td>
              <td class="text-center py-3">5 500 Ar</td>
              <td class="text-center py-3">—</td>
              <td class="text-center py-3">6 000 Ar</td>
              <td class="rounded-end-4"></td>
            </tr>
          </tbody>
        </table>
      </div>
      <p class="text-muted-soft small mt-3" data-reveal="fade">* Tarifs indicatifs en ariary (Ar), pour un lavage standard. Le pressing et le repassage sont disponibles en supplément.</p>

    </div>
  </section>

  <!-- ============================================================
       FOOTER
  ============================================================ -->
  <footer class="site-footer">
    <div class="container">
      <div class="row g-4">
        <div class="col-lg-4">
          <span class="brand-mark mb-3" style="color:var(--color-cream);">
            <span class="monogram"><span>L·V</span></span> Lavanda
          </span>
          <p class="mt-3" style="opacity:0.7; max-width:320px;">Pressing &amp; laverie premium à Antananarivo. Votre linge, notre attention.</p>
        </div>
        <div class="col-6 col-lg-2">
          <h6>Navigation</h6>
          <div class="d-flex flex-column gap-2">
            <a href="page1_accueil.html">Accueil</a>
            <a href="page8_tarifs.html">Tarifs</a>
            <a href="profil.jsp">Profil</a>
            <a href="apropos.jsp">À propos</a>
          </div>
        </div>
        <div class="col-6 col-lg-3">
          <h6>Contact</h6>
          <div class="d-flex flex-column gap-2">
            <span><i class="bi bi-telephone me-2"></i>034 00 000 00</span>
            <span><i class="bi bi-envelope me-2"></i>contact@lavanda.mg</span>
          </div>
        </div>
        <div class="col-lg-3">
          <h6>Suivez-nous</h6>
          <div class="d-flex gap-2">
            <a href="#" class="nav-icon-btn" style="background:rgba(255,255,255,0.1); color:var(--color-cream);"><i class="bi bi-facebook"></i></a>
            <a href="#" class="nav-icon-btn" style="background:rgba(255,255,255,0.1); color:var(--color-cream);"><i class="bi bi-instagram"></i></a>
            <a href="#" class="nav-icon-btn" style="background:rgba(255,255,255,0.1); color:var(--color-cream);"><i class="bi bi-whatsapp"></i></a>
          </div>
        </div>
      </div>
      <hr class="footer-divider">
      <div class="d-flex flex-wrap justify-content-between footer-bottom">
        <span>© 2026 Lavanda. Tous droits réservés.</span>
        <span>Antananarivo, Madagascar</span>
      </div>
    </div>
  </footer>

  <!-- Scripts -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="animations.js"></script>
</body>
</html>
