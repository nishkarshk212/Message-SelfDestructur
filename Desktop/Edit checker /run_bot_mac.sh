#!/bin/bash

# Run Edit Checker Bot on macOS
# This script starts the bot on your Mac

echo "=========================================="
echo "Edit Checker Bot - macOS Runner"
echo "=========================================="
echo ""

# Navigate to bot directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR" || exit 1

echo "Working directory: $SCRIPT_DIR"
echo ""

# Check if virtual environment exists
if [ ! -d ".venv" ]; then
    echo "❌ Virtual environment not found!"
    echo "Creating virtual environment..."
    python3 -m venv .venv
    source .venv/bin/activate
    pip install --upgrade pip
    pip install -r requirements.txt
else
    echo "✅ Virtual environment found"
    source .venv/bin/activate
fi

echo ""
echo "Checking dependencies..."
python3 -c "import telegram; import dotenv; import psutil" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "Installing missing dependencies..."
    pip install -r requirements.txt
fi

echo ""
echo "=========================================="
echo "Starting Edit Checker Bot..."
echo "=========================================="
echo ""
echo "Bot is now running! Press Ctrl+C to stop."
echo ""
echo "Logs will appear below:"
echo "------------------------------------------"

# Run the bot
python3 bot.py
