#!/usr/bin/env bash
set -e

###############################################
# 1. Configuration
###############################################
REPO_URL="https://github.com/rtdevx/cicd-ansible-pull"
PLAYBOOK="playbooks/common.yml"

###############################################
# 2. Install dependencies
###############################################
echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y ansible git curl

###############################################
# 3. Create ansible-pull wrapper
###############################################
echo "Creating ansible-pull wrapper..."
sudo tee /usr/local/bin/ansible-pull-wrapper >/dev/null <<EOF
#!/usr/bin/env bash
/usr/bin/ansible-pull -U "$REPO_URL" "$PLAYBOOK" --clean
EOF

sudo chmod +x /usr/local/bin/ansible-pull-wrapper

###############################################
# 4. Install systemd service and timer
###############################################
echo "Installing systemd service and timer..."

# Ensure no old masked unit blocks installation
sudo systemctl stop ansible-pull.timer 2>/dev/null || true
sudo systemctl disable ansible-pull.timer 2>/dev/null || true
sudo systemctl unmask ansible-pull.timer 2>/dev/null || true

# Install fresh unit files
sudo curl -s -o /etc/systemd/system/ansible-pull.service \
  $REPO_URL/raw/main/systemd/ansible-pull.service

sudo curl -s -o /etc/systemd/system/ansible-pull.timer \
  $REPO_URL/raw/main/systemd/ansible-pull.timer

###############################################
# 5. Reload systemd and enable timer
###############################################
echo "Reloading systemd and enabling timer..."
sudo systemctl daemon-reload
sudo systemctl enable --now ansible-pull.timer

###############################################
# 6. Done
###############################################
echo "Bootstrap complete."