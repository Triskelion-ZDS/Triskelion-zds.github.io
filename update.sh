#!/bin/sh
# Points the GitHub forwarding page at the website's current address, then publishes it.
# Usage: sh update.sh https://xxxx.trycloudflare.com
set -e
cd "$(dirname "$0")"
URL="${1%/}"
case "$URL" in https://*) ;; *) echo "give the https address"; exit 1;; esac
sed "s#__SITE__#$URL#g" template.html > index.html
cp index.html 404.html
git add -A
git commit -q -m "Forward to $URL" || true
git push -q origin main
echo "forwarding to $URL"
