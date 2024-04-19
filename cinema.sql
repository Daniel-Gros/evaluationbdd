-- Création de la base de données --
CREATE DATABASE IF NOT EXISTS cinema_db;

USE cinema_db;


-- Création des comptes administrateur et utilisateur --

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'mdpadmin';
GRANT ALL PRIVILEGES ON cinema_db.* TO 'admin'@'localhost';

CREATE USER 'user1'@'localhost' IDENTIFIED BY 'mdpuser1';
GRANT INSERT, UPDATE, DELETE ON cinema_db.Seance TO 'user1';

CREATE USER 'user2'@'localhost' IDENTIFIED BY 'mdpuser2';
GRANT INSERT, UPDATE, DELETE ON cinema_db.Seance TO 'user2';

CREATE USER 'user3'@'localhost' IDENTIFIED BY 'mdpuser3';

GRANT INSERT, UPDATE, DELETE ON cinema_db.Seance TO 'user3';


-- Création des tables --
CREATE TABLE  Utilisateur (
    idUtilisateur INT AUTO_INCREMENT PRIMARY KEY ,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    passwd VARCHAR(255) NOT NULL
);

CREATE TABLE Administrateur (
    idAdmin INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    passwd VARCHAR(255) NOT NULL
);

CREATE TABLE CinéComplex (
    idCineComplex INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    ville VARCHAR(255) NOT NULL,
    idUtilisateur INT, FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
    idAdmin INT, FOREIGN KEY (idAdmin) REFERENCES Administrateur(idAdmin)
);

CREATE TABLE SEANCE (
    idSeance INT PRIMARY KEY AUTO_INCREMENT,
    dateHeure DATETIME NOT NULL,
    film VARCHAR(255) NOT NULL,
    salle VARCHAR(255) NOT NULL,
    tarifPlein FLOAT NOT NULL,
    tarifEtudiant FLOAT NOT NULL,
    tarifEnfant FLOAT NOT NULL,
    idCinéComplex INT, FOREIGN KEY (idCinéComplex) REFERENCES CinéComplex(idCineComplex)
);

CREATE TABLE Paiement (
    idPaiement INT PRIMARY KEY AUTO_INCREMENT,
    montant FLOAT NOT NULL,
    dateHeure DATETIME NOT NULL,
    modePaiement VARCHAR(50) NOT NULL,
    statut VARCHAR(50) NOT NULL,
    idUtilisateur INT, FOREIGN KEY (idUtilisateur) REFERENCES Utilisateur(idUtilisateur),
    idSeance INT, FOREIGN KEY (idSeance) REFERENCES Seance(idSeance),
    idAdmin INT, FOREIGN KEY (idAdmin) REFERENCES Administrateur(idAdmin)
);


-- Création des comptes --

INSERT INTO Administrateur (nom, prenom, email, passwd) VALUES ('admin', 'admin', 'admin@cineval.fr', SHA2('admin', '780rdb01600SE' ));
INSERT INTO Utilisateur (nom, prenom, email, passwd) VALUES ('user1', 'user1', 'user1@cineval.fr', SHA2('user1', '780rdb01600SE'));
INSERT INTO Utilisateur (nom, prenom, email, passwd) VALUES ('user2', 'user2', 'user2@cineval.fr', SHA2('user2', '780rdb01600SE'));
INSERT INTO Utilisateur (nom, prenom, email, passwd) VALUES ('user3', 'user3', 'user3@cineval.fr', SHA2('user3', '780rdb01600SE'));


-- Ajout de contraintes liées à l'entretien avec le client --

ALTER TABLE seance
ADD COLUMN nbPlacesMaxi INT;

ALTER TABLE seance
ADD COLUMN nbPlacesréservées INT;

-- Vérification que le nombre de places réservées ne dépasse pas le nombre de places maximum --
ALTER TABLE seance
ADD CONSTRAINT chk_nbPlaces
CHECK (nbPlacesMaxi >= nbPlacesréservées);

-- Application des tarifs propre à chaque personne, toute séance confondue (sans clause WHERE donc) --
UPDATE seance
SET tarifPlein = 9.20,
tarifEtudiant = 7.60,
tarifEnfant = 5.90;

-- Insertion de données factices dans la base de données --

USE cinema_db;

INSERT INTO seance (dateHeure, film, salle, tarifPlein, tarifEtudiant, tarifEnfant, nbPlacesMaxi, nbPlacesréservées)
VALUES 
    ('2024-04-15 20:00:00', 'Film 1', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 2', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 3', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 4', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 5', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 6', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 7', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 8', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 9', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 10', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 11', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 12', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 13', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 14', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0),
    ('2024-04-15 20:00:00', 'Film 15', CONCAT('Salle ', FLOOR(RAND() * 10) + 1), 9.20, 7.60, 5.90, FLOOR(RAND() * 150) + 50, 0);


INSERT INTO cinécomplex (nom, adresse, ville, idUtilisateur, idAdmin)
VALUES 
    ('Cinéma 1', '289 Boulevard des Belges', 'Lyon', 1, 1),
    ('Cinéma 2', 'Place du Prado', 'Marseille', 2, 1),
    ('Cinéma 3', 'Bercy Village', 'Paris', 3, 1);