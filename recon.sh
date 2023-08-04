#!/bin/bash

# Ask for domain name
read -p "Enter the domain name: " DOMAIN

# Step 1: Use assetfinder to find subdomains
echo "[*] Running assetfinder..."
assetfinder --subs-only $DOMAIN > domain.txt

# Step 2: Use subfinder to find additional subdomains
echo "[*] Running subfinder..."
subfinder -d $DOMAIN -silent >> domain.txt

# Step 3: Filter out duplicate domains
echo "[*] Removing duplicate domains..."
sort -u -o domain.txt domain.txt

# Step 4: Use httprobe to find live subdomains
echo "[*] Running httprobe..."
cat domain.txt | httprobe > livedomain.txt

# Step 5: Remove domain.txt
rm domain.txt

echo "[+] Done! Live subdomains saved in livedomain.txt."

