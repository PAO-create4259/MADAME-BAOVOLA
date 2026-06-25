<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- Fragment inclus dans layout.jsp --%>

<div class="topbar">
    <h1 class="page-title"><i class="bi bi-tags"></i> Modification des tarifs</h1>
</div>

<div class="content-area">

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Prix par vêtement</div>
        <table class="table lav-table">
            <thead>
            <tr>
                <th>Vêtement</th>
                <th>Coton</th>
                <th>Satin</th>
                <th>Lin</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Chemise</td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
            </tr>
            <tr>
                <td>Pantalon</td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
            </tr>
            <tr>
                <td>Robe</td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
            </tr>
            <tr>
                <td>Veste / Manteau</td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
            </tr>
            <tr>
                <td>Draps / Couvertures</td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
                <td><input type="text" class="form-control search-box" placeholder="— Ar" style="width: 80%;"></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Frais de livraison & récupération</div>
        <div style="display: flex; gap: 30px;">
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Frais de livraison à domicile</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="text" class="form-control search-box" placeholder="— Ar" style="flex: 1;">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / livraison</span>
                </div>
            </div>
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Frais de récupération au domicile</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="text" class="form-control search-box" placeholder="— Ar" style="flex: 1;">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / récupération</span>
                </div>
            </div>
        </div>
    </div>

    <div class="card-table" style="margin-bottom: 25px; padding: 20px;">
        <div class="section-label" style="margin-bottom: 20px; font-weight: bold;">Salaires des employés & Commissions</div>
        <div style="display: flex; gap: 30px;">
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Salaire mensuel — Employé 1</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="text" class="form-control search-box" placeholder="— Ar" style="flex: 1;">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / mois</span>
                </div>
            </div>
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Salaire mensuel — Employé 2</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="text" class="form-control search-box" placeholder="— Ar" style="flex: 1;">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / mois</span>
                </div>
            </div>
            <div style="flex: 1;">
                <div style="margin-bottom: 10px; color: #666; font-size: 14px;">Commission livreur</div>
                <div style="display: flex; align-items: center; gap: 15px;">
                    <input type="text" class="form-control search-box" placeholder="— Ar" style="flex: 1;">
                    <span style="color: #888; font-size: 14px; white-space: nowrap;">Ar / livraison</span>
                </div>
            </div>
        </div>
    </div>

    <div style="text-align: right; margin-top: 20px;">
        <button class="btn btn-filter" style="margin-right: 10px;">Annuler</button>
        <button class="btn btn-filter" style="background-color: #111; color: white;">Enregistrer les modifications</button>
    </div>

</div>