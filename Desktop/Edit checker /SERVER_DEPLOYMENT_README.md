# 🚀 Server Deployment Guide - Edit Checker Bot

## 📋 Quick Overview

Your bot is ready to deploy from your GitHub repository to your server!

**Server Details:**
- **IP:** 140.245.240.202
- **Username:** root  
- **Port:** 22
- **GitHub Repo:** https://github.com/nishkarshk212/Message-SelfDestructur.git

---

## ⚡ Method 1: Automated Deployment (RECOMMENDED)

### Step 1: Upload Deployment Package to Server

Open Terminal on your Mac and run:

```bash
scp -P 22 /tmp/edit_checker_deployment_package.zip root@140.245.240.202:/root/
```

When prompted, enter password: `Akshay343402355468`

### Step 2: Connect to Server

```bash
ssh -p 22 root@140.245.240.202
```

Enter password: `Akshay343402355468`

### Step 3: Extract and Run Deployment Script

On the server, run these commands:

```bash
cd /root
unzip edit_checker_deployment_package.zip
cd edit_checker_deploy
bash deploy_to_server.sh
```

The script will automatically:
- ✅ Update system packages
- ✅ Install Python and Git
- ✅ Clone your GitHub repository
- ✅ Set up virtual environment
- ✅ Install dependencies
- ✅ Create systemd service
- ✅ Start the bot

### Step 4: Add Your Bot Token

After deployment completes, add your bot token:

```bash
nano "/opt/edit_checker_bot/Edit checker /Edit_checker/.env"
```

Replace `your_bot_token_here` with your actual bot token from Telegram.

Save: Press `Ctrl+O`, then `Enter`, then exit with `Ctrl+X`

### Step 5: Restart the Bot

```bash
systemctl restart edit_checker_bot
```

### Step 6: Verify Bot is Running

```bash
systemctl status edit_checker_bot
```

You should see: **"active (running)"** in green text.

---

## 📝 Method 2: Manual Deployment

If automated deployment fails, follow the detailed manual instructions in:
- **File:** `DEPLOYMENT_INSTRUCTIONS.md` (in the deployment package)

Or access it online in your repository.

---

## 🔧 Post-Deployment Commands

### Check Bot Status
```bash
systemctl status edit_checker_bot
```

### View Live Logs
```bash
journalctl -u edit_checker_bot -f
```

### View Last 50 Log Lines
```bash
journalctl -u edit_checker_bot -n 50
```

### Stop Bot
```bash
systemctl stop edit_checker_bot
```

### Start Bot
```bash
systemctl start edit_checker_bot
```

### Restart Bot
```bash
systemctl restart edit_checker_bot
```

### Enable Auto-Start on Boot
```bash
systemctl enable edit_checker_bot
```

### Disable Auto-Start on Boot
```bash
systemctl disable edit_checker_bot
```

---

## 🔄 Updating Your Bot

To update the bot with latest code from GitHub:

```bash
cd /opt/edit_checker_bot
git pull origin main
cd "Edit checker /Edit_checker"
source venv/bin/activate
pip install -r requirements.txt
systemctl restart edit_checker_bot
```

---

## 🎯 What's Deployed?

Your bot includes these features:

✅ **Edited Message Detection** - Automatically deletes edited messages  
✅ **Link Detection** - Detects and deletes messages containing links  
✅ **Telegram Channel Logging** - All activity logged to @log_x_bott  
✅ **Auto-Start Service** - Bot starts automatically on server boot  
✅ **Log Management** - Automatic log rotation  
✅ **Production Ready** - Fully configured for 24/7 operation  

---

## 🐛 Troubleshooting

### Bot Won't Start

Check logs for errors:
```bash
journalctl -u edit_checker_bot -n 100
```

Common issues:
1. **Invalid BOT_TOKEN**: Check .env file has correct token
2. **Missing dependencies**: Run `pip install -r requirements.txt`
3. **Permission error**: Run `chmod +x bot.py`

### Test Bot Manually

```bash
cd "/opt/edit_checker_bot/Edit checker /Edit_checker"
source venv/bin/activate
python bot.py
```

Press `Ctrl+C` to stop.

### Check Python Version

```bash
python3 --version
```

Should show Python 3.8 or higher.

### Check if Port 22 is Open

From your local machine:
```bash
nc -zv 140.245.240.202 22
```

Should show: "succeeded"

---

## 📊 Monitoring

### Real-time Activity Monitor

Watch what your bot is doing in real-time:
```bash
watch -n 2 'systemctl status edit_checker_bot --no-pager'
```

### Check Memory Usage

```bash
ps aux | grep bot.py
```

### Check Process is Running

```bash
pgrep -f "python.*bot.py" && echo "Bot is running!" || echo "Bot is NOT running"
```

---

## 🔐 Security Notes

⚠️ **IMPORTANT SECURITY REMINDERS:**

- Never share your BOT_TOKEN publicly
- Keep your server password secure
- Regularly update server: `apt-get update && apt-get upgrade`
- Monitor logs for suspicious activity
- Consider setting up SSH keys instead of password authentication
- Use firewall rules to restrict access

---

## 📞 Need Help?

If you encounter issues:

1. **Check the logs first**: `journalctl -u edit_checker_bot -f`
2. **Verify bot token**: Make sure it's correct in .env file
3. **Test internet connection**: `ping google.com`
4. **Check GitHub access**: `git status`
5. **Restart the service**: `systemctl restart edit_checker_bot`

---

## 🎉 Success Indicators

Your deployment is successful when:

✅ Bot status shows "active (running)"  
✅ No errors in logs  
✅ Bot responds to /start command in Telegram  
✅ Logs are being sent to @log_x_bott channel  
✅ Bot is enabled to start on boot  

---

**Deployment Date:** March 4, 2026  
**Bot Version:** Latest from GitHub main branch  
**Repository:** https://github.com/nishkarshk212/Message-SelfDestructur.git

Good luck with your deployment! 🚀
