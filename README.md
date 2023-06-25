# Uso
Installare i componenti:
    sudo apt install secure-delete openssl netcat-traditional mawk apache2

Successivamente:

    lato server:    bash server.sh PORTA
    lato client:    bash client.sh IP_SERVER PORTA
    

Attenzione: per funzionare sia il client che il server devono creare eccezioni al firewall per la porta concordata.

NB: per provare la chat in locale bisogna tenere gli script in cartelle diverse.



# Versione 1.5

In questa versione il client non ha bisogno di forwardare nessuna porta.

Per fare questo però il server deve essere eseguito come root per salvare la chiave pubblica dentro /var/www/html/ e runnare apache2 e forwardare anche la porta 80.



# Miglioramenti
1) controllo inserimento corretto parametri da riga di comando + suggerimenti
2) identificazione del server tramite la sua chiave pubblica
3) scelta dei nick all'inizio della chat
