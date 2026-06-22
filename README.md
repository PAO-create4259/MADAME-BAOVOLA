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
            └── WEB-INF/
                └── web.xml         # Descripteur de déploiement
```

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

## Lancer le projet sans IntelliJ (autre IDE / ligne de commande)

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
