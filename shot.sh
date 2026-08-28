#!/bin/bash
# Captura a janela do Chrome cuja aba ativa é o Ariuno, recortando a área da página.
SP=/private/tmp/claude-501/-Users-caiquebecker/8dd71547-6ea4-4e26-8be7-d23354442afe/scratchpad
D="$HOME/ariuno-deck/assets/shots"
caffeinate -u -t 2 >/dev/null 2>&1
"$HOME/ariuno-deck/focus.sh"
for i in 1 2 3; do
  LINE=$(cd "$SP" && ./winlist | grep '|Ariuno$' | head -1)
  [ -z "$LINE" ] && { sleep 2; continue; }
  B=$(echo "$LINE" | cut -d'|' -f3); WID=$(echo "$LINE" | cut -d'|' -f1)
  W=$(echo "$B" | cut -d, -f3); H=$(echo "$B" | cut -d, -f4)
  VW=$((W-126)); VH=$((H-103))
  screencapture -x -o -l "$WID" -t png "$D/_raw.png" 2>/dev/null
  sleep 0.7
  if screencapture -x -o -l "$WID" -t png "$D/_raw.png" 2>/dev/null; then
    RW=$(sips -g pixelWidth "$D/_raw.png" | tail -1 | tr -dc 0-9)
    if [ "$RW" != "$W" ]; then rm -f "$D/_raw.png"; sleep 1.5; continue; fi
    sips -c "$VH" "$VW" --cropOffset 103 126 "$D/_raw.png" --out "$D/$1.png" >/dev/null 2>&1
    rm -f "$D/_raw.png"; echo "ok $1.png (${VW}x${VH})"; exit 0
  fi
  sleep 1.5
done
echo "FALHOU $1"; exit 1
