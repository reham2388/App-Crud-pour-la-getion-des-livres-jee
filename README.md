# 📚 Gestion de Bibliothèque - Jakarta EE MVC

![Java](https://img.shields.io/badge/Java-17-orange.svg)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-10-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0-blue.svg)
![WildFly](https://img.shields.io/badge/WildFly-30+-red.svg)

## 📝 Présentation du Projet
Ce projet est une application web de gestion de livres et d'auteurs développée dans le cadre du TP d'Architecture JEE à l'**ISGA Casablanca**. L'objectif est de mettre en pratique le pattern **MVC** (Modèle-Vue-Contrôleur) ainsi que la gestion de la persistance avec **JDBC**.



## 🚀 Fonctionnalités
- **Authentification sécurisée** : Accès restreint via des filtres de session.
- **Gestion des rôles (ACL)** :
  - `Admin` : Accès complet (CRUD sur les livres et auteurs).
  - `Visiteur` : Consultation et recherche uniquement.
- **Recherche avancée** : Filtrage des livres par titre ou par auteur.
- **Interface responsive** : Design moderne avec CSS3 personnalisé (Gradients, ombres portées).
- **Filtres Frontaux** : Gestion de l'encodage UTF-8 et injection d'en-têtes de sécurité HTTP.

## 🛠️ Architecture Technique
L'application suit une structure modulaire :
- **Model** : POJOs et pattern DAO pour l'accès aux données MySQL.
- **View** : Pages JSP utilisant JSTL et EL pour un rendu dynamique.
- **Controller** : Servlets Jakarta pour la gestion du flux de données.
- **Util** : Singleton pour la gestion de la connexion `DatabaseConnection`.



## 📋 Schéma de la Base de Données
Le projet utilise trois tables principales :
1. `UTILISATEUR` : Comptes avec rôles (Admin/Visiteur).
2. `AUTEUR` : Informations sur les écrivains.
3. `LIVRE` : Détails des ouvrages (lié à l'auteur via le `matricule`).


## Pour le login: soit admin ou visiteur voici les user/mots de passe 
Admin: admin/mdp: 2002
; User: User/mdp: 2002 



## ⚙️ Installation et Configuration

1. **Base de données** :
   - Importer le fichier `schema.sql` dans votre serveur MySQL (via phpmyadmin).
   - Vérifier les identifiants dans `com.example.demo2.util.DatabaseConnection`.
  

## Accéder à l'application via 
http://localhost:8080/gestion-livres-1.0/login
   
