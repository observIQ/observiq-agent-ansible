Ansible Role For observIQ Cloud Agent
==========================

[![Integration Tests](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/integration.yml/badge.svg)](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/integration.yml)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

This Ansible role installs the observIQ Cloud agent.

Install this directory in your roles path (usually in a `roles` directory
alongside your playbook) under the name `observiq_cloud_agent`:

```bash
git clone https://github.com/observIQ/observiq-agent-ansible.git roles/observiq_cloud_agent 
```

Role Variables
--------------

| Name                             | Default Value                         | Description                                                                                                                            | 
| -------------------------------- | ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
| `version`                        | required                              | The `version` is required to specify which version of the agent to install. Supported versions: 1.3.11 or newer. | 
| `secret_key`                     | required                              | The `secret_key` is required for connecting to observIQ Cloud's management and ingestion services. | 
| `template_id`                    | optional                              | The `template_id` optionally install the agent and bind it to an observIQ cloud template. | 
| `install_dir`                    | `/opt/observiq-agent`                 | The directory the agent should be installed in. | 
| `service_user`                   | `root`                                | The runtime username. Root is required if your agent configuration requires listening on a privileged network port. The playbook will not create this user. | 
| `service_name`                   | `observiq-agent`                      | The service name used for managing the agent. | 
| `websocket_connection_endpoint`  | `wss://connections.app.observiq.com`  | The websocket endpoint used to connect to observIQ Cloud's management interface, this should never be changed. | 

## Examples

`version` and `secret_key` are the only required values.

playbook.yml
```yaml
- name: observiq
  hosts: all
  become: yes
  roles:
  - role: observiq_cloud_agent
    version: "1.3.11"
    secret_key: 00000000-0000-0000-0000-000000000000
```

## Credits

This repository was initially based on Google's [google-cloud-ops-agents-ansible](https://github.com/GoogleCloudPlatform/google-cloud-ops-agents-ansible)

## License

This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).