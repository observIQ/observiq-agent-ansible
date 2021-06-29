Ansible Role For observIQ Cloud Agent
==========================

[![Ansible Lint](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/lint.yml/badge.svg)](https://github.com/observIQ/observiq-agent-ansible/actions/workflows/lint.yml)
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
| `install_dir`                    | `/opt/observiq-agent`                 | The directory the agent should be installed in. | 
| `service_user`                   | `root`                                | The runtime username. Root is required if your agent configuration requires listening on a privileged network port. The playbook will not create this user. | 
| `service_name`                   | `observiq-agent`                      | The service name used for managing the agent. | 
| `websocket_connection_endpoint`  | `wss://connections.app.observiq.com`  | The websocket endpoint used to connect to observIQ Cloud's management interface, this should never be changed. | 
| `version`                        | required                              | The `version` is required to specify which version of the agent to install. Supported versions: 1.3.11 or newer. | 
| `secret_key`                     | required                              | The `secret_key` is required for connecting to observIQ Cloud's management and ingestion services. | 
| `template_id`                    | optional                              | The `template_id` optionally install the agent and bind it to an observIQ cloud template. | 

## Examples

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

### Required Values

`version` and `secret_key` are the only required values.

playbook.yml
```yaml
- name: observiq
  hosts: all
  roles:
  - role: observiq_cloud_agent
    version: "1.3.11"
    secret_key: 00000000-0000-0000-0000-000000000000
```

### Template

You can install an agent using an observIQ cloud template, which will install log
sources automatically. This can be useful for deployments at scale with identical
log configurations.

playbook.yml
```yaml
- name: observiq
  hosts: all
  roles:
  - role: observiq_cloud_agent
    version: "1.3.11"
    secret_key: 00000000-0000-0000-0000-000000000000
    template_id: 00000000-0000-0000-0000-000000000000
```

## Developing

### Testing

#### Setup

Install [Gcloud SDK](https://cloud.google.com/sdk/docs/install)

Install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html), [Molecule](https://molecule.readthedocs.io/en/latest/installation.html), [Molecule GCE driver](https://github.com/ansible-community/molecule-gce), and dependencies.
```bash
# Pip3
pip install -r requirements.txt
export PATH=~/.local/bin:$PATH
```

Configure Project SSH
1. `gcloud compute project-info add-metadata --metadata enable-oslogin=TRUE`

Google Cloud Service Account
1. Create a GCP service account with the following roles:
  - Compute Admin
  - Compute OS Admin Login
  - Service Account User
2. Create and download the service accounts json key
3. Create ssh keypair for service account
  - `ssh-keygen -f ssh-key-ansible-sa`
4. Authenticate as the service account and bind the ssh keypair
  - `gcloud auth activate-service-account --key-file=<pat to service account json key`
  - `gcloud compute os-login ssh-keys add --key-file=ssh-key-ansible-sa.pub`


Export the following environment variables using a `.env` file in the repo's root directory:
```
export PROJECT=<google cloud project id>
export SSH_KEY_FILE=<path to private key file created by gcloud compute config-ssh>
export SSH_USER=<your gcloud ssh username>
export GOOGLE_APPLICATION_CREDENTIALS=<path to google application credentials>
export OIQ_SECRET_KEY=<observiq secret key>
```

Make sure [gcloud ssh is configured](https://cloud.google.com/sdk/gcloud/reference/compute/config-ssh?hl=zh-tw)

#### Run Tests Locally

Local testing will use the service account for instance deployment and your personal 
account for ssh and executing ansible.

- molecule create
- molecule converge
- molecule idempotence
- molecule verify
- molecule destroy

## Credits

This repository was initially based on Google's [google-cloud-ops-agents-ansible](https://github.com/GoogleCloudPlatform/google-cloud-ops-agents-ansible)

## License

This library is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).