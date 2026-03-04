# 🍎 Edit Checker Bot - macOS Deployment Guide

## ✅ Quick Start (Recommended)

### Option 1: Using the Run Script (Easiest)

Open Terminal and run:

```bash
cd "/Users/nishkarshkr/Desktop/Edit checker "
bash run_bot_mac.sh
```

The script will:
- Check if virtual environment exists
- Install dependencies if needed
- Start your bot automatically

**To stop the bot:** Press `Ctrl+C`

---

### Option 2: Manual Start

```bash
# Navigate to bot directory
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"

# Activate virtual environment
source .venv/bin/activate

# Run the bot
python3 bot.py
```

**To stop:** Press `Ctrl+C`

**To exit virtual environment:** Type `deactivate`

---

## 🔧 Initial Setup (First Time Only)

If you haven't set up the bot yet:

### Step 1: Install Python 3 (if not installed)

Download from: https://www.python.org/downloads/macos/

Or use Homebrew:
```bash
brew install python3
```

### Step 2: Navigate to Bot Directory

```bash
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"
```

### Step 3: Create Virtual Environment

```bash
python3 -m venv .venv
```

### Step 4: Activate Virtual Environment

```bash
source .venv/bin/activate
```

You should see `(.venv)` in your terminal prompt.

### Step 5: Install Dependencies

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

### Step 6: Verify .env File

Your bot token is already set in `.env`:
```
BOT_TOKEN=8255170758:AAFT7W9LsdHc_sSxz4U4YVQMIWs5Wf5ErCk
```

✅ **Token is configured!**

---

## 🚀 Running the Bot

### Starting the Bot

**Method A - Using the script:**
```bash
cd "/Users/nishkarshkr/Desktop/Edit checker "
bash run_bot_mac.sh
```

**Method B - Manual:**
```bash
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"
source .venv/bin/activate
python3 bot.py
```

### Expected Output

When the bot starts successfully, you'll see:
```
2026-03-04 13:XX:XX - telegram.ext.Application - INFO - Application started
2026-03-04 13:XX:XX - __main__ - INFO - Bot is starting...
```

The bot will keep running and show logs when it detects:
- Edited messages (will delete them)
- Messages with links (will delete them)
- All activity logged to @log_x_bott

---

## ⚙️ Auto-Start on Mac Login (Optional)

To make the bot start automatically when you log in to your Mac:

### Step 1: Create Launch Agent

```bash
nano ~/Library/LaunchAgents/com.editchecker.bot.plist
```

### Step 2: Paste This Content

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.editchecker.bot</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/nishkarshkr/Desktop/Edit checker /run_bot_mac.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/edit_checker_bot.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/edit_checker_bot_error.log</string>
    <key>WorkingDirectory</key>
    <string>/Users/nishkarshkr/Desktop/Edit checker /Edit_checker</string>
</dict>
</plist>
```

Save: `Ctrl+O`, `Enter`, then exit `Ctrl+X`

### Step 3: Load the Launch Agent

```bash
launchctl load ~/Library/LaunchAgents/com.editchecker.bot.plist
```

### To Unload (Disable Auto-Start)

```bash
launchctl unload ~/Library/LaunchAgents/com.editchecker.bot.plist
```

---

## 📊 Monitoring the Bot

### Check if Bot is Running

Open a new Terminal window and run:

```bash
ps aux | grep "python.*bot.py" | grep -v grep
```

If you see output, the bot is running!

### View Logs

The bot logs appear in the Terminal where it's running.

If using auto-start, check logs at:
```bash
tail -f /tmp/edit_checker_bot.log
tail -f /tmp/edit_checker_bot_error.log
```

---

## 🛑 Stopping the Bot

### If Running in Terminal

Press `Ctrl+C` in the Terminal window where it's running.

### If Using Auto-Start

```bash
launchctl unload ~/Library/LaunchAgents/com.editchecker.bot.plist
```

Or kill the process:
```bash
pkill -f "python.*bot.py"
```

---

## 🔄 Updating the Bot

To update with latest code from GitHub:

```bash
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"
git pull origin main
source .venv/bin/activate
pip install -r requirements.txt
# Restart the bot (Ctrl+C, then run again)
```

---

## 🐛 Troubleshooting

### Issue: "command not found: python3"

Install Python 3:
```bash
brew install python3
```

Or download from: https://www.python.org/downloads/macos/

### Issue: "No module named 'telegram'"

Install dependencies:
```bash
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"
source .venv/bin/activate
pip install -r requirements.txt
```

### Issue: "BOT_TOKEN not found"

Check the .env file:
```bash
cat "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker/.env"
```

Should show: `BOT_TOKEN=8255170758:AAFT7W9LsdHc_sSxz4U4YVQMIWs5Wf5ErCk`

### Issue: Bot won't start

1. Check if token is correct
2. Make sure you're in the right directory
3. Verify virtual environment is activated
4. Check logs for error messages

### Test Bot Connection

```bash
cd "/Users/nishkarshkr/Desktop/Edit checker /Edit_checker"
source .venv/bin/activate
python3 -c "from dotenv import load_dotenv; import os; load_dotenv(); print('Token loaded:', os.getenv('BOT_TOKEN').startswith('8255'))"
```

Should print: `Token loaded: True`

---

## 📝 Quick Reference Commands

| Action | Command |
|--------|---------|
| Start bot (script) | `bash run_bot_mac.sh` |
| Start bot (manual) | `cd Edit_checker && source .venv/bin/activate && python3 bot.py` |
| Stop bot | Press `Ctrl+C` |
| Check if running | `ps aux \| grep "python.*bot.py"` |
| Update bot | `git pull && pip install -r requirements.txt` |
| View .env | `cat .env` |
| Activate venv | `source .venv/bin/activate` |
| Deactivate venv | `deactivate` |

---

## ✅ What You Have

- ✅ Bot token configured: `8255170758:AAFT7W9LsdHc_sSxz4U4YVQMIWs5Wf5ErCk`
- ✅ Virtual environment ready
- ✅ Dependencies installed
- ✅ Run script created: `run_bot_mac.sh`
- ✅ Logging to @log_x_bott enabled

---

## 🎯 Next Steps

1. **Start the bot:**
   ```bash
   cd "/Users/nishkarshkr/Desktop/Edit checker "
   bash run_bot_mac.sh
   ```

2. **Test in Telegram:**
   - Add bot to a test group
   - Try editing a message (bot should delete it)
   - Try sending a link (bot should delete it)

3. **Check logs:**
   - Watch Terminal for activity logs
   - Check @log_x_bott channel for forwarded logs

---

**Bot Status:** Ready to run! 🚀  
**Platform:** macOS  
**Python Version:** Python 3.x  
**Virtual Environment:** .venv  

Happy botting! 🎉
