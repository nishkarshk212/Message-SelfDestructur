#!/bin/bash

# Quick Deploy Script for Edit Checker Bot
# Run this script on your LOCAL machine to prepare deployment files

echo "=========================================="
echo "Edit Checker Bot - Deployment Package"
echo "=========================================="
echo ""

# Create a deployment package
DEPLOY_DIR="/tmp/edit_checker_deploy_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$DEPLOY_DIR"

echo "Creating deployment package in: $DEPLOY_DIR"
echo ""

# Copy necessary files
cp "deploy_to_server.sh" "$DEPLOY_DIR/"
cp "DEPLOYMENT_INSTRUCTIONS.md" "$DEPLOY_DIR/"

# Create a quick start guide
cat > "$DEPLOY_DIR/QUICK_START.txt" << 'EOF'
================================================================================
                    QUICK DEPLOYMENT GUIDE
================================================================================

SERVER DETAILS:
IP: 140.245.240.202
User: root
Port: 22

OPTION 1: AUTOMATED DEPLOYMENT (Recommended)
--------------------------------------------
1. Copy deploy_to_server.sh to your server:
   scp -P 22 deploy_to_server.sh root@140.245.240.202:/root/

2. SSH into your server:
   ssh -p 22 root@140.245.240.202

3. Run the deployment script:
   bash /root/deploy_to_server.sh

4. Follow the prompts and add your BOT_TOKEN when asked


OPTION 2: MANUAL DEPLOYMENT (If automated fails)
-------------------------------------------------
1. SSH into your server:
   ssh -p 22 root@140.245.240.202

2. Follow the step-by-step instructions in DEPLOYMENT_INSTRUCTIONS.md


AFTER DEPLOYMENT:
-----------------
1. Add your bot token:
   nano /opt/edit_checker_bot/Edit\ checker/Edit_checker/.env
   
   Add: BOT_TOKEN=your_actual_token_here

2. Restart the bot:
   systemctl restart edit_checker_bot

3. Check status:
   systemctl status edit_checker_bot

4. View logs:
   journalctl -u edit_checker_bot -f


TROUBLESHOOTING:
----------------
- If deployment fails, check SSH connection
- Make sure you have internet on the server
- Verify GitHub repo is accessible
- Check if port 22 is open

================================================================================
EOF

# Make scripts executable
chmod +x "$DEPLOY_DIR/deploy_to_server.sh"

# Create a zip file
cd "$DEPLOY_DIR"
zip -r "../edit_checker_deployment_package.zip" .
cd - > /dev/null

echo ""
echo "✅ Deployment package created successfully!"
echo ""
echo "Package location: /tmp/edit_checker_deployment_package.zip"
echo ""
echo "=========================================="
echo "NEXT STEPS:"
echo "=========================================="
echo ""
echo "1. Open Terminal"
echo ""
echo "2. Upload deployment package to your server:"
echo "   scp -P 22 /tmp/edit_checker_deployment_package.zip root@140.245.240.202:/root/"
echo ""
echo "3. SSH into your server:"
echo "   ssh -p 22 root@140.245.240.202"
echo ""
echo "4. Extract and run:"
echo "   cd /root"
echo "   unzip edit_checker_deployment_package.zip"
echo "   cd edit_checker_deploy_*"
echo "   bash deploy_to_server.sh"
echo ""
echo "OR follow the manual instructions in DEPLOYMENT_INSTRUCTIONS.md"
echo ""
echo "=========================================="
echo ""
