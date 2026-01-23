#!/bin/bash

if [ -z "$1" ] ; then echo "no args" ; exit 1 ; fi

TARGET=$1
DIR="$HOME/journal/net/scan/$2"
[[ "$DIR" != */ ]] && DIR="$DIR/"
OUTPUT_DIR=$DIR"${TARGET}_$(date +%F_%H-%M-%S).nmap"

mkdir -p "$OUTPUT_DIR"

log() {
  echo "[+] $1"
  echo "[+] $1" >> "$OUTPUT_DIR/scan.log"
}

log "Target: $TARGET"

### 1. Passive recon
log "DNS & WHOIS"
dig +short "$TARGET" > "$OUTPUT_DIR/dns.txt"
whois "$TARGET" > "$OUTPUT_DIR/whois.txt"
nslookup "$TARGET" > "$OUTPUT_DIR/nslookup.txt"

log "Traceroute"
traceroute "$TARGET" > "$OUTPUT_DIR/traceroute.txt"

# Détection IPv4 / IPv6
IPV4=$(dig +short A "$TARGET" | head -n1)
IPV6=$(dig +short AAAA "$TARGET" | head -n1)

scan_block() {
  local mode=$1  # "IPv4" ou "IPv6"
  local opt=$2   # "" ou "-6"

  log "=== $mode Scans ==="

  log "Fast TCP Scan (top 100 ports)"
  sudo nmap $opt -Pn -sS -sV --top-ports 100 -T2 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_fast_tcp.txt"

  log "Full TCP Scan (all 65535 ports)"
  sudo nmap $opt -Pn -sS -p- -T3 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_full_tcp.txt"

  log "UDP Scan (top 50 ports)"
  sudo nmap $opt -Pn -sU --top-ports 50 -T4 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_udp.txt"

  log "SCTP Init Scan (top 50 ports)"
  sudo nmap $opt -Pn -sY --top-ports 50 -T3 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_sctp.txt"

  log "Service Detection (all protocols)"
  sudo nmap $opt -Pn -sV -p- -sS -sU -T2 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_service.txt"

  log "OS Detection"
  sudo nmap $opt -Pn -O -A -T2 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_os.txt"

  log "Nmap Vulnerability Scripts"
  sudo nmap $opt -Pn --script vuln -T2 "$TARGET" -oN "$OUTPUT_DIR/nmap_${mode}_vuln.txt"
}

### 2. Lancer scans selon ce qui est dispo
if [ -n "$IPV4" ]; then
  log "IPv4 detected: $IPV4"
  scan_block "ipv4" ""
else
  log "No IPv4 found"
fi

if [ -n "$IPV6" ]; then
  log "IPv6 detected: $IPV6"
  scan_block "ipv6" "-6"
else
  log "No IPv6 found"
fi

### 3. Fin
log "Scan completed. Results in $OUTPUT_DIR/"

# Hook perso
source "$HOME/.bashrc"
journal "$OUTPUT_DIR" README

