#!/bin/bash

# =============================================
# 🚫 SSH Brute-Force Blocker by Stucklabs
# =============================================
# Lightweight alternative to Fail2Ban
# Blocks IPs with multiple failed SSH login attempts
# =============================================

# Configurable variables
LOG_FILE="/var/log/auth.log"
BAN_THRESHOLD=5
BAN_LIST="/var/log/ssh_ban_list.txt"
FIREWALL_BLOCK_COMMAND="iptables -A INPUT -s"

# Ensure log file exists
mkdir -p /var/log
[ ! -f "$BAN_LIST" ] && touch "$BAN_LIST"

# Parse and ban function
block_brute_force_ips() {
    echo "[INFO] Scanning $LOG_FILE for failed SSH attempts..."
    grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | while read ATTEMPTS IP; do
        if [[ $ATTEMPTS -ge $BAN_THRESHOLD ]]; then
            if grep -q "$IP" "$BAN_LIST"; then
                echo "[SKIP] $IP already banned."
            else
                echo "[BAN] $IP - $ATTEMPTS failed attempts"
                $FIREWALL_BLOCK_COMMAND $IP -j DROP
                echo "$IP" >> "$BAN_LIST"
            fi
        fi
    done
}

# Run once
block_brute_force_ips

# Suggest cron setup
echo "[DONE] Scan complete. Add this script to cron (e.g. */5 * * * *) for periodic protection."
echo "[TIP] Unban IP manually using: iptables -D INPUT -s <IP> -j DROP"
