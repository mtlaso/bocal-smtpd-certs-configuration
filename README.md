# bocal-smtpd certs configuration

Configuration des certifications TLS de bocal-smtpd.


1. Remplier le ficher des variables d'environements et le renommer en `bws_push.env` (sans .example)
2. Modifier le lien des variables d'environements dans `bws_push.sh`
3. Faire un hard-link du script vers le dossier .acme.sh
    - `ln bws_push.sh ~/.acme.sh/notify`
4. Source les variables d'environements `source ./bws_push.sh.env`
5. Activer auto-upgrades `acme.sh --upgrade --auto-upgrade 1`
6. Lancer acme.sh (une fois pour la première fois) `acme.sh --issue --dns dns_porkbun -d bocalusermail.fyi --server letsencrypt` (zerossl ne fonctionne pas)
7. Utiliser notification avec le cronjob de acme.sh
    - `acme.sh --set-notify --notify-hook bws_push --notify-hook mailgun`
