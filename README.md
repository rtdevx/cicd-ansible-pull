# ansible-pull
Ansible pull repository for Ubuntu-based Servers and Desktops.

# Architecture

```
ansible/
├── playbooks/
│   ├── servers.yml
│   ├── desktops.yml
│   └── common.yml
│
├── roles/
│   ├── server_general/
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

## Regions

- `prod-*`
- `stg-*`

## Server base

- `*-srv-*`

## Desktop base

- `*-dsk-*`

## 🖥️ Servers - Hostname Patterns

| Group                | Name Pattern          |
| -------------------- | --------------------- |
| server_general       | `*-srv-gen-*`         |
| server_docker        | `*-srv-docker-*`      |
| server_swarm_manager | `*-srv-docker-mgr-*`  |
| server_swarm_host    | `*-srv-docker-host-*` |
| server_utility       | `*-srv-util-*`        |

These are short, consistent, and still clearly map to your existing group names.

## 🖥️ Desktops - Hostname Patterns

| Group               | Name Pattern  |
| ------------------- | ------------- |
| desktop_general     | `*-dsk-gen-*` |
| desktop_development | `*-dsk-dev-*` |

## 🧠 Example Hostnames Using the Short Patterns

### Servers

- `prod-srv-g-01`    
- `prod-srv-dkr-01`    
- `prod-srv-dkr-m-01`    
- `prod-srv-dkr-h-01`    
- `prod-srv-u-01`
### Desktops

- `stg-dsk-g-01`    
- `stg-dsk-d-01`