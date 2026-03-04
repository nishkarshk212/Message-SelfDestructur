#!/bin/bash

# Deployment script for Edit Checker Bot
# This script deploys from GitHub repository to server

SERVER_IP="140.245.240.202"
SERVER_USER="root"
SSH_PORT="22"
BOT_NAME="edit_checker_bot"
INSTALL_DIR="/opt/$BOT_NAME"
GITHUB_REPO="https://github.com/nishkarshk212/Message-SelfDestructur.git"
BRANCH="main"

echo "=========================================="
echo "Edit Checker Bot Deployment"
echo "=========================================="
echo ""
echo "Server: $SERVER_IP"
echo "User: $SERVER_USER"
echo "Installation Directory: $INSTALL_DIR"
echo "GitHub Repo: $GITHUB_REPO"
echo "Branch: $BRANCH"
echo ""

# Create SSH key if it doesn't exist
if [ ! -f ~/.ssh/id_rsa ]; then
    echo "Creating SSH key..."
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" -q
fi

# Copy SSH key to server
echo "Setting up SSH access to server..."
ssh-copy-id -o StrictHostKeyChecking=no -p $SSH_PORT $SERVER_USER@$SERVER_IP

if [ $? -ne 0 ]; then
    echo "Failed to setup SSH access. Please check your credentials."
    exit 1
fi

echo ""
echo "Starting remote deployment..."
echo ""

# Execute deployment commands on remote server
ssh -p $SSH_PORT $SERVER_USER@$SERVER_IP << 'ENDSSH'
#!/bin/bash

BOT_NAME="edit_checker_bot"
INSTALL_DIR="/opt/$BOT_NAME"
GITHUB_REPO="https://github.com/nishkarshk212/Message-SelfDestructur.git"
BRANCH="main"

echo "=== Remote Server Deployment Started ==="
echo ""

# Update system packages
echo "[1/8] Updating system packages..."
apt-get update -y
apt-get upgrade -y

# Install required packages
echo "[2/8] Installing required packages..."
apt-get install -y git python3 python3-pip python3-venv unzip curl

# Create installation directory
echo "[3/8] Creating installation directory..."
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR

# Clone or update from GitHub
if [ -d ".git" ]; then
    echo "Updating existing installation from GitHub..."
    git pull origin $BRANCH
else
    echo "Cloning repository from GitHub..."
    git clone $GITHUB_REPO .
fi

# Navigate to Edit_checker directory
cd "$INSTALL_DIR/Edit checker /Edit_checker" || {
    echo "Error: Could not find Edit_checker directory"
    exit 1
}

# Create virtual environment
echo "[4/8] Creating Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
echo "[5/8] Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Create .env file
echo "[6/8] Setting up environment variables..."
if [ ! -f .env ]; then
    echo "Creating .env file..."
    echo "# Add your bot token here" > .env
    echo "BOT_TOKEN=your_bot_token_here" >> .env
    echo "" >> .env
    echo "⚠️  IMPORTANT: Edit .env file and add your actual BOT_TOKEN!"
else
    echo ".env file already exists, skipping..."
fi

# Create logs directory
mkdir -p logs

# Set proper permissions
echo "[7/8] Setting permissions..."
chown -R root:root $INSTALL_DIR
chmod +x *.py

# Create systemd service
echo "[8/8] Creating systemd service..."
cat > /etc/systemd/system/$BOT_NAME.service << 'EOSERVICE'
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
EOSERVICE

# Reload systemd, enable and start service
systemctl daemon-reload
systemctl enable $BOT_NAME
systemctl start $BOT_NAME

# Wait a moment for the service to start
sleep 3

# Check service status
echo ""
echo "=== Deployment Complete ==="
echo ""
echo "Bot Status:"
systemctl status $BOT_NAME --no-pager -l
echo ""
echo "Bot Enabled (starts on boot): $(systemctl is-enabled $BOT_NAME)"
echo ""

# Show next steps
echo "=========================================="
echo "NEXT STEPS:"
echo "=========================================="
echo ""
echo "1. Edit the .env file with your bot token:"
echo "   nano '$INSTALL_DIR/Edit checker /Edit_checker/.env'"
echo ""
echo "2. Restart the bot after adding token:"
echo "   systemctl restart $BOT_NAME"
echo ""
echo "3. View bot logs:"
echo "   journalctl -u $BOT_NAME -f"
echo ""
echo "4. Check bot status:"
echo "   systemctl status $BOT_NAME"
echo ""
echo "5. Stop bot:"
echo "   systemctl stop $BOT_NAME"
echo ""
echo "6. Start bot:"
echo "   systemctl start $BOT_NAME"
echo ""
echo "=========================================="

ENDSSH

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Deployment completed successfully!"
    echo ""
    echo "IMPORTANT: You need to add your BOT_TOKEN to the .env file on the server"
    echo "SSH into the server and edit: nano /opt/edit_checker_bot/Edit\ checker/Edit_checker/.env"
    echo ""
else
    echo ""
    echo "❌ Deployment failed! Please check the error messages above."
    exit 1
fi
