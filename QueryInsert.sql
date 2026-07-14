DROP FUNCTION IF EXISTS populate_washing_orders();

CREATE OR REPLACE FUNCTION populate_washing_orders()
    RETURNS VOID AS
$$
DECLARE
    -- Date de début : Lundi 13 juillet 2026
    start_date DATE := '2026-07-13';

    current_day DATE;
    current_order_date TIMESTAMP;
    generated_order_id VARCHAR(10);
    client_id VARCHAR(10);
    livreur_id VARCHAR(10) := 'LIV000004'; -- Andry Solo

    random_category INTEGER;
    random_price NUMERIC;
    item_quantities INTEGER;
    num_items_random INTEGER;
    status VARCHAR(50);
BEGIN
    -- BOUCLE PRINCIPALE : 6 jours (Lundi à Samedi)
    FOR current_day_count IN 0..5 LOOP
            current_day := start_date + current_day_count;

            -- BOUCLE DES COMMANDES : 8 lavages par jour
            FOR daily_order_count IN 1..8 LOOP

                    -- Heure aléatoire entre 08:00 et 16:00
                    current_order_date := (current_day || ' 08:00:00')::TIMESTAMP + (daily_order_count * '1 hour'::INTERVAL) + (floor(random() * 60) * '1 minute'::INTERVAL);

                    -- Sélection d'un client au hasard entre CLT000001 et CLT000008
                    client_id := 'CLT' || TO_CHAR(floor(random() * 8) + 1, 'FM000000');

                    -- Utilisation de l'Unicode pour forcer les accents sans erreur d'encodage
                    CASE daily_order_count % 3
                        WHEN 0 THEN status := 'En attente';
                        WHEN 1 THEN status := 'En lavage';
                        WHEN 2 THEN status := U&'Pr\00eat \00e0 r\00e9cup\00e9rer';
                        END CASE;

                    -- Insertion de la commande
                    INSERT INTO lavage (id_client, date_commande, statut)
                    VALUES (client_id, current_order_date, status)
                    RETURNING id_lavage INTO generated_order_id;

                    -- Simulation du mode de retrait
                    IF random() < 0.3 THEN
                        UPDATE lavage SET mode_retrait = (CASE floor(random() * 2) WHEN 0 THEN 'sur_place' ELSE 'domicile' END) WHERE id_lavage = generated_order_id;
                    END IF;

                    -- Création des vêtements pour cette commande (entre 2 et 5 lignes)
                    num_items_random := floor(random() * 4) + 2;

                    FOR item_count IN 1..num_items_random LOOP
                            -- Catégorie aléatoire (1 à 8)
                            random_category := floor(random() * 8) + 1;
                            item_quantities := floor(random() * 10) + 1;

                            -- Récupération du prix unitaire
                            SELECT prix INTO random_price FROM tarif WHERE id_categorie = random_category;

                            INSERT INTO detail_lavage (id_lavage, id_categorie, quantite, prix_unitaire)
                            VALUES (generated_order_id, random_category, item_quantities, random_price);
                        END LOOP;

                    -- Création des suivis logistiques et de la facture si la commande est avancée
                    IF status IN ('En lavage', U&'Pr\00eat \00e0 r\00e9cup\00e9rer') THEN
                        IF daily_order_count % 2 = 0 THEN

                            CASE daily_order_count % 4
                                WHEN 0 THEN
                                    INSERT INTO depot_linge(id_lavage, date_arrivee, remarque)
                                    VALUES(generated_order_id, current_order_date + '3 hours'::INTERVAL, 'Depot au comptoir');
                                WHEN 1 THEN
                                    INSERT INTO recuperation(id_lavage, date_recuperation, lieu_recuperation, numero_appeler, id_livreur)
                                    VALUES(generated_order_id, current_day, 'Ambatoroka', '0345060708', livreur_id);
                                WHEN 2 THEN
                                    INSERT INTO livraison(id_lavage, date_livraison, lieu_livraison, numero_appeler, id_livreur)
                                    VALUES(generated_order_id, current_day + '2 days'::INTERVAL, 'Andoharanofotsy', '0321122334', livreur_id);
                                ELSE
                                -- On ne fait rien pour les autres
                                END CASE;

                            -- Création de la facture avec l'Unicode pour "Payé"
                            INSERT INTO facture (id_lavage, montant_total, statut_paiement)
                            VALUES (generated_order_id, floor(random() * 40000) + 10000, U&'Pay\00e9');
                        END IF;
                    END IF;

                END LOOP;

        END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Exécution de la fonction
BEGIN;
SELECT populate_washing_orders();
COMMIT;