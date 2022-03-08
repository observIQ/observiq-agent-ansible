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

### observIQ Cloud w/ Template

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
    version: "2.2.3"
    secret_key: 00000000-0000-0000-0000-000000000000
    template_id: 00000000-0000-0000-0000-000000000000
```

### OpenTelemetry OpAMP platform

observIQ Agent supports [OpAmp](https://github.com/open-telemetry/opamp-spec) as of version 2.2.3.
This example assumes an OpAmp compliant server is available on the agent system and port 3001.

playbook.yml
```yaml
- name: observiq
  hosts: all
  become: yes
  roles:
  - role: observiq_cloud_agent
    version: "2.2.3"
    secret_key: 00000000-0000-0000-0000-000000000000
    endpoint: ws://localhost:3001
    protocol: opamp
```

### OpenTelemetry OpAMP w/ Mutual TLS

Same as the "OpenTelemetry OpAMP platform" example, except the agent will authenticate
with the platform using mTLS.

playbook.yml
```yaml
- name: observiq
  hosts: all
  become: yes
  roles:
  - role: observiq_cloud_agent
    version: "2.2.3"
    secret_key: 00000000-0000-0000-0000-000000000000
    endpoint: wss://localhost:3001
    protocol: opamp
    cacert: /opt/tls/ca.crt
    tlscert: /opt/tls/agent.crt
    tlskey: /opt/tls/agent.key
```
