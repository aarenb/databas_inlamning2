# Databas Inlämning 2
Av: Aaren Bertilsson YH25

Denna SQL databasen är för en liten bokhandel, den består av:
- Böcker
- Kunder
- Beställningar
- Orderrader

[ER Diagram](images/er-diagram.png)



## Reflektion och analys av databaslösning
- *Reflektera över varför du designade databasen på det sätt du gjorde*

- *Fundera på om något kune gjorts annorlunda och vad du skulle ändra om databasen skulle hantera 100 000 kunder istället för 10*

Hade varit bra om vissa fält, ex. totalbelopp & ordernummer i orderrader hade varit automatiserat. Framförallt för att den ska kunna skalas. Dock är detta nog något jag hade implementerat i koden av applikationen som kommunicerar med databasen, snarare än här

- *Diskutera vilka optimeringar som kan göras i index och struktur för att förbättra prestandan*