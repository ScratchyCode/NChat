#!/bin/bash
# Coded by ScratchyCode

# NB: il server richiede di specificare il numero della porta di ascolto.

# Controllare che tutti i pacchetti usati negli script siano installati sul sistema;
# per installare tutte le componenti digitare: sudo apt install secure-delete openssl netcat-traditional mawk apache2


# generazione chiavi asimmetriche
echo -e "\n*** generazione chiavi RSA ***\n"
openssl genrsa -out privata.key 4096 #2> /dev/null
openssl rsa -in privata.key -pubout > /var/www/html/pubblica.key 2> /dev/null
systemctl start apache2

# in ascolto sulla porta specificata
echo -e "\n*** in ascolto sulla porta $1 ***"
nc -lp $1 > client.ip

# salvo l'ip dal file alla memoria
echo -e "*** client connesso ***"
ip_client=$(< client.ip)

# in ascolto per salvare la chiave simmetrica cifrata
echo -e "*** ricezione chiave simmetrica cifrata ***"
nc -lp $1 > simmetrica.key.enc

# decifro la chiave simmetrica (la chiave privata cifrata rallenta la connessione)
echo -e "*** decifrazione chiave simmetrica ***"
openssl rsautl -decrypt -inkey privata.key -in simmetrica.key.enc -out simmetrica.key

# salvo la chiave simmetrica in memoria
chiave_simmetrica=$(< simmetrica.key)

# cancello le chiavi ed arresto il servizio web di condivisione della chiave
srm -f simmetrica.key.enc privata.key
systemctl stop apache2
systemctl disable apache2 2> /dev/null

# avvio la chat con cryptcat inizializzandola con la chiave simmetrica
echo -e "*** inizializzazione chat ***"
sleep 2
echo -e "*** connesso ***\n\n"
mawk -W interactive '$0="\033[91mServer\a\033[0m: "$0' | cryptcat -lp $1 -k $chiave_simmetrica

# pulisco la memoria dalla chiave simmetrica in chiaro
chiave_simmetrica="42"

exit


