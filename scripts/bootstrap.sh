#!/usr/bin/env bash
set -e

# INFO: Configuration
REPO_URL="https://github.com/rtdevx/cicd-ansible-pull"

# INFO: Ensure ansible user exists
echo "Ensuring ansible user exists..."

if ! id ansible >/dev/null 2>&1; then
    echo "Creating ansible user..."
    sudo useradd \
        --system \
        --create-home \
        --shell /usr/sbin/nologin \
        ansible
fi

# INFO: Configure passwordless sudo for ansible user
echo "Configuring sudo privileges..."
echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible >/dev/null
sudo chmod 440 /etc/sudoers.d/ansible

# INFO: Prepare SSH directory for ansible user
echo "Preparing SSH directory for ansible user..."

sudo -u ansible mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo chown ansible:ansible /home/ansible/.ssh

# INFO: Install dependencies
echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y ansible git curl

ansible-pull -U "$REPO_URL" --clean

echo "Bootstrap complete."