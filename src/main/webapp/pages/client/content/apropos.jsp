<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>À propos — Pressing &amp; Laverie</title>
  <meta name="description" content="Découvrez l'histoire de Lavanda, nos services, notre localisation et notre équipe.">

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
  <link rel="stylesheet" href="page8_9_10.css">

  <style>
    .story-img-wrap {
      position: relative;
      border-radius: var(--radius-lg);
      overflow: hidden;
      box-shadow: var(--shadow-lift);
      aspect-ratio: 4/5;
    }
    .story-img-wrap img {
      width: 100%; height: 100%;
      object-fit: cover;
      transition: transform 0.8s var(--ease-premium);
    }
    .story-img-wrap:hover img { transform: scale(1.05); }
    .story-img-badge {
      position: absolute;
      bottom: 24px; left: 24px;
      background: rgba(255,251,239,0.92);
      backdrop-filter: blur(8px);
      border-radius: var(--radius-sm);
      padding: 14px 20px;
      box-shadow: var(--shadow-soft);
    }
    .story-img-badge .num { font-family: var(--font-display); font-size: 1.6rem; color: var(--color-blue-dark); font-weight: 600; }
    .story-img-badge .lbl { font-size: 0.72rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.06em; }

    /* Timeline verticale */
    .timeline { position: relative; padding-left: 32px; }
    .timeline::before {
      content: '';
      position: absolute; left: 6px; top: 6px; bottom: 6px;
      width: 2px;
      background: linear-gradient(180deg, var(--color-orange), rgba(101,154,185,0.3));
    }
    .timeline-item { position: relative; padding-bottom: 36px; }
    .timeline-item:last-child { padding-bottom: 0; }
    .timeline-item::before {
      content: '';
      position: absolute; left: -32px; top: 4px;
      width: 14px; height: 14px;
      border-radius: 50%;
      background: var(--color-orange);
      border: 3px solid var(--color-cream);
      box-shadow: 0 0 0 2px var(--color-orange);
    }
    .timeline-item .year { font-family: var(--font-display); font-weight: 600; color: var(--color-blue-light); font-size: 1.05rem; }

    /* Cartes services */
    .service-card {
      padding: 36px 28px;
      border-radius: var(--radius-md);
      background: var(--color-white);
      box-shadow: var(--shadow-soft);
      transition: all 0.5s var(--ease-premium);
      height: 100%;
    }
    .service-card:hover {
      transform: translateY(-8px);
      box-shadow: var(--shadow-lift);
    }
    .service-card .service-icon {
      width: 56px; height: 56px;
      border-radius: 16px;
      display: flex; align-items: center; justify-content: center;
      font-size: 1.5rem;
      margin-bottom: 22px;
      transition: transform 0.5s var(--ease-premium);
    }
    .service-card:hover .service-icon { transform: rotate(-8deg) scale(1.08); }

    /* Carte / localisation */
    .map-card {
      border-radius: var(--radius-lg);
      overflow: hidden;
      box-shadow: var(--shadow-lift);
      height: 100%;
      min-height: 340px;
    }
    .map-card iframe { width: 100%; height: 100%; border: 0; filter: saturate(0.85); }

    /* Cartes contact */
    .contact-mini-card {
      display: flex; align-items: center; gap: 16px;
      padding: 20px 24px;
      border-radius: var(--radius-sm);
      background: var(--color-white);
      box-shadow: var(--shadow-soft);
      transition: transform 0.4s var(--ease-premium), box-shadow 0.4s var(--ease-premium);
    }
    .contact-mini-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lift); }
    .contact-mini-card .ic {
      width: 48px; height: 48px;
      border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      background: rgba(101,154,185,0.12);
      color: var(--color-blue-light);
      flex-shrink: 0;
      font-size: 1.2rem;
    }

    /* Équipe */
    .team-card { text-align: center; }
    .team-photo {
      width: 132px; height: 132px;
      border-radius: 50%;
      margin: 0 auto 20px;
      overflow: hidden;
      box-shadow: var(--shadow-soft);
      border: 4px solid var(--color-white);
    }
    .team-photo img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s var(--ease-premium); }
    .team-card:hover .team-photo img { transform: scale(1.1); }
    .team-card .role { font-size: 0.82rem; color: var(--color-blue-light); text-transform: uppercase; letter-spacing: 0.05em; }
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
          <a href="tarif.jsp" class="nav-link">Tarifs</a>
          <a href="profil.jsp" class="nav-icon-btn mx-2" aria-label="Profil">
            <i class="bi bi-person"></i>
          </a>
          <a href="page10_apropos.html" class="nav-link active" aria-current="page">À propos</a>
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
      <a href="tarif.jsp" class="nav-link d-block py-2 fs-5">Tarifs</a>
      <a href="profil.jsp" class="nav-link d-block py-2 fs-5">Profil</a>
      <a href="page10_apropos.html" class="nav-link d-block py-2 fs-5 active">À propos</a>
      <a href="#connexion" class="btn-login d-inline-flex mt-3">Connexion</a>
    </div>
  </div>

  <!-- ============================================================
       HERO — À propos
  ============================================================ -->
  <section class="page-hero parallax-wrap">
    <div class="hero-wave-bg">
      <svg viewBox="0 0 1440 600" preserveAspectRatio="xMidYMid slice" class="parallax-layer" data-speed="0.08">
        <path d="M0,420 C280,500 480,340 760,400 C1040,460 1180,360 1440,420 L1440,600 L0,600 Z" fill="#659ab9" opacity="0.10"></path>
        <path d="M0,460 C300,380 520,520 800,460 C1080,400 1220,500 1440,460 L1440,600 L0,600 Z" fill="#eaa93d" opacity="0.10"></path>
      </svg>
    </div>

    <div class="container position-relative" style="z-index:1;">
      <div class="row justify-content-center text-center">
        <div class="col-lg-8">
          <p class="eyebrow justify-content-center" data-reveal="fade">Notre histoire</p>
          <h1 class="mt-3" style="font-size:clamp(2.6rem, 6vw, 4.2rem);">
            <span class="text-reveal-line">Prendre soin du linge,</span>
            <span class="text-reveal-line"><em style="font-style:italic; color:var(--color-blue-light);">prendre soin des gens</em></span>
          </h1>
          <p class="lead text-muted-soft mt-4 mx-auto" style="max-width:580px;" data-reveal="up">
            Depuis nos débuts, Lavanda s'engage à offrir un service de lavage soigné, fiable et accessible à tous les foyers d'Antananarivo.
          </p>
        </div>
      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION — Notre histoire (image + timeline)
  ============================================================ -->
  <section class="section-pad">
    <div class="container">
      <div class="row g-5 align-items-center">

        <div class="col-lg-5" data-reveal="left">
          <div class="story-img-wrap">
            <img src="https://images.unsplash.com/photo-1545173168-9f1947eebb7f?w=800&q=80" alt="Intérieur chaleureux de la laverie Lavanda">
            <div class="story-img-badge">
              <div class="num">3+</div>
              <div class="lbl">Années d'expérience</div>
            </div>
          </div>
        </div>

        <div class="col-lg-7" data-reveal="right">
          <p class="eyebrow">Depuis le premier jour</p>
          <h2 class="mt-3 mb-4" style="font-size:clamp(1.8rem, 3vw, 2.6rem);">Une laverie pensée pour votre quotidien</h2>
          <p class="text-muted-soft mb-4">
            Lavanda est née d'une idée simple : faire gagner du temps aux familles et aux professionnels tout en garantissant un lavage soigné, respectueux de chaque type de tissu.
          </p>

          <div class="timeline mt-4">
            <div class="timeline-item" data-reveal="up" data-reveal-class="delay-1">
              <div class="year">2023</div>
              <p class="text-muted-soft mb-0">Ouverture de notre première laverie à Antananarivo, avec deux machines et une grande ambition.</p>
            </div>
            <div class="timeline-item" data-reveal="up" data-reveal-class="delay-2">
              <div class="year">2024</div>
              <p class="text-muted-soft mb-0">Lancement du service de récupération et de livraison à domicile, pour plus de confort.</p>
            </div>
            <div class="timeline-item" data-reveal="up" data-reveal-class="delay-3">
              <div class="year">2026</div>
              <p class="text-muted-soft mb-0">Digitalisation complète du suivi de lavage, pour une expérience client transparente et rassurante.</p>
            </div>
          </div>
        </div>

      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION — Nos services
  ============================================================ -->
  <section class="section-pad" style="background:var(--color-cream-2);">
    <div class="container">

      <div class="text-center mb-5">
        <p class="eyebrow justify-content-center" data-reveal="fade">Ce que nous proposons</p>
        <h2 class="mt-3" style="font-size:clamp(1.8rem, 3vw, 2.6rem);" data-reveal="up">Nos services</h2>
      </div>

      <div class="row g-4">

        <div class="col-md-6 col-lg-3" data-reveal="up" data-reveal-class="delay-1">
          <div class="service-card">
            <div class="service-icon" style="background:rgba(101,154,185,0.14); color:var(--color-blue-light);">
              <i class="bi bi-droplet-half"></i>
            </div>
            <h3 class="h5">Lavage standard</h3>
            <p class="text-muted-soft mb-0">Lavage soigné adapté à chaque type de tissu : coton, satin et lin.</p>
          </div>
        </div>

        <div class="col-md-6 col-lg-3" data-reveal="up" data-reveal-class="delay-2">
          <div class="service-card">
            <div class="service-icon" style="background:rgba(234,169,61,0.16); color:var(--color-orange);">
              <i class="bi bi-truck"></i>
            </div>
            <h3 class="h5">Récupération &amp; livraison</h3>
            <p class="text-muted-soft mb-0">Nous venons chercher et livrons votre linge directement chez vous.</p>
          </div>
        </div>

        <div class="col-md-6 col-lg-3" data-reveal="up" data-reveal-class="delay-3">
          <div class="service-card">
            <div class="service-icon" style="background:rgba(55,70,99,0.1); color:var(--color-blue-dark);">
              <i class="bi bi-stars"></i>
            </div>
            <h3 class="h5">Pressing &amp; repassage</h3>
            <p class="text-muted-soft mb-0">Un fini impeccable pour vos vêtements les plus précieux.</p>
          </div>
        </div>

        <div class="col-md-6 col-lg-3" data-reveal="up" data-reveal-class="delay-4">
          <div class="service-card">
            <div class="service-icon" style="background:rgba(101,154,185,0.14); color:var(--color-blue-light);">
              <i class="bi bi-phone"></i>
            </div>
            <h3 class="h5">Suivi en temps réel</h3>
            <p class="text-muted-soft mb-0">Suivez l'avancement de votre lavage à chaque étape, en ligne.</p>
          </div>
        </div>

      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION — Localisation
  ============================================================ -->
  <section class="section-pad">
    <div class="container">
      <div class="row g-5 align-items-center">

        <div class="col-lg-6" data-reveal="left">
          <p class="eyebrow">Venez nous voir</p>
          <h2 class="mt-3 mb-4" style="font-size:clamp(1.8rem, 3vw, 2.6rem);">Notre laverie</h2>
          <p class="text-muted-soft mb-4">
            Notre point de service principal se trouve au cœur d'Antananarivo, facilement accessible et ouvert six jours sur sept.
          </p>

          <div class="d-flex flex-column gap-3">
            <div class="contact-mini-card">
              <div class="ic"><i class="bi bi-geo-alt-fill"></i></div>
              <div>
                <div class="fw-semibold" style="color:var(--color-blue-dark);">Adresse</div>
                <div class="text-muted-soft small">Lot II A 42, Andohaloalo, Antananarivo 101</div>
              </div>
            </div>
            <div class="contact-mini-card">
              <div class="ic"><i class="bi bi-clock-fill"></i></div>
              <div>
                <div class="fw-semibold" style="color:var(--color-blue-dark);">Horaires</div>
                <div class="text-muted-soft small">Lundi – Samedi, 7h30 – 18h00</div>
              </div>
            </div>
          </div>
        </div>

        <div class="col-lg-6" data-reveal="right">
          <div class="map-card">
            <iframe
              src="https://www.openstreetmap.org/export/embed.html?bbox=47.495%2C-18.93%2C47.535%2C-18.90&layer=mapnik&marker=-18.915,47.515"
              loading="lazy"
              referrerpolicy="no-referrer-when-downgrade"
              title="Localisation de la laverie Lavanda à Antananarivo"></iframe>
          </div>
        </div>

      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION — Contact
  ============================================================ -->
  <section class="section-pad" style="background:var(--color-cream-2);">
    <div class="container">
      <div class="text-center mb-5">
        <p class="eyebrow justify-content-center" data-reveal="fade">Restons en contact</p>
        <h2 class="mt-3" style="font-size:clamp(1.8rem, 3vw, 2.6rem);" data-reveal="up">Une question ? Contactez-nous</h2>
      </div>

      <div class="row g-4 justify-content-center">
        <div class="col-md-5 col-lg-4" data-reveal="up" data-reveal-class="delay-1">
          <div class="contact-mini-card justify-content-center">
            <div class="ic"><i class="bi bi-telephone-fill"></i></div>
            <div>
              <div class="fw-semibold" style="color:var(--color-blue-dark);">Téléphone</div>
              <div class="text-muted-soft small">034 00 000 00</div>
            </div>
          </div>
        </div>
        <div class="col-md-5 col-lg-4" data-reveal="up" data-reveal-class="delay-2">
          <div class="contact-mini-card justify-content-center">
            <div class="ic"><i class="bi bi-envelope-fill"></i></div>
            <div>
              <div class="fw-semibold" style="color:var(--color-blue-dark);">Email</div>
              <div class="text-muted-soft small">contact@lavanda.mg</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ============================================================
       SECTION — Nos collaborateurs
  ============================================================ -->
  <section class="section-pad">
    <div class="container">
      <div class="text-center mb-5">
        <p class="eyebrow justify-content-center" data-reveal="fade">L'équipe</p>
        <h2 class="mt-3" style="font-size:clamp(1.8rem, 3vw, 2.6rem);" data-reveal="up">Nos collaborateurs</h2>
        <p class="text-muted-soft mt-3 mx-auto" style="max-width:520px;" data-reveal="up" data-reveal-class="delay-1">
          Une équipe passionnée, attentive à chaque détail pour vous offrir le meilleur service.
        </p>
      </div>

      <div class="row g-4 justify-content-center">

        <div class="col-6 col-md-4 col-lg-3" data-reveal="up" data-reveal-class="delay-1">
          <div class="team-card">
            <div class="team-photo">
              <img src="https://images.unsplash.com/photo-1607746882042-944635dfe10e?w=300&q=80" alt="Membre de l'équipe Lavanda">
            </div>
            <h3 class="h6 mb-1">Hery Andrianina</h3>
            <div class="role">Fondateur</div>
          </div>
        </div>

        <div class="col-6 col-md-4 col-lg-3" data-reveal="up" data-reveal-class="delay-2">
          <div class="team-card">
            <div class="team-photo">
              <img src="https://images.unsplash.com/photo-1573497019940-1c28c88b4f3e?w=300&q=80" alt="Membre de l'équipe Lavanda">
            </div>
            <h3 class="h6 mb-1">Mialy Rasoanaivo</h3>
            <div class="role">Responsable qualité</div>
          </div>
        </div>

        <div class="col-6 col-md-4 col-lg-3" data-reveal="up" data-reveal-class="delay-3">
          <div class="team-card">
            <div class="team-photo">
              <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=300&q=80" alt="Membre de l'équipe Lavanda">
            </div>
            <h3 class="h6 mb-1">Tojo Rabemananjara</h3>
            <div class="role">Livreur</div>
          </div>
        </div>

        <div class="col-6 col-md-4 col-lg-3" data-reveal="up" data-reveal-class="delay-4">
          <div class="team-card">
            <div class="team-photo">
              <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?w=300&q=80" alt="Membre de l'équipe Lavanda">
            </div>
            <h3 class="h6 mb-1">Nantenaina Rivo</h3>
            <div class="role">Agent de lavage</div>
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
            <a href="tarif.jsp">Tarifs</a>
            <a href="profil.jsp">Profil</a>
            <a href="page10_apropos.html">À propos</a>
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
