<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mon Profil — Pressing &amp; Laverie</title>
  <meta name="description" content="Consultez vos informations personnelles, votre historique de lavages et le suivi de vos lavages en cours.">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="page8_9_10.css">

  <style>
    .profile-avatar {
      width: 96px; height: 96px;
      border-radius: 50%;
      background: var(--color-blue-dark);
      color: var(--color-cream);
      display: flex; align-items: center; justify-content: center;
      font-family: var(--font-display);
      font-size: 2rem;
      font-weight: 600;
      box-shadow: var(--shadow-lift);
      border: 4px solid var(--color-cream);
      flex-shrink: 0;
    }
    .info-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 14px 0;
      border-bottom: 1px solid rgba(55,70,99,0.08);
    }
    .info-row:last-child { border-bottom: none; }
    .info-row .label { font-size: 0.82rem; color: var(--text-muted); }
    .info-row .value { font-weight: 600; color: var(--color-blue-dark); }

    .stat-block {
      text-align: center;
      padding: 28px 16px;
      border-radius: var(--radius-md);
      background: var(--color-white);
      box-shadow: var(--shadow-soft);
      transition: transform 0.45s var(--ease-premium), box-shadow 0.45s var(--ease-premium);
    }
    .stat-block:hover { transform: translateY(-6px); box-shadow: var(--shadow-lift); }
    .stat-block .num { font-family: var(--font-display); font-size: 2.3rem; color: var(--color-blue-dark); font-weight: 600; }
    .stat-block .lbl { font-size: 0.82rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.06em; }

    /* Liste lavages en cours - cliquable */
    .wash-item {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 16px;
      padding: 18px 22px;
      border-radius: var(--radius-sm);
      background: var(--color-white);
      box-shadow: var(--shadow-soft);
      transition: transform 0.4s var(--ease-premium), box-shadow 0.4s var(--ease-premium), border-color 0.4s;
      cursor: pointer;
      border: 1px solid transparent;
      text-decoration: none;
      color: inherit;
    }
    .wash-item:hover {
      transform: translateX(6px);
      box-shadow: var(--shadow-lift);
      border-color: rgba(234,169,61,0.4);
    }
    .wash-item .wash-icon {
      width: 46px; height: 46px;
      border-radius: 50%;
      background: rgba(101,154,185,0.12);
      display: flex; align-items: center; justify-content: center;
      color: var(--color-blue-light);
      flex-shrink: 0;
    }
    .wash-status-pill {
      font-size: 0.74rem;
      font-weight: 600;
      padding: 5px 14px;
      border-radius: 999px;
      white-space: nowrap;
    }
    .pill-progress { background: rgba(234,169,61,0.16); color: #9c6b1c; }
    .pill-wait { background: rgba(101,154,185,0.16); color: var(--color-blue-light); }

    /* Historique - tableau stylé */
    .history-table thead th {
      font-family: var(--font-body);
      font-size: 0.74rem;
      letter-spacing: 0.08em;
      text-transform: uppercase;
      color: var(--color-blue-light);
      border: 0;
      padding-bottom: 14px;
    }
    .history-table tbody tr {
      background: var(--color-white);
      box-shadow: var(--shadow-soft);
    }
    .history-table tbody td { padding: 14px 16px; vertical-align: middle; border: none; }
    .history-table tbody tr td:first-child { border-radius: var(--radius-sm) 0 0 var(--radius-sm); }
    .history-table tbody tr td:last-child { border-radius: 0 var(--radius-sm) var(--radius-sm) 0; }
    .history-table tbody tr + tr { box-shadow: var(--shadow-soft); }

    .badge-done-soft { background: rgba(101,154,185,0.16); color: var(--color-blue-light); font-weight: 600; padding: 6px 14px; border-radius: 999px; font-size: 0.78rem; }

    .tab-pill {
      border: none;
      background: transparent;
      font-family: var(--font-body);
      font-weight: 600;
      font-size: 0.92rem;
      color: var(--text-muted);
      padding: 10px 22px;
      border-radius: 999px;
      transition: all 0.35s var(--ease-premium);
    }
    .tab-pill.active {
      background: var(--color-blue-dark);
      color: var(--color-cream) !important;
    }
  </style>
</head>
<body>

  <!-- ============================================================
       HEADER / NAVIGATION
  ============================================================ -->
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
          <a href="tarifs-client.jsp" class="nav-link">Tarifs</a>
          <a href="page9_profil.html" class="nav-icon-btn mx-2" style="background:var(--color-blue-dark); color:var(--color-cream);" aria-label="Profil" aria-current="page">
            <i class="bi bi-person-fill"></i>
          </a>
          <a href="apropos-client.jsp" class="nav-link">À propos</a>
        </nav>

        <div class="d-flex align-items-center gap-2">
          <button class="d-lg-none btn btn-link text-dark p-1" type="button" data-bs-toggle="offcanvas" data-bs-target="#mobileNav" aria-label="Ouvrir le menu">
            <i class="bi bi-list fs-2"></i>
          </button>
          <a href="#" class="btn-login d-none d-sm-inline-flex"><i class="bi bi-box-arrow-right me-1"></i>Déconnexion</a>
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
      <a href="tarifs-client.jsp" class="nav-link d-block py-2 fs-5">Tarifs</a>
      <a href="page9_profil.html" class="nav-link d-block py-2 fs-5 active">Profil</a>
      <a href="apropos-client.jsp" class="nav-link d-block py-2 fs-5">À propos</a>
      <a href="#" class="btn-login d-inline-flex mt-3">Déconnexion</a>
    </div>
  </div>

  <!-- ============================================================
       HERO PROFIL — bandeau infos personnelles
  ============================================================ -->
  <section class="page-hero parallax-wrap pb-4">
    <div class="hero-wave-bg">
      <svg viewBox="0 0 1440 600" preserveAspectRatio="xMidYMid slice" class="parallax-layer" data-speed="0.08">
        <path d="M0,420 C280,500 480,340 760,400 C1040,460 1180,360 1440,420 L1440,600 L0,600 Z" fill="#659ab9" opacity="0.10"></path>
      </svg>
    </div>

    <div class="container position-relative" style="z-index:1;">
      <p class="eyebrow mb-3" data-reveal="fade">Mon espace</p>
      <div class="d-flex flex-column flex-sm-row align-items-center align-items-sm-end gap-4">
        <div class="profile-avatar" data-reveal="zoom">RJ</div>
        <div data-reveal="up" data-reveal-class="delay-1">
          <h1 style="font-size:clamp(2rem, 4vw, 2.8rem);">Rakoto Jean</h1>
          <p class="text-muted-soft mb-0">Client depuis janvier 2026 · N° 0341</p>
        </div>
      </div>
    </div>
  </section>

  <!-- ============================================================
       STATISTIQUES RAPIDES
  ============================================================ -->
  <section class="pt-3 pb-5">
    <div class="container">
      <div class="row g-3 g-md-4">
        <div class="col-6 col-md-3" data-reveal="up" data-reveal-class="delay-1">
          <div class="stat-block">
            <div class="num">12</div>
            <div class="lbl">Lavages terminés</div>
          </div>
        </div>
        <div class="col-6 col-md-3" data-reveal="up" data-reveal-class="delay-2">
          <div class="stat-block">
            <div class="num">1</div>
            <div class="lbl">En cours</div>
          </div>
        </div>
        <div class="col-6 col-md-3" data-reveal="up" data-reveal-class="delay-3">
          <div class="stat-block">
            <div class="num">2</div>
            <div class="lbl">Lavages avant réduction</div>
          </div>
        </div>
        <div class="col-6 col-md-3" data-reveal="up" data-reveal-class="delay-4">
          <div class="stat-block">
            <div class="num">186k</div>
            <div class="lbl">Ariary dépensés</div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION PRINCIPALE — Infos perso + Lavages en cours + Historique
  ============================================================ -->
  <section class="section-pad pt-0">
    <div class="container">
      <div class="row g-5">
        <div class="col-lg-4" data-reveal="left">
          <div class="card-premium p-4 p-lg-5">
            <h3 class="h5 mb-4"><i class="bi bi-person-vcard me-2 text-orange"></i>Informations personnelles</h3>

            <div class="info-row">
              <span class="label">Nom complet</span>
              <span class="value">Rakoto Jean</span>
            </div>
            <div class="info-row">
              <span class="label">Téléphone</span>
              <span class="value">034 00 000 01</span>
            </div>
            <div class="info-row">
              <span class="label">N° client</span>
              <span class="value">0341</span>
            </div>
            <div class="info-row">
              <span class="label">Adresse habituelle</span>
              <span class="value text-end">Lot II A 42, Tana</span>
            </div>
            <div class="info-row">
              <span class="label">Membre depuis</span>
              <span class="value">Jan. 2026</span>
            </div>

            <button class="btn-premium btn-outline w-100 justify-content-center mt-4">
              <i class="bi bi-pencil-square"></i> Modifier mes informations
            </button>
          </div>
        </div>

        <!-- Colonne droite : tabs Lavages en cours / Historique -->
        <div class="col-lg-8" data-reveal="right">

          <!-- Onglets -->
          <div class="d-flex gap-2 mb-4 flex-wrap" role="tablist">
            <button class="tab-pill active" data-bs-toggle="tab" data-bs-target="#tab-encours" type="button" role="tab">
              Lavages en cours <span class="badge bg-warning text-dark ms-1">1</span>
            </button>
            <button class="tab-pill" data-bs-toggle="tab" data-bs-target="#tab-historique" type="button" role="tab">
              Historique
            </button>
          </div>

          <div class="tab-content">

            <!-- Lavages en cours -->
            <div class="tab-pane fade show active" id="tab-encours" role="tabpanel">
              <div class="d-flex flex-column gap-3">

                <a href="page6_suivi.html" class="wash-item" data-reveal="up" data-reveal-class="delay-1">
                  <div class="d-flex align-items-center gap-3">
                    <div class="wash-icon"><i class="bi bi-droplet-half"></i></div>
                    <div>
                      <div class="fw-semibold" style="color:var(--color-blue-dark);">N° de suivi LAV-2026-0512</div>
                      <div class="text-muted-soft small">4 pièces · Coton — démarré aujourd'hui à 09h12</div>
                    </div>
                  </div>
                  <div class="d-flex align-items-center gap-3">
                    <span class="wash-status-pill pill-progress">Lavage en cours</span>
                    <i class="bi bi-chevron-right" style="color:var(--color-blue-light);"></i>
                  </div>
                </a>

              </div>
              <p class="text-muted-soft small mt-3"><i class="bi bi-info-circle me-1"></i>Cliquez sur un lavage pour voir le suivi détaillé en temps réel.</p>
            </div>

            <!-- Historique -->
            <div class="tab-pane fade" id="tab-historique" role="tabpanel">
              <div class="table-responsive">
                <table class="table history-table" style="border-collapse:separate; border-spacing:0 10px;">
                  <thead>
                    <tr>
                      <th>Date</th>
                      <th>N° suivi</th>
                      <th>Qté</th>
                      <th>Total</th>
                      <th>Statut</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr data-reveal="fade">
                      <td>09/06/2026</td>
                      <td>LAV-0498</td>
                      <td>3 pcs</td>
                      <td>12 600 Ar</td>
                      <td><span class="badge-done-soft">Terminé</span></td>
                    </tr>
                    <tr data-reveal="fade">
                      <td>02/06/2026</td>
                      <td>LAV-0471</td>
                      <td>6 pcs</td>
                      <td>24 800 Ar</td>
                      <td><span class="badge-done-soft">Terminé</span></td>
                    </tr>
                    <tr data-reveal="fade">
                      <td>26/05/2026</td>
                      <td>LAV-0450</td>
                      <td>2 pcs</td>
                      <td>7 400 Ar</td>
                      <td><span class="badge-done-soft">Terminé</span></td>
                    </tr>
                    <tr data-reveal="fade">
                      <td>18/05/2026</td>
                      <td>LAV-0432</td>
                      <td>5 pcs</td>
                      <td>19 200 Ar</td>
                      <td><span class="badge-done-soft">Terminé</span></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>

          </div>
        </div>

      </div>
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
            <a href="tarifs-client.jsp">Tarifs</a>
            <a href="page9_profil.html">Profil</a>
            <a href="apropos-client.jsp">À propos</a>
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

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="animations.js"></script>
</body>
</html>
