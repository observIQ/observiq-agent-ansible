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
  become: yes
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
  become: yes
  roles:
  - role: observiq_cloud_agent
    version: "1.3.11"
    secret_key: 00000000-0000-0000-0000-000000000000
    template_id: 00000000-0000-0000-0000-000000000000
```