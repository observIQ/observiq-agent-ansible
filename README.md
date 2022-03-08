Ansible Role For observIQ Cloud Agent
==========================

[![Integration Tests](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/integration.yml/badge.svg)](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/integration.yml)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This Ansible role installs the observIQ OpenTelemetry agent.

Install this directory in your roles path (usually in a `roles` directory
alongside your playbook) under the name `observiq_cloud_agent`:

```bash
git clone https://github.com/observIQ/observiq-agent-ansible.git roles/observiq_cloud_agent 
```

Role Variables
--------------

| Name           | Default Value                        | Description                                                                                                         | 
| -------------- | ------------------------------------ | ------------------------------------------------------------------------------------------------------------------  |
| `version`      | required                             | The `version` is required to specify which version of the agent to install. Supported versions: 2.2.3 or newer.     | 
| `headless`     | `true`                        \      | When true, the agent will not attempt to connect to a remote platform (such as observIQ Cloud).                     |
| `protocol`     | `observiq`                           | The protocol to use when connecting to a platform (`observIQ`, `opamp`).                                            |
| `endpoint`     | `wss://connections.app.observiq.com` | Platform websocket endpoint. Only used when `headless: false`                                                       | 
| `secret_key`   | optional                             | Required when `headless: false`. The `secret_key` is required for connecting to a platform.                         | 
| `template_id`  | optional                             | The `template_id` binds the agent to a configuration template (observiq specific. Requires `protocol: observiq`).   | 
| `agent_id`     | optional                             | The agent ID to use when connecting to a platform. When unset, the platform will assign an ID.                      |
| `labels`       | optional                             | Labels assigned to the agent. When protocol is `opamp`, the platform will push configs that match the given labels. |
| `cacert`       | optional                             | x509 PEM encoded CA certificate, used to trust the platforms certificate. Only required if the platform's certificate authoritity is not already trusted by the operating system. |
| `tlscert`      | optional                             | x509 PEM encoded certificate file path, used for mutual TLS authentication.                                         |
| `tlskey`       | optional                             | x509 PEM encoded private key file path, used for mutual TLS authentication.                                         |


## Examples

`version` is the only required value.

playbook.yml
```yaml
- name: observiq
  hosts: all
  become: yes
  roles:
  - role: observiq_cloud_agent
    version: "2.2.3"
```

Once installed, the collector configuration can be found at `/opt/observiq-agent/config/collector.yaml`.

## Credits

This repository was initially based on Google's [google-cloud-ops-agents-ansible](https://github.com/GoogleCloudPlatform/google-cloud-ops-agents-ansible)

## License

This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).
