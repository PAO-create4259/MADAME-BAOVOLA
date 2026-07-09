-- Création de la base de données
CREATE DATABASE cleancareclothes;

-- Connexion à la base de données
\c cleancareclothes;

CREATE TABLE client
(
    id_client VARCHAR(10) PRIMARY KEY,
    nom       VARCHAR(100) NOT NULL,
    prenom    VARCHAR(100) NOT NULL DEFAULT '',
    telephone VARCHAR(100) NOT NULL
);

-- Séquence : seq_client
CREATE SEQUENCE seq_client START WITH 1;

-- Fonction : next_id_client()
CREATE OR REPLACE FUNCTION next_id_client()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.id_client := 'CLT' || TO_CHAR(nextval('seq_client'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_client
CREATE TRIGGER trigger_next_id_client
    BEFORE INSERT ON client
    FOR EACH ROW
EXECUTE FUNCTION next_id_client();


-- Table : categorie
CREATE TABLE categorie
(
    id_categorie SERIAL PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL
);

INSERT INTO categorie (nom)
VALUES
    ('Sous-vêtements - Chaussettes'),
    ('T-shirt - Débardeur'),
    ('Polo - Chemise'),
    ('Pantalon - Jean - Jupe'),
    ('Robe'),
    ('Pull - Gilet'),
    ('Bedding - Rideaux'),
    ('Chaussures');


-- Table : tarif_livraison
CREATE TABLE tarif_livraison
(
    id_tarif_livraison SERIAL PRIMARY KEY,
    prix_unitaire      NUMERIC(10, 2) NOT NULL,
    part_livreur       INTEGER        NOT NULL DEFAULT 75
);

INSERT INTO tarif_livraison (prix_unitaire)
VALUES (5000);

-- Table : categorie_depense
CREATE TABLE categorie_depense
(
    id_categorie SERIAL PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL
);

INSERT INTO categorie_depense (nom)
VALUES
    ('Produits de nettoyage'),
    ('Loyer et Électricité'),
    ('Carburant et Transport'),
    ('Salaires'),
    ('Entretien matériel');


-- Table : utilisateur
CREATE TABLE utilisateur
(
    id_utilisateur VARCHAR(10) PRIMARY KEY,
    nom            VARCHAR(100) NOT NULL,
    identifiant    VARCHAR(50)  NOT NULL UNIQUE,
    mot_de_passe   VARCHAR(255) NOT NULL,
    role           VARCHAR(50)  NOT NULL,
    actif          BOOLEAN      NOT NULL DEFAULT TRUE,
    CONSTRAINT verif_role CHECK (role IN ('Administrateur', 'Gérant', 'Caissier', 'Livreur', 'Laveur'))
);

-- Séquence : seq_utilisateur
CREATE SEQUENCE seq_utilisateur START WITH 1;

-- Fonction : next_id_utilisateur_par_role()
CREATE OR REPLACE FUNCTION next_id_utilisateur_par_role()
    RETURNS TRIGGER AS
$$
DECLARE
    prefixe VARCHAR(3);
BEGIN
    CASE NEW.role
        WHEN 'Administrateur' THEN prefixe := 'ADM';
        WHEN 'Gérant'         THEN prefixe := 'GTR';
        WHEN 'Caissier'       THEN prefixe := 'CAS';
        WHEN 'Livreur'        THEN prefixe := 'LIV';
        WHEN 'Laveur'         THEN prefixe := 'LAV';
        ELSE                       prefixe := 'USR';
        END CASE;

    NEW.id_utilisateur := prefixe || TO_CHAR(nextval('seq_utilisateur'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_utilisateur
CREATE TRIGGER trigger_next_id_utilisateur
    BEFORE INSERT ON utilisateur
    FOR EACH ROW
EXECUTE FUNCTION next_id_utilisateur_par_role();

INSERT INTO utilisateur(nom, identifiant, mot_de_passe, role)
VALUES('Tony Mahefa', 'dahimatsu', 'admin123', 'Administrateur');

INSERT INTO utilisateur (nom, identifiant, mot_de_passe, role, actif)
VALUES ('Rakoto Jean', 'gerant_jean', 'gerant123', 'Gérant', true);

-- Insertion du Caissier
INSERT INTO utilisateur (nom, identifiant, mot_de_passe, role, actif)
VALUES ('Rasoa Marie', 'caisse_marie', 'caisse123', 'Caissier', true);

-- Insertion du Livreur
INSERT INTO utilisateur (nom, identifiant, mot_de_passe, role, actif)
VALUES ('Andry Solo', 'livreur_andry', 'livreur123', 'Livreur', true);

-- Insertion du Laveur
INSERT INTO utilisateur (nom, identifiant, mot_de_passe, role, actif)
VALUES ('Tovo Naina', 'laveur_tovo', 'laveur123', 'Laveur', true);
-- ==============================================================================
-- 2. TABLES DÉPENDANTES (Avec clés étrangères)
-- ==============================================================================

-- Table : tarif
CREATE TABLE tarif
(
    id_tarif     SERIAL PRIMARY KEY,
    id_categorie INTEGER        NOT NULL,
    prix         NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_categorie FOREIGN KEY (id_categorie)
        REFERENCES categorie (id_categorie)
);

INSERT INTO tarif(id_categorie, prix)
VALUES
    (1, 100),
    (2, 300),
    (3, 400),
    (4, 500),
    (5, 600),
    (6, 700),
    (7, 800),
    (8, 1000);


-- Table : lavage
CREATE TABLE lavage
(
    id_lavage     VARCHAR(10) PRIMARY KEY,
    id_client     VARCHAR(10) NOT NULL,
    date_commande TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    statut        VARCHAR(50) NOT NULL DEFAULT 'En attente',
    date_retrait  TIMESTAMP,
    CONSTRAINT fk_client FOREIGN KEY (id_client)
        REFERENCES client (id_client),
    CONSTRAINT verif_statut CHECK (statut IN ('En attente', 'Linge récupéré', 'En lavage', 'Prêt à récupérer'))
);


-- Séquence : seq_lavage
CREATE SEQUENCE seq_lavage START WITH 1;

-- Fonction : next_id_lavage()
CREATE OR REPLACE FUNCTION next_id_lavage()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.id_lavage := 'LVG' || TO_CHAR(nextval('seq_lavage'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_lavage
CREATE TRIGGER trigger_next_id_lavage
    BEFORE INSERT ON lavage
    FOR EACH ROW
EXECUTE FUNCTION next_id_lavage();


-- Table : detail_lavage
CREATE TABLE detail_lavage
(
    id_detail     SERIAL PRIMARY KEY,
    id_lavage     VARCHAR(10)    NOT NULL,
    id_categorie  INTEGER        NOT NULL,
    quantite      INTEGER        NOT NULL DEFAULT 1,
    prix_unitaire NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_lavage FOREIGN KEY (id_lavage)
        REFERENCES lavage (id_lavage),
    CONSTRAINT fk_categorie FOREIGN KEY (id_categorie)
        REFERENCES categorie (id_categorie)
);


-- Table : depot_linge
CREATE TABLE depot_linge
(
    id_depot     VARCHAR(10) PRIMARY KEY,
    id_lavage    VARCHAR(10) NOT NULL UNIQUE,
    date_arrivee TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    remarque     VARCHAR(200),
    CONSTRAINT fk_depot_lavage FOREIGN KEY (id_lavage)
        REFERENCES lavage (id_lavage)
);

-- Séquence : seq_depot
CREATE SEQUENCE seq_depot START WITH 1;

-- Fonction : next_id_depot()
CREATE OR REPLACE FUNCTION next_id_depot()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.id_depot := 'DPT' || TO_CHAR(nextval('seq_depot'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_depot
CREATE TRIGGER trigger_next_id_depot
    BEFORE INSERT ON depot_linge
    FOR EACH ROW
EXECUTE FUNCTION next_id_depot();


-- Table : recuperation
CREATE TABLE recuperation
(
    id_recuperation   VARCHAR(10) PRIMARY KEY,
    id_lavage         VARCHAR(10)  NOT NULL,
    date_recuperation DATE         NOT NULL,
    lieu_recuperation VARCHAR(100) NOT NULL,
    numero_appeler    VARCHAR(100) NOT NULL,
    id_livreur        VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_lavage FOREIGN KEY (id_lavage)
        REFERENCES lavage (id_lavage),
    CONSTRAINT fk_livreur FOREIGN KEY (id_livreur)
        REFERENCES utilisateur (id_utilisateur)
);

-- Séquence : seq_recuperation
CREATE SEQUENCE seq_recuperation START WITH 1;

-- Fonction : next_id_recuperation()
CREATE OR REPLACE FUNCTION next_id_recuperation()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.id_recuperation := 'RCP' || TO_CHAR(nextval('seq_recuperation'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_recuperation
CREATE TRIGGER trigger_next_id_recuperation
    BEFORE INSERT ON recuperation
    FOR EACH ROW
EXECUTE FUNCTION next_id_recuperation();

ALTER TABLE recuperation ALTER COLUMN id_livreur DROP NOT NULL;

-- Table : livraison
CREATE TABLE livraison
(
    id_livraison   VARCHAR(10) PRIMARY KEY,
    id_lavage      VARCHAR(10)  NOT NULL,
    date_livraison DATE         NOT NULL,
    lieu_livraison VARCHAR(100) NOT NULL,
    numero_appeler VARCHAR(100) NOT NULL,
    id_livreur     VARCHAR(10)  NOT NULL,
    CONSTRAINT fk_livraison_lavage FOREIGN KEY (id_lavage)
        REFERENCES lavage (id_lavage),
    CONSTRAINT fk_livreur FOREIGN KEY (id_livreur)
        REFERENCES utilisateur (id_utilisateur)
);

-- Séquence : seq_livraison
CREATE SEQUENCE seq_livraison START WITH 1;

-- Fonction : next_id_livraison()
CREATE OR REPLACE FUNCTION next_id_livraison()
    RETURNS TRIGGER AS
$$
BEGIN
    NEW.id_livraison := 'LVR' || TO_CHAR(nextval('seq_livraison'), 'FM000000');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_next_id_livraison
CREATE TRIGGER trigger_next_id_livraison
    BEFORE INSERT ON livraison
    FOR EACH ROW
EXECUTE FUNCTION next_id_livraison();


-- Table : facture
CREATE TABLE facture
(
    id_facture      VARCHAR(20) PRIMARY KEY,
    id_lavage       VARCHAR(10)    NOT NULL UNIQUE,
    date_facture    TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    prix_livraison  NUMERIC(10, 2) NOT NULL DEFAULT 0,
    montant_total   NUMERIC(10, 2) NOT NULL DEFAULT 0,
    statut_paiement VARCHAR(50)    NOT NULL DEFAULT 'Non payé',
    CONSTRAINT fk_facture_lavage FOREIGN KEY (id_lavage)
        REFERENCES lavage (id_lavage),
    CONSTRAINT verif_statut_paiement CHECK (statut_paiement IN ('Non payé', 'Payé'))
);

-- Fonction : generer_id_facture()
CREATE OR REPLACE FUNCTION generer_id_facture()
    RETURNS TRIGGER AS
$$
DECLARE
    date_du_jour VARCHAR;
    prochain_numero INTEGER;
BEGIN
    date_du_jour := TO_CHAR(CURRENT_TIMESTAMP, 'DDMMYYYY');

    SELECT COALESCE(MAX(SUBSTRING(id_facture FROM 5 FOR 4)::INTEGER), 0) + 1
    INTO prochain_numero
    FROM facture
    WHERE id_facture LIKE '%-' || date_du_jour;

    NEW.id_facture := 'FCT-' || TO_CHAR(prochain_numero, 'FM0000') || '-' || date_du_jour;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Déclencheur (Trigger) : trigger_creation_facture
CREATE TRIGGER trigger_creation_facture
    BEFORE INSERT ON facture
    FOR EACH ROW
EXECUTE FUNCTION generer_id_facture();


-- Table : depense
CREATE TABLE depense
(
    id_depense   SERIAL PRIMARY KEY,
    id_categorie INTEGER        NOT NULL,
    montant      NUMERIC(10, 2) NOT NULL,
    date_depense TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    description  VARCHAR(255),
    CONSTRAINT fk_categorie_depense FOREIGN KEY (id_categorie)
        REFERENCES categorie_depense (id_categorie)
);

SELECT * FROM utilisateur;


SELECT * FROM categorie;

CREATE OR REPLACE VIEW v_categorie_tarif AS
SELECT
    c.id_categorie,
    c.nom AS nom_categorie,
    t.id_tarif,
    t.prix
FROM
    categorie c
        JOIN
    tarif t ON c.id_categorie = t.id_categorie;

SELECT * FROM v_categorie_tarif;

-- migration_V2 Tahina
ALTER TABLE recuperation ALTER COLUMN id_livreur DROP NOT NULL;
ALTER TABLE livraison ALTER COLUMN id_livreur DROP NOT NULL;

-- Migration v3 : persistance du choix client "récupération sur place"
ALTER TABLE lavage ADD COLUMN IF NOT EXISTS mode_retrait VARCHAR(20);
ALTER TABLE lavage ADD CONSTRAINT verif_mode_retrait
    CHECK (mode_retrait IN ('sur_place', 'domicile') OR mode_retrait IS NULL);

INSERT INTO tarif_livraison (prix_unitaire)
VALUES (5000);

Select * from depense;

ALTER TABLE lavage DROP CONSTRAINT verif_statut;

ALTER TABLE lavage ADD CONSTRAINT verif_statut CHECK (statut IN ('En attente', 'Linge récupéré', 'En lavage', 'Prêt à récupérer', 'Annulé'));