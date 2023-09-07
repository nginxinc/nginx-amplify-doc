---
title: Configure NGINX Agent
description: Learn how to configure the NGINX Agent.
weight: 400
toc: true
tags: ["docs"]
---

The NGINX Agent stores its settings in `/etc/nginx-agent/nginx-agent.conf`, which is a YAML file.

## Changing the API Key

If you've followed the [NGINX Agent installation guide]({{< relref "/nginx-agent/install/installing-nginx-agent#using-the-install-script" >}}), your API key should already be in the `nginx-agent.conf` file. To change your API key later, edit this section in `nginx-agent.conf`:

```yaml
server:
   token: <YOUR_API_KEY>
```

## Excluding Specific NGINX Log Files

By default, NGINX Agent scans all `access.log` files listed in the NGINX configuration. If some log files record the same request, metrics might get counted more than once.

To avoid this, you can specify which log files to exclude in `/etc/nginx-agent/agent.conf` like this:

```yaml
nginx:
   exclude_logs: ""
```

## NGINX Agent Log File

NGINX Agent keeps its logs in `/var/log/nginx-agent/agent.log` and automatically adds a log rotation schedule to `/etc/logrotate.d/nginx-agent`.

The default log level is `INFO`. If you need to debug NGINX Agent, switch the log level to `DEBUG`. But be cautious: the log file can grow quickly at this level. After updating the log level, make sure to [restart NGINX Agent]({{< relref "/nginx-agent/install/installing-nginx-agent#starting-and-stopping-the-agent" >}}).

```yaml
log:
   level: debug
```
