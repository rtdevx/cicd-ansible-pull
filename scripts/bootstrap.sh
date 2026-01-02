#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/rtdevx/cicd-ansible-pull"
RAW_URL="https://raw.githubusercontent.com/rtdevx/cicd-ansible-pull/main"
PLAYBOOK="playbooks/common.yml"

echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y ansible git curl

echo "Creating ansible-pull wrapper..."
sudo tee /usr/local/bin/ansible-pull-wrapper >/dev/null <<EOF

#!/usr/bin/env bash
/usr/bin/ansible-pull -U "$REPO_URL" "$PLAYBOOK" --clean
EOF

sudo chmod +x /usr/local/bin/ansible-pull-wrapper

echo "Installing systemd service and timer..."

sudo curl -s -o /etc/systemd/system/ansible-pull.service \
  $RAW_URL/systemd/ansible-pull.service

sudo curl -s -o /etc/systemd/system/ansible-pull.timer \
  $RAW_URL/systemd/ansible-pull.timer

echo "Reloading systemd and enabling timer..."
sudo systemctl daemon-reload
sudo systemctl enable --now ansible-pull.timer

echo "Bootstrap complete."