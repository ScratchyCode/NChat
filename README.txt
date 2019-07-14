Uso:
    sudo apt install secure-delete openssl netcat-traditional mawk
    
Successivamente:

    lato server:    bash server.sh PORTA
    lato client:    bash client.sh IP_SERVER PORTA
    

Attenzione: per funzionare sia il client che il server devono creare eccezioni al firewall per la porta concordata.

NB: per provare la chat in locale bisogna tenere gli script in cartelle diverse.


La forza della crittografia asimmetrica è che volendo permette di validare l'identità del server,
basta usare sempre le stesse chiavi asimmetriche e creare una funzione nel client.sh di controllo.

Miglioramenti:
    - controllo inserimento corretto parametri da riga di comando + suggerimenti
    - identificazione del server tramite la sua chiave pubblica
    - scelta dei nick all'inizio della chat
