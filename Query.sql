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

--Script insertion

-- ==============================================================================
-- SQL POPULATOR SCRIPT: CLIENTS AND WASHING ORDERS
-- SCALE: 8 washes per day | Monday - Saturday | During one week
-- ==============================================================================

-- 1. CLEANUP PREVIOUS TEST DATA (UNCOMMENT IF NECESSARY)
-- TRUNCATE detail_lavage, depot_linge, recuperation, livraison, facture, lavage, client RESTART IDENTITY CASCADE;

-- 2. CLIENT INSERTION
-- The image image_8bc23a.png shows CLT000001, CLT000002, CLT000003. We continue the sequence.
-- ==============================================================================
BEGIN; -- Start a transaction

-- Existing clients as shown in the image (commented out as they should already exist)
-- INSERT INTO client(nom, prenom, telephone) VALUES('RAVELOMANANTSOA', 'Tony Mahefa', '0348545858');
-- INSERT INTO client(nom, prenom, telephone) VALUES('RAKOTOMANANA', 'Joseph', '03424049483');
-- INSERT INTO client(nom, prenom, telephone) VALUES('RAKOTOMANANA', 'Joseph', '03424049483'); -- CLT000003 from image

-- Inserting new test clients to continue the sequence
-- CLT000004
INSERT INTO client(nom, prenom, telephone) VALUES('ANDRIAMALALA', 'Aina', '0341122233');
-- CLT000005
INSERT INTO client(nom, prenom, telephone) VALUES('RABARY', 'Hery', '0320011122');
-- CLT000006
INSERT INTO client(nom, prenom, telephone) VALUES('SOAFENITRA', 'Fanjava', '0331020304');
-- CLT000007
INSERT INTO client(nom, prenom, telephone) VALUES('RANDRIANARIVO', 'Noël', '0380001000');
-- CLT000008 (The last client inserted based on the image's continuity)
INSERT INTO client(nom, prenom, telephone) VALUES('MALALASON', 'Mika', '0349876543');

COMMIT; -- End of client transaction

-- ==============================================================================
-- 3. WASHING ORDER GENERATION FUNCTION
-- We use a function to create realistic variations and automate the generation.
-- ==============================================================================
DROP FUNCTION IF EXISTS populate_washing_orders(); -- To ensure clean reuse
CREATE OR REPLACE FUNCTION populate_washing_orders()
    RETURNS VOID AS
$$
DECLARE
    -- The specified start date (Monday, July 13th, 2026 in CleanCare's real time)
    start_date DATE := '2026-07-13';

    -- Loop variables
    current_day DATE;
    current_order_date TIMESTAMP;
    generated_order_id VARCHAR(10);
    client_id VARCHAR(10);
    livreur_id VARCHAR(10);

    -- Random data generation variables
    random_category INTEGER;
    random_price NUMERIC;
    item_quantities INTEGER;
    num_items_random INTEGER;
    status VARCHAR(50);

BEGIN
    -- MAIN LOOP: 6 days (Monday to Saturday)
    FOR current_day_count IN 0..5 LOOP
            current_day := start_date + current_day_count;

            -- DAILY ORDER LOOP: 8 orders per day
            FOR daily_order_count IN 1..8 LOOP

                    -- realistic randomization of order intake time (e.g., between 8:00 and 17:00)
                    current_order_date := (current_day || ' 08:00:00')::TIMESTAMP + (daily_order_count * '1 hour'::INTERVAL) + (floor(random() * 60) * '1 minute'::INTERVAL);

                    -- Picking a random client from CLT000001 to CLT000008
                    client_id := 'CLT' || TO_CHAR(floor(random() * (8 - 1 + 1) + 1), 'FM000000');

                    -- Varying the order status for realism
                    CASE daily_order_count % 3
                        WHEN 0 THEN status := 'En attente';
                        WHEN 1 THEN status := 'Linge récupéré';
                        WHEN 2 THEN status := 'En lavage';
                        END CASE;

                    -- Insert new order, ID is generated by trigger
                    INSERT INTO lavage (id_client, date_commande, statut)
                    VALUES (client_id, current_order_date, status)
                    RETURNING id_lavage INTO generated_order_id;

                    -- NOUVEAU (based on rest to do list point 2 & 10):
                    -- Randomly generating Mode Retrait for 30% of orders for realism
                    IF random() < 0.3 THEN
                        UPDATE lavage SET mode_retrait = (CASE floor(random() * 2) WHEN 0 THEN 'sur_place' ELSE 'domicile' END) WHERE id_lavage = generated_order_id;
                    END IF;

                    -- RANDOM ITEMS LOOP (detail_lavage): For each order, generate between 2 and 5 items
                    num_items_random := floor(random() * (5 - 2 + 1) + 2);

                    FOR item_count IN 1..num_items_random LOOP
                            -- Picking a random category (1-8)
                            random_category := floor(random() * (8 - 1 + 1) + 1);

                            -- realistic randomization of quantities (1-50)
                            item_quantities := floor(random() * (50 - 1 + 1) + 1);

                            -- Fetching the associated price from the tarif table
                            SELECT prix INTO random_price FROM tarif WHERE id_categorie = random_category;

                            INSERT INTO detail_lavage (id_lavage, id_categorie, quantite, prix_unitaire)
                            VALUES (generated_order_id, random_category, item_quantities, random_price);
                        END LOOP;

                    -- SUBSEQUENT LOGISTICAL RECORDS LOOP: Based on the status

                    -- If status is 'Linge récupéré' or 'En lavage', create subsequent logistical and financial records
                    IF status IN ('Linge récupéré', 'En lavage') THEN
                        -- Randomly generate a dépô, récupération, or livraison.
                        -- For realism, only do this for 4 out of the 8 daily orders.
                        IF daily_order_count % 2 = 0 THEN

                            -- Picking a random livreur from LIV000001
                            livreur_id := 'LIV000001'; -- Assume we only have Andry Solo for now

                            CASE daily_order_count % 4
                                WHEN 0 THEN
                                    INSERT INTO depot_linge(id_lavage, date_arrivee, remarque)
                                    VALUES(generated_order_id, current_order_date + '3 hours'::INTERVAL, 'Déposé sur place');
                                WHEN 1 THEN
                                    INSERT INTO recuperation(id_lavage, date_recuperation, lieu_recuperation, numero_appeler, id_livreur)
                                    VALUES(generated_order_id, current_day, 'Ambatoroka', '0345060708', livreur_id);
                                WHEN 2 THEN
                                    INSERT INTO livraison(id_lavage, date_livraison, lieu_livraison, numero_appeler, id_livreur)
                                    VALUES(generated_order_id, current_day + '2 days'::INTERVAL, 'Andoharanofotsy', '0321122334', livreur_id);
                                END CASE;

                            -- NOUVEAU (based on rest to do list point 9): Create Facture for logistical and completed orders
                            -- Pricing is managed by a combination of order details and logistical fees (TBD), set to realistic placeholder
                            INSERT INTO facture (id_lavage, montant_total)
                            VALUES (generated_order_id, floor(random() * (50000 - 10000 + 1) + 10000));
                        END IF;
                    END IF;

                END LOOP; -- End daily order loop

        END LOOP; -- End weekly day loop

END;
$$ LANGUAGE plpgsql;

-- ==============================================================================
-- 4. FUNCTION EXECUTION
-- ==============================================================================
BEGIN;
SELECT populate_washing_orders();
COMMIT;

-- Verification of generated data
SELECT COUNT(*) AS total_client_in_db FROM client;
SELECT COUNT(*) AS total_orders_in_one_week FROM lavage;