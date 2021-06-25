Ansible Role For observIQ Cloud Agent
==========================

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
| `agent_type`                     | `observiq-agent`                      | The `agent_type` is a required variable used to specify which agent is being configured. The available options are `observiq-agent`.   | 
| `package_state`                  | `installed`                           | TThe `package_state` variable can be used to specify the desired state of the agent. The allowed values are `present` (default) and `absent`. | 
| `install_dir`                    | `/opt`                                | The directory the agent should be installed in. By default `/opt` means `/opt/observiq-agent` will be created | 
| `service_user`                   | `root`                                | The runtime username. Root is required if your agent configuration requires listening on a privileged network port. | 
| `service_name`                   | `observiq-agent`                      | The service name used for managing the agent. | 
| `websocket_connection_endpoint`  | `wss://connections.app.observiq.com`  | The websocket endpoint used to connect to observIQ Cloud's management interface, this should never be changed. | 
| `version`                        | required                              | The `version` is required to specify which version of the agent to install. | 
| `secret_key`                     | required                              | The `secret_key` is required for connecting to observIQ Cloud's management and ingestion services. | 

## Example

Run with:
```bash
ansible-playbook playbook.yml -i ./site.yml
```

site.yml
```yaml
all:
  hosts:
    192.168.1.10
```

playbook.yml
```yaml
- name: test
  hosts: all
  roles:
  - role: observiq_cloud_agent
    version: "1.3.8"
    secret_key: 00000000-0000-0000-0000-000000000000
```

## Credits

This repository is heavily based on Google's [google-cloud-ops-agents-ansible](https://github.com/GoogleCloudPlatform/google-cloud-ops-agents-ansible)

## License

This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).