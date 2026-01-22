-- Création de la base de données
CREATE DATABASE IF NOT EXISTS gestion_livres;
USE gestion_livres;

-- Table AUTEUR
CREATE TABLE IF NOT EXISTS AUTEUR (
    matricule INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    genre ENUM('Masculin', 'Féminin') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table LIVRE
CREATE TABLE IF NOT EXISTS LIVRE (
    ISBN VARCHAR(20) PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    description TEXT,
    date_edition DATE,
    editeur ENUM('ENI', 'DUNOD', 'FIRST') NOT NULL,
    matricule INT NOT NULL,
    FOREIGN KEY (matricule) REFERENCES AUTEUR(matricule) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table UTILISATEUR
CREATE TABLE IF NOT EXISTS UTILISATEUR (
    id INT PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Visiteur') NOT NULL DEFAULT 'Visiteur'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*-- Insertion de données de test
INSERT INTO AUTEUR (nom, prenom, genre) VALUES
('Dupont', 'Jean', 'Masculin'),
('Martin', 'Marie', 'Féminin'),
('Durand', 'Pierre', 'Masculin'),
('Leblanc', 'Sophie', 'Féminin');

INSERT INTO LIVRE (ISBN, titre, description, date_edition, editeur, matricule) VALUES
('978-2-7440-0001-1', 'Java pour les nuls', 'Guide complet pour apprendre Java', '2023-01-15', 'ENI', 1),
('978-2-7440-0002-8', 'JavaScript avancé', 'Techniques avancées de JavaScript', '2023-02-20', 'DUNOD', 2),
('978-2-7440-0003-5', 'Python pour débutants', 'Introduction à Python', '2023-03-10', 'FIRST', 3),
('978-2-7440-0004-2', 'Web Design moderne', 'Principes du design web', '2023-04-05', 'ENI', 4);

INSERT INTO UTILISATEUR (login, password, role) VALUES
('admin', 'admin123', 'Admin'),
('visiteur', 'visiteur123', 'Visiteur');*/
