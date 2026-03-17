/*
Skapar en databas för en liten bokhandel
Av: Aaren Bertilsson YH25
*/

CREATE DATABASE Bokhandel;

USE Bokhandel;

-- Bok tablell
CREATE TABLE Böcker (
ISBN VARCHAR(13) PRIMARY KEY,
Titel VARCHAR(100) NOT NULL,
Författare VARCHAR(200) NOT NULL,
Lagerstatus INT NOT NULL,
Pris DECIMAL(10,2) NOT NULL CHECK(Pris > 0)
);

-- Kund tabell
CREATE TABLE Kunder (
KundID INT AUTO_INCREMENT PRIMARY KEY,
Namn VARCHAR(100) NOT NULL,
Email VARCHAR(255) NOT NULL UNIQUE,
Telefon VARCHAR(15) NOT NULL,
Address VARCHAR (255) NOT NULL
);

-- Beställning tabell
CREATE TABLE Beställningar (
Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
KundID INT,
TotalBelopp DECIMAL(10,2) NOT NULL CHECK(TotalBelopp > 0),
Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

-- Orderrad tabell
CREATE TABLE Orderrader (
OrderradID INT AUTO_INCREMENT PRIMARY KEY,
ISBN VARCHAR(13),
Ordernummer INT,
Antal INT,
FOREIGN KEY (ISBN) REFERENCES Böcker(ISBN),
FOREIGN KEY (Ordernummer) REFERENCES Beställningar(Ordernummer)
);


-- 1: Skapa & hantera testdata

INSERT INTO Böcker (ISBN, Titel, Författare, Lagerstatus, Pris) VALUES
('9781728206141', 'Boyfriend Material', 'Alexis Hall', '8', '131'),
('9781728250922', 'Husband Material', 'Alexis Hall', '5', '102'),
('9780063272767', 'We Could Be So Good', 'Cat Sebastian', '3', '201');

INSERT INTO Kunder (Namn, Email, Telefon, Address) VALUES
('Aaren Bertilsson', 'aarenbs@gmail.com', '0706861894', 'Kalmarvägen 1, 333 33 Kalmar'),
('Tyler Joseph', 'tylerjoseph@gmail.com', '0701234568', 'Gata 2, 333 33 Kalmar'),
('Josh Dun', 'joshdun@gmail.com', '0701234567', 'Gata 1, 333 33 Nybro');

-- TODO: would be nice if this was more automated (totalbelopp)

INSERT INTO Beställningar (KundID, TotalBelopp) VALUES
(1, 233),
(2, 303),
(1, 201),
(1, 102);


-- TODO: would be nice if this was more automated (ordernumber)

INSERT INTO Orderrader (ISBN, Ordernummer, Antal) VALUES
('9781728206141', 1, 1),
('9781728250922', 1, 1),
('9780063272767', 2, 1),
('9781728250922', 2, 1),
('9780063272767', 3, 1),
('9781728250922', 4, 1);


-- 2: Hämta, filtrera & sortera data

-- Hämta alla kunder & beställningar
SELECT * FROM Kunder;
SELECT * FROM Beställningar;

-- Filtera kunder baserat på namn och e-post
SELECT * FROM Kunder 
WHERE Namn = 'Tyler Joseph';

SELECT * FROM Kunder
WHERE Email = 'aarenbs@gmail.com';

-- Sortera produkter efter pris
SELECT * FROM Böcker 
ORDER BY Pris DESC;


-- 3: Modifiera data
BEGIN TRANSACTION modifiera_data ;

-- Updatera en kunds e-postadress
UPDATE Kunder
SET Email = 'aarenbs@hotmail.com'
WHERE KundID = '1';

-- Ta bort en specifik kund
DELETE FROM Kunder
WHERE KundID = '2';

-- Säkerställ att ändringarna kan ångras med transaktioner
ROLLBACK;


-- 4: Arbeta med JOINs & GROUP BY

-- Använd INNER JOIN för att visa vilka kunder som har lagt beställningar
SELECT Kunder.Namn, Kunder.KundID, Beställningar.Ordernummer
FROM Kunder
INNER JOIN Beställningar
ON Kunder.KundID = Beställningar.KundID;

-- Använd LEFT JOIN för att visa alla kunder, även de utan beställningar
SELECT Kunder.Namn, Kunder.KundID, Beställningar.Ordernummer
FROM Kunder
LEFT JOIN Beställningar
ON Kunder.KundID = Beställningar.KundID;

-- Använd GROUP BY för att räkna antal beställningar per kund
SELECT KundID, COUNT(KundID) AS [Antal beställningar]
FROM Beställningar
GROUP BY KundID;

-- Använd HAVING för att endast visa kunder som har gjort fler än 2 beställningar
SELECT KundID, COUNT(KundID) AS [Antal beställningar]
FROM Beställningar
GROUP BY KundID
HAVING COUNT(KundID) > 2;