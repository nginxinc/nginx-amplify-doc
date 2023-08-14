---
title: Configuring the Agent
description: Learn how to configure the NGINX Agent.
weight: 300
toc: true
tags: ["docs"]
---

NGINX Agent keeps its configuration in `/etc/nginx-agent/nginx-agent.conf`. The agent configuration is a yaml file.

## Changing the API Key

After following the documented [install procedures]({{< relref "/install-manage-nginx-agent/installing-agent#using-the-install-script" >}}) your API key is written to the `nginx-agent.conf` file automatically. If you ever need to change the API key, please edit the following section in `nginx-agent.conf` accordingly:

```yaml
server:
   token: <YOUR_API_KEY>
```

## Excluding Certain NGINX Log Files

By default, the agent will try to find and watch all the `access.log` files described in the NGINX configuration. If there are multiple log files where the same request is logged, the metrics may get counted more than once.
<!-- Need to confirm if metrics getting counted twice is a problem in nginx agent too. -->

To exclude specific NGINX log files from the metric collection, add an exclusion to the `/etc/nginx-agent/agent.conf` as in the following example:

```yaml
nginx:
   exclude_logs: ""
```

## Agent Logfile

The agent maintains its log file in `/var/log/nginx-agent/agent.log`.
Upon installation, the agent's log rotation schedule is added to `/etc/logrotate.d/nginx-agent`.

The default level of logging for the agent is `INFO`. If you ever need to debug the agent, change the level to `DEBUG` as described below. The log file size can grow fast when using the `DEBUG` level. After you change the log level, please [restart]({{< relref "/install-manage-amp-agent/installing-agent#starting-and-stopping-the-agent" >}}) the agent.

```yaml
log:
   level: debug
```
