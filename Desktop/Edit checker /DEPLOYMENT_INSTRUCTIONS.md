# Edit Checker Bot - Manual Server Deployment Guide

## Server Information
- **IP Address:** 140.245.240.202
- **Username:** root
- **Port:** 22
- **GitHub Repo:** https://github.com/nishkarshk212/Message-SelfDestructur.git

---

## Step-by-Step Deployment Instructions

### Step 1: Connect to Your Server
Open Terminal and run:
```bash
ssh -p 22 root@140.245.240.202
```
Enter password when prompted: `Akshay343402355468`

### Step 2: Update System Packages
Once connected to the server, run:
```bash
apt-get update && apt-get upgrade -y
```

### Step 3: Install Required Software
```bash
apt-get install -y git python3 python3-pip python3-venv unzip curl
```

### Step 4: Create Installation Directory
```bash
mkdir -p /opt/edit_checker_bot
cd /opt/edit_checker_bot
```

### Step 5: Clone GitHub Repository
```bash
git clone https://github.com/nishkarshk212/Message-SelfDestructur.git .
```

### Step 6: Navigate to Bot Directory
```bash
cd "Edit checker /Edit_checker"
```

### Step 7: Create Virtual Environment
```bash
python3 -m venv venv
source venv/bin/activate
```

### Step 8: Install Python Dependencies
```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Step 9: Create Environment File
```bash
nano .env
```

Add your bot token:
```
BOT_TOKEN=your_actual_bot_token_here
```

Press `Ctrl+X`, then `Y`, then `Enter` to save.

### Step 10: Create Logs Directory
```bash
mkdir -p logs
```

### Step 11: Create Systemd Service
```bash
nano /etc/systemd/system/edit_checker_bot.service
```

Paste this content:
```ini
[Unit]
Description=Edit Checker Telegram Bot
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/edit_checker_bot/Edit checker /Edit_checker
Environment=PATH=/opt/edit_checker_bot/Edit checker /Edit_checker/venv/bin
ExecStart=/opt/edit_checker_bot/Edit checker /Edit_checker/venv/bin/python bot.py
Restart=always
RestartSec=10
StandardOutput=append:/opt/edit_checker_bot/Edit checker /Edit_checker/logs/bot.log
StandardError=append:/opt/edit_checker_bot/Edit checker /Edit_checker/logs/error.log

[Install]
WantedBy=multi-user.target
```

Save and exit (`Ctrl+X`, `Y`, `Enter`).

### Step 12: Enable and Start the Bot
```bash
systemctl daemon-reload
systemctl enable edit_checker_bot
systemctl start edit_checker_bot
```

### Step 13: Check Bot Status
```bash
systemctl status edit_checker_bot
```

You should see "active (running)" in green.

---

## Useful Commands

### View Bot Logs (Real-time)
```bash
journalctl -u edit_checker_bot -f
```

### View Bot Logs (Last 100 lines)
```bash
journalctl -u edit_checker_bot -n 100
```

### Stop the Bot
```bash
systemctl stop edit_checker_bot
```

### Restart the Bot
```bash
systemctl restart edit_checker_bot
```

### Start the Bot
```bash
systemctl start edit_checker_bot
```

### Check if Bot is Running
```bash
systemctl is-active edit_checker_bot
```

### Check if Bot Starts on Boot
```bash
systemctl is-enabled edit_checker_bot
```

---

## Updating the Bot

To update the bot from GitHub:

```bash
cd /opt/edit_checker_bot
git pull origin main
cd "Edit checker /Edit_checker"
source venv/bin/activate
pip install -r requirements.txt
systemctl restart edit_checker_bot
```

---

## Troubleshooting

### Bot Won't Start
Check the logs for errors:
```bash
journalctl -u edit_checker_bot -n 50
```

### Common Issues

1. **Bot token error**: Make sure BOT_TOKEN in .env file is correct
2. **Permission errors**: Run `chmod +x bot.py`
3. **Python package errors**: Run `pip install -r requirements.txt` again

### Test Bot Manually
```bash
cd /opt/edit_checker_bot/Edit\ checker/Edit_checker
source venv/bin/activate
python bot.py
```

Press `Ctrl+C` to stop.

---

## Features Deployed

✅ Edited message detection and deletion
✅ Link detection in regular messages
✅ Automatic logging to Telegram channel: @log_x_bott
✅ Systemd service for auto-start on boot
✅ Log rotation and management
✅ Production-ready configuration

---

## Security Notes

⚠️ **Important Security Reminders:**
- Keep your BOT_TOKEN secret
- Never commit .env files to Git
- Regularly update your server packages
- Monitor bot logs for unusual activity
- Use firewall rules to secure your server

---

## Support

If you encounter any issues:
1. Check the bot logs: `journalctl -u edit_checker_bot -f`
2. Verify your bot token in .env file
3. Ensure all dependencies are installed
4. Check that port 22 is open for SSH

---

**Deployment Date:** $(date)
**Server:** 140.245.240.202
**Repository:** https://github.com/nishkarshk212/Message-SelfDestructur.git
