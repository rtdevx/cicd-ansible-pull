# ansible-pull
Ansible pull repository for Ubuntu-based Servers and Desktops.

# Usage

```
bash <(curl -s https://raw.githubusercontent.com/rtdevx/cicd-ansible-pull/main/scripts/bootstrap.sh)
```

# Architecture

```
ansible/
├── playbooks/
│   ├── servers.yml
│   ├── desktops.yml
│   └── common.yml
│
├── roles/
│   ├── server_iac/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   ├── server_docker/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   ├── server_swarm_manager/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   ├── server_swarm_host/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   ├── server_utility/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   │
│   ├── desktop_general/
│   │   ├── tasks/main.yml
│   │   └── defaults/main.yml
│   └── desktop_development/
│       ├── tasks/main.yml
│       └── defaults/main.yml
│
├── inventory/
│   └── dynamic_inventory.yml
│
├── group_vars/
│   ├── prod/
│   │   └── main.yml
│   └── staging/
│       └── main.yml
│
├── host_vars/
│   └── (empty for now)
│
├── systemd/
│   ├── ansible-pull.service
│   └── ansible-pull.timer
│
└── scripts/
    └── bootstrap.sh
```
# Host Name Patterns

**Server base:**

_Regex:_ `^srv-.*[s|p][0-9]?[0-9]?`

**Desktop base:**

_Regex:_ `^ws-.*[s|p][0-9]?[0-9]?`

**Region:**

`p` = Prod
`s` = Staging

## 🖥️ Servers - Hostname Patterns

| Category             | Pattern               | Meaning                      |
| -------------------- | --------------------- | ---------------------------- |
| server_iac           | **srv-iacp1**         | IAC server, prod, instance 1 |
| server_swarm_manager | **srv-docker-mgrp1**  | Docker swarm manager, prod   |
| server_swarm_host    | **srv-docker-hostp1** | Docker swarm worker, prod    |
| server_utility       | **srv-utlp1**         | Utility server, prod         |

## 🖥️ Desktops - Hostname Patterns

| Category            | Pattern      | Meaning                     |
| ------------------- | ------------ | --------------------------- |
| desktop_general     | **ws-genp1** | General workstation, prod   |
| desktop_development | **ws-devp1** | Developer workstation, prod |

## 🧠 Example Hostnames

`srv-iacp1` → prod, server
`srv-iacs1` → staging, server
`ws-devs3` → staging, workstation