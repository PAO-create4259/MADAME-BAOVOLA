<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Categorie" %>
<%@ page import="java.util.List" %>

<div class="container py-5" style="min-height: 100vh;">
    <div class="row g-5 py-5">

        <div class="col-lg-5">
            <h3 class="mb-4 fw-bold" style="color: #2c3e50;">Saisie du linge</h3>

            <form id="formSaisieLinge">
                <div class="mb-3">
                    <label class="form-label text-muted">Type de tissu</label>
                    <select class="form-select border-primary" name="idCategorie" id="selectCategorie" style="border-width: 2px;">
                        <option value="" disabled selected>Choisir un type de tissu</option>

                        <%
                            List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
                            if (categories != null) {
                                for (model.Categorie cat : categories) {
                        %>
                        <option value="<%= cat.getIdCategorie() %>" data-prix="<%= cat.getPrix() %>">
                            <%= cat.getNomCategorie() %> | <%= cat.getPrixFormate() %> Ar
                        </option>
                        <%
                                }
                            }
                        %>

                    </select>
                </div>

                <div class="mb-4">
                    <label class="form-label text-muted">Quantite</label>
                    <input type="number" class="form-control" id="inputQuantite" min="1">
                </div>

                <button type="button" class="btn text-white mb-5" id="btnAjouterLigne" style="background-color: #0d47a1;">
                    + Ajouter
                </button>

                <div class="form-check mb-3">
                    <input class="form-check-input border-secondary" type="checkbox" id="checkRecuperation">
                    <label class="form-check-label text-muted" for="checkRecuperation">
                        Récupérer mon linge
                    </label>
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted">Adresse de recuperation</label>
                    <input type="text" class="form-control" id="adresseRecuperation" disabled>
                </div>

                <div class="mb-3">
                    <label class="form-label text-muted">Numéro de téléphone de récupération</label>
                    <%
                        model.Client clientConnecte = (model.Client) session.getAttribute("clientConnecte");
                        String telClient = (clientConnecte != null) ? clientConnecte.getTelephone() : "";
                    %>
                    <input type="text" class="form-control" id="telephoneRecuperation" value="<%= telClient %>" disabled>
                </div>
            </form>
        </div>

        <div class="col-lg-7">
            <h3 class="mb-4 fw-bold" style="color: #2c3e50;">Facturation automatique</h3>

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
                    <tbody class="text-muted" id="tbodyFacturation">
                    </tbody>
                </table>
            </div>

            <div class="d-flex justify-content-end align-items-center mb-4">
                <span class="fw-bold me-3 text-muted">Montant final :</span>
                <span class="fw-bold" id="montantFinalText" style="color: #2c3e50;">0 Ar</span>
            </div>

            <div class="d-flex justify-content-end">
                <button type="button" id="btnRecapituler" class="btn text-white px-4 py-2" style="background-color: #0d47a1;">
                    Recapituler
                </button>
            </div>
        </div>

    </div>
</div>

<script>
    const PRIX_LIVRAISON = <%= request.getAttribute("prixLivraison") != null ? request.getAttribute("prixLivraison") : 0 %>;

    const checkbox = document.getElementById('checkRecuperation');
    const inputAdresse = document.getElementById('adresseRecuperation');
    const inputTelephone = document.getElementById('telephoneRecuperation');

    const btnAjouter = document.getElementById('btnAjouterLigne');
    const selectCategorie = document.getElementById('selectCategorie');
    const inputQuantite = document.getElementById('inputQuantite');
    const tbodyFacturation = document.getElementById('tbodyFacturation');
    const montantFinalText = document.getElementById('montantFinalText');
    const btnRecapituler = document.getElementById('btnRecapituler');

    let montantTotal = 0;
    let livraisonAppliquee = false;

    function formaterNombre(nombre) {
        return new Intl.NumberFormat('fr-FR').format(nombre);
    }

    // === RESTAURATION DES DONNÉES (Quand on clique sur Modifier) ===
    document.addEventListener("DOMContentLoaded", function() {
        const dataJson = sessionStorage.getItem('commandeData');
        if (dataJson) {
            const commande = JSON.parse(dataJson);

            // 1. Restauration de l'adresse et du téléphone
            if (commande.avecRecuperation) {
                checkbox.checked = true;
                inputAdresse.removeAttribute('disabled');
                inputTelephone.removeAttribute('disabled');
                inputAdresse.value = commande.adresse || '';
                if(commande.telephone) {
                    inputTelephone.value = commande.telephone;
                }
            }

            // 2. Restauration des articles dans le tableau
            commande.panier.forEach(item => {
                const coutAjout = item.prixUnitaire * item.quantite;
                const tr = document.createElement('tr');
                tr.id = 'ligne-' + item.idCategorie;
                tr.setAttribute('data-quantite', item.quantite);
                tr.setAttribute('data-prix-unitaire', item.prixUnitaire);

                tr.innerHTML = `
                    <td class="py-3">\${item.nomTissu}</td>
                    <td>
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-minus py-0 px-2">-</button>
                        <span class="mx-2 quantite-val fw-bold">\${item.quantite}</span>
                        <button type="button" class="btn btn-sm btn-outline-secondary btn-plus py-0 px-2">+</button>
                    </td>
                    <td>\${formaterNombre(item.prixUnitaire)}</td>
                    <td class="fw-bold total-ligne">\${formaterNombre(coutAjout)}</td>
                `;
                tbodyFacturation.appendChild(tr);
                montantTotal += coutAjout;
            });

            // 3. Restauration de la livraison si cochée
            if (commande.avecRecuperation) {
                ajouterFraisLivraison();
            }

            montantFinalText.innerText = formaterNombre(montantTotal) + " Ar";
        }
    });

    // === GESTION DES BOUTONS + ET - ===
    tbodyFacturation.addEventListener('click', function(e) {
        // On vérifie si l'élément cliqué est un bouton + ou -
        if (e.target.classList.contains('btn-plus') || e.target.classList.contains('btn-minus')) {
            const tr = e.target.closest('tr');

            // On ne modifie pas la ligne de livraison
            if (tr.id === 'ligne-livraison') return;

            let quantite = parseInt(tr.getAttribute('data-quantite'));
            const prixUnitaire = parseFloat(tr.getAttribute('data-prix-unitaire'));

            if (e.target.classList.contains('btn-plus')) {
                quantite++;
                montantTotal += prixUnitaire;
            } else if (e.target.classList.contains('btn-minus')) {
                quantite--;
                montantTotal -= prixUnitaire;
            }

            // Si la quantité tombe à 0, on supprime carrément la ligne
            if (quantite <= 0) {
                tr.remove();
            } else {
                // Sinon on met à jour l'affichage de la ligne
                tr.setAttribute('data-quantite', quantite);
                tr.querySelector('.quantite-val').innerText = quantite;
                tr.querySelector('.total-ligne').innerText = formaterNombre(quantite * prixUnitaire);
            }

            // Mise à jour du total général
            montantFinalText.innerText = formaterNombre(montantTotal) + " Ar";
        }
    });

    // === GESTION DE LA LIVRAISON ===
    checkbox.addEventListener('change', function() {
        if (this.checked) {
            inputAdresse.removeAttribute('disabled');
            inputTelephone.removeAttribute('disabled');
            ajouterFraisLivraison();
        } else {
            inputAdresse.setAttribute('disabled', 'disabled');
            inputTelephone.setAttribute('disabled', 'disabled');
            inputAdresse.value = '';
            retirerFraisLivraison();
        }
    });

    function ajouterFraisLivraison() {
        if (livraisonAppliquee || PRIX_LIVRAISON <= 0) return;

        const ligneLivraison = document.createElement('tr');
        ligneLivraison.id = 'ligne-livraison';

        ligneLivraison.innerHTML = `
            <td class="py-3">Frais de récupération & livraison</td>
            <td>1</td>
            <td>\${formaterNombre(PRIX_LIVRAISON)}</td>
            <td class="fw-bold">\${formaterNombre(PRIX_LIVRAISON)}</td>
        `;

        tbodyFacturation.appendChild(ligneLivraison);
        montantTotal += PRIX_LIVRAISON;
        montantFinalText.innerText = formaterNombre(montantTotal) + " Ar";
        livraisonAppliquee = true;
    }

    function retirerFraisLivraison() {
        if (!livraisonAppliquee) return;
        const ligneLivraison = document.getElementById('ligne-livraison');
        if (ligneLivraison) ligneLivraison.remove();
        montantTotal -= PRIX_LIVRAISON;
        montantFinalText.innerText = formaterNombre(montantTotal) + " Ar";
        livraisonAppliquee = false;
    }

    // === AJOUT DE LINGE ===
    btnAjouter.addEventListener('click', function() {
        if (selectCategorie.selectedIndex <= 0) {
            alert("Veuillez sélectionner un type de tissu.");
            return;
        }

        const quantite = parseInt(inputQuantite.value);
        if (isNaN(quantite) || quantite <= 0) {
            alert("Veuillez entrer une quantité valide.");
            return;
        }

        const optionChoisie = selectCategorie.options[selectCategorie.selectedIndex];
        const idCategorie = optionChoisie.value;
        const nomTissu = optionChoisie.text.split(' | ')[0].trim();
        const prixUnitaire = parseFloat(optionChoisie.getAttribute('data-prix'));
        const coutAjout = prixUnitaire * quantite;

        const ligneExistante = document.getElementById('ligne-' + idCategorie);

        if (ligneExistante) {
            const ancienneQuantite = parseInt(ligneExistante.getAttribute('data-quantite'));
            const nouvelleQuantite = ancienneQuantite + quantite;
            const nouveauTotalLigne = prixUnitaire * nouvelleQuantite;

            ligneExistante.setAttribute('data-quantite', nouvelleQuantite);
            ligneExistante.setAttribute('data-prix-unitaire', prixUnitaire);
            ligneExistante.innerHTML = `
                <td class="py-3">\${nomTissu}</td>
                <td>
                    <button type="button" class="btn btn-sm btn-outline-secondary btn-minus py-0 px-2">-</button>
                    <span class="mx-2 quantite-val fw-bold">\${nouvelleQuantite}</span>
                    <button type="button" class="btn btn-sm btn-outline-secondary btn-plus py-0 px-2">+</button>
                </td>
                <td>\${formaterNombre(prixUnitaire)}</td>
                <td class="fw-bold total-ligne">\${formaterNombre(nouveauTotalLigne)}</td>
            `;
        } else {
            const nouvelleLigne = document.createElement('tr');
            nouvelleLigne.id = 'ligne-' + idCategorie;
            nouvelleLigne.setAttribute('data-quantite', quantite);
            nouvelleLigne.setAttribute('data-prix-unitaire', prixUnitaire);

            nouvelleLigne.innerHTML = `
                <td class="py-3">\${nomTissu}</td>
                <td>
                    <button type="button" class="btn btn-sm btn-outline-secondary btn-minus py-0 px-2">-</button>
                    <span class="mx-2 quantite-val fw-bold">\${quantite}</span>
                    <button type="button" class="btn btn-sm btn-outline-secondary btn-plus py-0 px-2">+</button>
                </td>
                <td>\${formaterNombre(prixUnitaire)}</td>
                <td class="fw-bold total-ligne">\${formaterNombre(coutAjout)}</td>
            `;

            const ligneLivraison = document.getElementById('ligne-livraison');
            if (ligneLivraison) {
                tbodyFacturation.insertBefore(nouvelleLigne, ligneLivraison);
            } else {
                tbodyFacturation.appendChild(nouvelleLigne);
            }
        }

        montantTotal += coutAjout;
        montantFinalText.innerText = formaterNombre(montantTotal) + " Ar";

        selectCategorie.selectedIndex = 0;
        inputQuantite.value = '';
    });

    // === SAUVEGARDE ET REDIRECTION ===
    btnRecapituler.addEventListener('click', function() {
        const lignes = document.querySelectorAll('#tbodyFacturation tr');
        let panier = [];

        lignes.forEach(ligne => {
            if (ligne.id !== 'ligne-livraison') {
                panier.push({
                    idCategorie: ligne.id.split('-')[1],
                    nomTissu: ligne.cells[0].innerText,
                    quantite: parseInt(ligne.getAttribute('data-quantite')),
                    prixUnitaire: parseFloat(ligne.getAttribute('data-prix-unitaire'))
                });
            }
        });

        if (panier.length === 0) {
            alert("Veuillez ajouter au moins un linge avant de récapituler.");
            return;
        }

        if (checkbox.checked && inputAdresse.value.trim() === '') {
            alert("Veuillez renseigner votre adresse de récupération.");
            return;
        }

        const commandeDonnees = {
            panier: panier,
            avecRecuperation: checkbox.checked,
            adresse: inputAdresse.value,
            telephone: inputTelephone.value,
            prixLivraison: livraisonAppliquee ? PRIX_LIVRAISON : 0,
            montantTotal: montantTotal
        };

        sessionStorage.setItem('commandeData', JSON.stringify(commandeDonnees));
        window.location.href = '${pageContext.request.contextPath}/recapitulatif';
    });
</script>