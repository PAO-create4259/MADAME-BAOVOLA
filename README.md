# MADAME-BAOVOLA — CleanCare Clothes

Application web de gestion de pressing (clients, lavages, utilisateurs) développée en
Java (Servlets / JSP) avec Maven et une base de données PostgreSQL.

## Arborescence du projet

```
CleanCareClothes/
├── README.md                       # Ce fichier
├── pom.xml                         # Configuration Maven (dépendances, packaging WAR)
├── Query.sql                       # Script SQL de création de la base et des tables
│
└── src/
    └── main/
        ├── java/
        │   ├── dao/                # Couche d'accès aux données (DAO)
        │   │   ├── BaseDAO.java
        │   │   ├── ClientDAO.java
        │   │   ├── LavageDAO.java
        │   │   └── UtilisateurDAO.java
        │   │
        │   ├── model/              # Modèles / entités métier
        │   │   ├── Client.java
        │   │   ├── Lavage.java
        │   │   └── Utilisateur.java
        │   │
        │   └── utils/              # Utilitaires
        │       └── DatabaseConnection.java   # Connexion JDBC à PostgreSQL
        │
        └── webapp/                 # Ressources web
            ├── index.jsp
            ├── pages/              # Pages JSP
            │   ├── admin/          # Pages réservées à l'administrateur
            │   │   └── accueil-admin.jsp
            │   └── client/         # Pages côté client
            │       └── accueil-client.jsp
            ├── WEB-INF/
            │   └── web.xml         # Descripteur de déploiement
            └── assets/             # Ressources statiques (servies au navigateur)
                ├── css/            # Feuilles de style perso
                │   └── style.css
                ├── js/             # Scripts JavaScript perso
                │   └── script.js
                ├── img/            # Images
                └── vendor/         # Librairies tierces
                    └── bootstrap/  # Bootstrap (CSS + JS)
                        ├── css/
                        └── js/
```

> **Note :** les fichiers statiques (CSS, JS, Bootstrap, images) se placent dans
> `src/main/webapp/assets/` et **jamais** dans `WEB-INF/` (dossier non accessible
> depuis le navigateur). On les référence dans les JSP via
> `${pageContext.request.contextPath}/assets/...`.

## Prérequis

- **JDK 8 ou supérieur** (`java -version`)
- **Apache Maven 3.x** (`mvn -version`)
- **PostgreSQL** (serveur en cours d'exécution sur `localhost:5432`)
- Un **serveur d'application** compatible Servlet/JSP (par ex. **Apache Tomcat 9+**)

## Configuration de la base de données

1. Créer la base et les tables à partir du script fourni :

   ```bash
   psql -U postgres -f Query.sql
   ```

2. Vérifier/adapter les paramètres de connexion dans
   `src/main/java/utils/DatabaseConnection.java` :

   ```java
   URL          = "jdbc:postgresql://localhost:5432/cleancareclothes"
   UTILISATEUR  = ""
   MOT_DE_PASSE = ""
   ```

## Lancement du projet 

Le projet est packagé en **WAR** ; il faut donc le compiler avec Maven puis le déployer
dans un conteneur de servlets (Tomcat).

### 1. Compiler et générer le WAR

```bash
# Depuis la racine du projet (où se trouve pom.xml)
mvn clean package
```

Le fichier généré se trouve dans `target/CleanCareClothes.war`.

### 2. Déployer sur Apache Tomcat

**Option A — Déploiement manuel**

```bash
# Copier le WAR dans le dossier webapps de Tomcat
cp target/CleanCareClothes.war $CATALINA_HOME/webapps/

# Démarrer Tomcat
# Linux / macOS :
$CATALINA_HOME/bin/startup.sh
# Windows (PowerShell) :
& "$env:CATALINA_HOME\bin\startup.bat"
```

L'application est ensuite accessible à l'adresse :
<http://localhost:8080/CleanCareClothes/>

**Option B — Avec le plugin Maven Cargo / Tomcat** (sans installer Tomcat séparément)

Ajouter le plugin `cargo-maven3-plugin` dans le `pom.xml`, puis :

```bash
mvn clean package cargo:run
```

### 3. Commandes Maven utiles

```bash
mvn clean              # Nettoyer le dossier target/
mvn compile            # Compiler les sources Java
mvn test               # Exécuter les tests
mvn package            # Générer le WAR
```

## IDE compatibles

Le projet étant un projet Maven standard, il peut être importé dans n'importe quel IDE :

- **Eclipse / Eclipse for Enterprise Java** : `File > Import > Existing Maven Projects`
- **VS Code** : extensions *Extension Pack for Java* + *Maven for Java*
- **NetBeans** : `File > Open Project` (reconnaît automatiquement le `pom.xml`)

## Changements récents

- Front controller : `ClientController` gère les routes publiques principales (accueil, tarif, apropos, lavage, recapitulatif).
  - Pour éviter d'intercepter les fichiers statiques, le controller laisse passer les requêtes `/assets/*` au dispatcher par défaut.
  - Si vous préférez, mappez le servlet sur des patterns explicites (ex. `/accueil`, `/tarif`, ...) au lieu de `/`.

- `src/main/webapp/index.jsp` a été laissé minimal (le controller s'occupe du routage).
- `pages/client/layout.jsp` inclut maintenant les vues depuis `pages/client/content/{page}.jsp`.

## Routes principales

- `/` ou `/accueil` — page d'accueil client
- `/tarif` — tarifs
- `/apropos` — page À propos
- `/lavage` — page de commande (nécessite connexion client)
- `/recapitulatif` — récapitulatif de commande
- `/login`, `/confirmer-commande`, `/suivi`, `/profil` — routes utilisées par le front-end (vérifier les controllers correspondants)

## Dépannage (CSS / JS ne s'appliquent pas)

Si les fichiers CSS/JS retournent du HTML (erreur console type `Unexpected token '<'`), c'est que la requête pour `bootstrap.bundle.min.js` ou autre a reçu le HTML d'une page (souvent `index` ou le contrôleur). Vérifier :

1. Ouvrir DevTools ▶ Network ▶ filtrer par `css` / `js` et recharger.
2. Vérifier l'URL demandée (doit commencer par `/assets/...`) et que le statut est `200` et le `Content-Type` correct (`text/css` ou `application/javascript`).
3. Si la réponse contient du HTML, adapter le mapping du servlet (ne pas capturer `/assets/*`) ou configurer le controller pour déléguer les ressources statiques au dispatcher par défaut.

Exemple dans `ClientController.doGet` pour laisser Tomcat servir les statiques :

```java
if (path != null && path.startsWith("/assets/")) {
    request.getServletContext().getNamedDispatcher("default").forward(request, response);
    return;
}
```

## Fichiers importants à vérifier

- `src/main/java/controller/ClientController.java` — routage et sécurité basique (redirection vers `/login` si nécessaire)
- `src/main/webapp/pages/client/layout.jsp` — inclusion des pages de contenu
- `src/main/webapp/pages/client/content/` — fichiers JSP de contenu (`accueil.jsp`, `tarif.jsp`, `lavage.jsp`, `recapitulatif.jsp`, ...)
- `src/main/webapp/assets/` — CSS, JS, images, vendor (Bootstrap)

Si besoin, je peux :
- commiter ces modifications au dépôt (avec message et Co-authored-by)
- ajouter une section « Développement local » plus détaillée
- vérifier les autres controllers pour lister toutes les routes


