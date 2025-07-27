<h1 align="center">🚫 SSH Brute-Force Blocker</h1>
<p align="center">
  <b>Lightweight Fail2Ban alternative — shell script to block repeated failed SSH attempts in seconds.</b><br>
  Secure your VPS without the bloat.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Security-SSH%20Protector-red?style=flat-square">
  <img src="https://img.shields.io/badge/Platform-Ubuntu%20%7C%20Debian-orange?style=flat-square">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=flat-square">
  <img src="https://img.shields.io/badge/Maintained-Yes-success?style=flat-square">
</p>

---

## 🚀 Overview

This script provides a simple mechanism to detect and block SSH brute-force attempts based on failed login logs.

- 🔍 Scans `/var/log/auth.log` for failed SSH login attempts
- 🚫 Automatically blocks IPs with ≥ 5 failed logins using `iptables`
- 📜 Logs all banned IPs to `/var/log/ssh_ban_list.txt`
- 🧠 No need to install Fail2Ban or extra services

---

## 📦 Requirements

- Ubuntu 18.04+ or Debian-based VPS
- `iptables` must be installed and active
- Log source: `/var/log/auth.log`

---

## ⚙️ Installation

Clone the repo:

    git clone https://github.com/yongkico/ssh-brute-blocker.git && cd ssh-brute-blocker

Make the script executable:

    chmod +x ssh-brute-blocker.sh

Run it:

    sudo ./ssh-brute-blocker.sh

> ✅ You can run it manually or schedule it with crontab (e.g. every 5 mins) for automation.

Add to crontab with:

    */5 * * * * /path/to/ssh-brute-blocker.sh

---

## 📝 Example Log Output

    [INFO] Scanning /var/log/auth.log for failed SSH attempts...
    [BAN] 192.168.1.100 - 6 failed attempts
    [BAN] 10.20.30.40 - 7 failed attempts
    [SKIP] 192.168.1.100 already banned.
    [DONE] Scan complete. Add this script to cron (e.g. */5 * * * *) for periodic protection.

---

## 📁 File Structure

| File                 | Purpose                                         |
|----------------------|-------------------------------------------------|
| `ssh-brute-blocker.sh` | Main shell script for brute-force blocking     |
| `README.md`          | Documentation and usage guide                  |

---

## 🧯 Tips

- Unban a specific IP manually:

      sudo iptables -D INPUT -s <IP> -j DROP

- View currently banned IPs:

      sudo cat /var/log/ssh_ban_list.txt

---

## 🤝 Credits

Built by **Stucklabs** — lightweight server tools for everyone.

---

## 📝 License

This project is licensed under the [MIT License](LICENSE).

> Built for admins who prefer speed, control, and simplicity ⚡
