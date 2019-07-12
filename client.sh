#!/bin/bash
# Coded by ScratchyCode

# NB: il primo parametro è l'ip del server, il secondo la porta.
# Controllare che tutti i pacchetti usati negli script siano installati sul sistema.


# invio l'ip del client al server come file
ip_server=$1
porta=$2

echo -e "\n*** connessione in corso ***"
wget -qO- ipinfo.io/ip | nc $ip_server $porta -q 5
echo -e "*** connesso ***"
# aspetto in risposta dal server la chiave pubblica
echo -e "*** ricezione chiave pubblica ***"
nc -lp $porta > pubblica.key

echo -e "*** generazione chiave simmetrica casuale ***"
# genero una chiave simmetrica random
openssl rand -base64 32 > simmetrica.key

#salvo la chiave simmetrica in memoria
chiave_simmetrica=$(< simmetrica.key)

# cifro la chiave simmetrica
echo -e "*** cifratura chiave simmetrica ***"
openssl rsautl -encrypt -inkey pubblica.key -pubin -in simmetrica.key -out simmetrica.key.enc

# invio la chiave cifrata
echo -e "*** invio chiave simmetrica cifrata ***"
nc $ip_server $porta -q 5 < simmetrica.key.enc

sleep 2

# cancello i file contenenti le chiavi simmetriche
srm -f simmetrica.key simmetrica.key.enc pubblica.key

# provo a stabilire una connessione sicura con il server
echo -e "*** inizializzazione chat ***"
sleep 3
echo -e "*** connesso ***\n\n"
mawk -W interactive '$0="\033[91mClient\a\033[0m: "$0' | cryptcat $ip_server $porta -k $chiave_simmetrica

# pulisco la memoria dalla chiave simmetrica in chiaro
chiave_simmetrica="42"

exit


