#!/bin/bash
set -e

echo "==> Flushing old rules"
nft flush ruleset

# Paths
#BLACKLIST=${1:-/etc/nftables/blacklist.txt}
#WHITELIST=${2:-/etc/nftables/whitelist.txt}

# Create base table and chains
nft add table inet filter

nft add chain inet filter input   { type filter hook input priority 0 \; policy drop \; }
nft add chain inet filter output  { type filter hook output priority 0 \; policy accept \; }
nft add chain inet filter forward { type filter hook forward priority 0 \; policy drop \; }

# Define sets
nft add set inet filter banned_ipv4 '{ type ipv4_addr ; flags interval ; }'
nft add set inet filter banned_ipv6 '{ type ipv6_addr ; flags interval ; }'
nft add set inet filter white_ipv4  '{ type ipv4_addr ; flags interval ; }'
nft add set inet filter white_ipv6  '{ type ipv6_addr ; flags interval ; }'

## NOT From / to locale address
## cannot work, but should develop the concept
#for IP_LOCALE in $(ip addr | grep inet | grep -Eo $IP_REG) ; do
#	if [[ "$line" == *:* ]]; then
#		nft add rule ip filter input ip6 daddr $IP_LOCALE drop
#	else
#		echo "ban $line"
#		nft add rule ip filter input ip daddr $IP_LOCALE drop
#	fi
#done < "$BLACKLIST"

# Load whitelist
while IFS= read -r line; do
	[[ -z "$line" || "$line" == \#* ]] && continue
	if [[ "$line" == *:* ]]; then
		echo "accept $line"
		nft add element inet filter white_ipv6 "{ $line }"
	else
		echo "accept $line"
		nft add element inet filter white_ipv4 "{ $line }"
	fi
done < "$WHITELIST"

# Load blacklist
while IFS= read -r line; do
	[[ -z "$line" || "$line" == \#* ]] && continue
	if [[ "$line" == *:* ]]; then
		echo "ban $line"
		nft add element inet filter banned_ipv6 "{ $line }"
	else
		echo "ban $line"
		nft add element inet filter banned_ipv4 "{ $line }"
	fi
done < "$BLACKLIST"

# Input rules
nft add rule inet filter input iif "lo" accept
nft add rule inet filter input ip saddr @white_ipv4 accept
nft add rule inet filter input ip6 saddr @white_ipv6 accept
nft add rule inet filter input ip saddr @banned_ipv4 drop
nft add rule inet filter input ip6 saddr @banned_ipv6 drop
nft add rule inet filter input ct state established,related accept
nft add rule inet filter input drop

# Output rules
nft add rule inet filter output ip daddr @white_ipv4 accept
nft add rule inet filter output ip6 daddr @white_ipv6 accept
nft add rule inet filter output ip daddr @banned_ipv4 drop
nft add rule inet filter output ip6 daddr @banned_ipv6 drop
#nft add rule inet filter output accept

# Save and enable
echo "==> Saving to /etc/nftables.conf"
nft list ruleset > /etc/nftables.conf
chmod 644 /etc/nftables.conf

nft flush ruleset
echo "==> Enabling nftables.service"
systemctl enable --now nftables.service

echo "✅ Firewall applied and saved."

