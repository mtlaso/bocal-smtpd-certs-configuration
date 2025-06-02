#!/bin/bash
set -e

source ~/dev/bocal-smtpd-certs-configuration/bws_push.sh.env

KEY="api:"
KEY+="${MAILGUN_API_KEY}"

# cron: 0 0 * * 1
# “At 00:00 on Monday.”
# https://crontab.guru/#0_0_*_*_1
curl -s --user $KEY \
  https://api.mailgun.net/v3/$MAILGUN_API_DOMAIN/messages \
  -F from="Mailgun Sandbox (cron macos) <postmaster@${MAILGUN_API_DOMAIN}>" \
  -F to="Root <${MAILGUN_TO}>" \
  -F subject='Renouveler BWS secret' \
  -F text='Il est temps de renouveler les informations de Bitwarden Secrets Manager. (github, ficher .env). Faire un backup des fichers env.' \

