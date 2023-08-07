#!/bin/bash

# Check if the input file is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 domain_list.txt"
  exit 1
fi

# Input file provided as argument
DOMAIN_LIST=$1

# Step 1: Use assetfinder to find subdomains
echo "[*] Running assetfinder..."
assetfinder --subs-only -f $DOMAIN_LIST > domain.txt

# Step 2: Use subfinder to find additional subdomains
echo "[*] Running subfinder..."
subfinder -dL $DOMAIN_LIST -silent >> domain.txt

# Step 3: Filter out duplicate domains
echo "[*] Removing duplicate domains..."
sort -u -o domain.txt domain.txt

# Step 4: Use httprobe to find live subdomains
echo "[*] Running httprobe..."
cat domain.txt | httprobe > livedomain.txt

# Step 5: Append httprobe output to alldomains.txt
cat livedomain.txt >> alldomains.txt

# Step 6: Remove domain.txt
rm domain.txt

echo "[+] Done! Live subdomains saved in livedomain.txt. Appended to alldomains.txt."
