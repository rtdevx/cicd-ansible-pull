#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/rtdevx/cicd-ansible-pull.git"
PLAYBOOK="playbooks/common.yml"

echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y ansible git

echo "Creating ansible-pull wrapper..."
sudo tee /usr/local/bin/ansible-pull-wrapper >/dev/null <<EOF

#!/usr/bin/env bash
/usr/bin/ansible-pull -U "$REPO_URL" "$PLAYBOOK" --clean
EOF

sudo chmod +x /usr/local/bin/ansible-pull-wrapper

echo "Installing systemd service and timer..."
sudo cp systemd/ansible-pull.service /etc/systemd/system/
sudo cp systemd/ansible-pull.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable --now ansible-pull.timer

echo "Bootstrap complete."