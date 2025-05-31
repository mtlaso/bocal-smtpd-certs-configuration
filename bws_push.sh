#!/bin/bash
set -e

bws_push_send() {
  source ~/dev/bocal-smtpd-certs-configuration/bws_push.sh.env

  ############################################
  #### Upload certs to Bitwarden secrets. ####
  ############################################

  CERT_DIR=~/.acme.sh/bocalusermail.fyi_ecc
  _subject="$1"
  _content="$2"
  _statusCode="$3" #0: success, 1: error 2($RENEW_SKIP): skipped
  _debug "_statusCode" "$_statusCode"

  if [ -f "$CERT_DIR/fullchain.cer" ] && [ -f "$CERT_DIR/bocalusermail.fyi.key" ]; then
      _info "🔐 Uploading certificates to Bitwarden..."
  
      PRIVATEKEY_VAL=$(cat "$CERT_DIR/fullchain.cer" | base64)
      FULLCHAIN_VAL=$(cat "$CERT_DIR/bocalusermail.fyi.key" | base64)
      
      bws secret edit $BWS_PRIVATEKEY_ID \
          --access-token $BWS_ACCESS_TOKEN \
          --key $BWS_PRIVATEKEY_KEY \
          --value $PRIVATEKEY_VAL \
          --note "bocal-smtpd private key, base64 encoded because cannot pass content directly to bws cli." \
          --project-id $BWS_PROJECT_ID

      bws secret edit $BWS_FULLCHAIN_ID \
          --access-token $BWS_ACCESS_TOKEN \
          --key $BWS_FULLCHAIN_KEY \
          --value $FULLCHAIN_VAL \
          --note "bocal-smtpd fullchain, base64 encoded because cannot pass content directly to bws cli." \
          --project-id $BWS_PROJECT_ID
      
      _info "✅ Certificates uploaded to Bitwarden!"
      return 0
  else
      _err "❌ Certificate files not found in $CERT_DIR"
      return 1
  fi

}
