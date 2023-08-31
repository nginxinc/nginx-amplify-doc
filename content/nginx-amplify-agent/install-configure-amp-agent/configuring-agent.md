---
title: Configuring Amplify Agent
description: Learn how to configure the NGINX Agent.
weight: 300
toc: true
tags: ["docs"]
docs: "DOCS-967"
---

NGINX Amplify Agent keeps its configuration in `/etc/amplify-agent/agent.conf`. The agent configuration is a text-based file.

## Overriding the Effective User ID

NGINX Amplify Agent will drop *root* privileges on startup. By default, it will then use the user ID of the user `nginx` to set its effective user ID. The package install procedure will add the `nginx` user automatically unless it's already found in the system. If the [user](http://nginx.org/en/docs/ngx_core_module.html#user) directive appears in the NGINX configuration, the agent will pick up the user specified in the NGINX config for its effective user ID (e.g. `www-data`).

The agent and the running NGINX instances need to use the same user ID for the agent to collect all NGINX metrics properly.

If you would like to manually specify the user ID that the agent should use for its effective user ID, there's a specialized section in `/etc/amplify-agent/agent.conf` for that:

```nginx
[nginx]
user =
configfile = /etc/nginx/nginx.conf
```

The first option allows to explicitly set the real user ID, which the agent should pick for its effective user ID. If the `user` directive has a non-empty parameter, the agent startup script will use it to look up the real user ID.

The second option explicitly tells the agent where to look for an NGINX configuration file suitable for detecting the real user ID, `/etc/nginx/nginx.conf` by default.

## Changing the API Key

When you install the agent for the first time using the procedure above, your API key is written to the `agent.conf` file automatically. If you ever need to change the API key, please edit the following section in `agent.conf` accordingly:

```nginx
[credentials]
api_key = YOUR_API_KEY
```

## Changing the Hostname and UUID

To create unique objects for monitoring, the agent must be able to extract a valid hostname from the system. The hostname is also utilized as one of the components for generating a unique identifier. Essentially, the hostname and the UUID unambiguously identify a particular instance of the agent to the Amplify backend. If the hostname or the UUID are changed, the agent and the backend will register a new object for monitoring.

When first generated, the UUID is written to `agent.conf`. Typically this happens automatically when the agent starts and successfully detects the hostname for the first time. Normally you shouldn't change the UUID in `agent.conf`.

The agent will try its best to determine the correct hostname. If it fails to determine the hostname, you can set the hostname manually in the `agent.conf` file. Check for the following section, and put the desired hostname in here:

```nginx
[credentials]
..
hostname = myhostname1
```

The agent won't start unless a valid hostname is defined. The following *aren't* valid hostnames:

  * localhost
  * localhost.localdomain
  * localhost6.localdomain6
  * ip6-localhost

{{< note >}} You can also use the above method to replace the system's hostname with an arbitrary alias. Remember that if you redefine the hostname for a live object, the existing object will be marked as failed in the web interface. Redefining the hostname in the agent's configuration creates a new UUID and a new system for monitoring. {{< /note >}}

Alternatively, you can define an "alias" for the host in the UI (see the [Graphs]({{< relref "/user-interface/graphs" >}}) section).

## Configuring the URL for stub_status or Status API

When the agent finds a running NGINX instance, it automatically detects the [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) or the NGINX Plus [API module](http://nginx.org/en/docs/http/ngx_http_api_module.html) locations from the NGINX configuration.

To override the *stub_status* URI/URL, use the `stub_status` configuration option.

```nginx
[nginx]
..
stub_status = http://127.0.0.1/nginx_status
```

To override the URI detection of the status API, use the `plus_status` option.

```nginx
[nginx]
..
plus_status = /status
```

{{< note >}}  If only the URI part is specified with the options above, the agent will use `http://127.0.0.1` to construct the full URL to access either the *stub_status* or the NGINX Plus status API metrics. {{< /note >}} 

## Configuring the Path to the NGINX Configuration File

The agent detects the NGINX configuration file *automatically*. You don't need to explicitly point the agent to the nginx `conf` file.

If the agent cannot find the NGINX configuration, use the following option in `/etc/amplify-agent/agent.`conf`:

```nginx
[nginx]
configfile = /etc/nginx/nginx.conf
```

{{< note >}} It is better to avoid using this option and only add it as a workaround. We'd appreciate it if you took some time to fill out a support ticket in case you had to manually add the path to the NGINX config file. {{< /note >}}  

## Configuring Host Tags

You can define arbitrary tags on a "per-host" basis. Tags can be configured in the UI (see the [Graphs]({{< relref "/user-interface/graphs" >}}) documentation), or set in the `/etc/amplify-agent.conf` file:

```nginx
[tags]
tags = foo,bar,foo:bar
```

You can use tags to build custom graphs, configure alerts, and filter the systems on the [Graphs]({{< relref "/user-interface/graphs" >}}) page.

## Configuring Syslog

The agent can collect the NGINX log files via `syslog`. This could be useful when you don't keep the NGINX logs on disk or when monitoring a container environment such as [Docker](https://github.com/nginxinc/docker-nginx-amplify) with NGINX Amplify.

To configure the agent for syslog, add the following to the `/etc/amplify-agent/agent.conf` file:

```nginx
[listeners]
keys = syslog-default

[listener_syslog-default]
address = 127.0.0.1:12000
```

Restart the agent to have it reload the configuration and start listening on the specified IP address and port:

```bash
service amplify-agent restart
```

Make sure to [add the `syslog` settings]({{< relref "/nginx-amplify-agent/install-configure-amp-agent/configuring-agent#configuring-syslog" >}}) to your NGINX configuration as well.

## Excluding Certain NGINX Log Files

By default, the agent will try to find and watch all the `access.log` files described in the NGINX configuration. If there are multiple log files where the same request is logged, the metrics may get counted more than once.

To exclude specific NGINX log files from the metric collection, add an exclusion to the `/etc/amplify-agent/agent.conf` as in the following example:

```nginx
[nginx]
exclude_logs=/var/log/nginx/app1/*,access-app1-*.log,sender1-*.log
```

## Setting Up a Proxy

If your system is in a DMZ environment without direct access to the Internet, the only way for the agent to report collected metrics to Amplify is through a proxy.

The agent will use the usual environment variables common on Linux systems (e.g. `https_proxy` or `HTTP_PROXY`). However, you can also define an HTTPS proxy manually in `agent.conf` file, as in the following example:

```nginx
[proxies]
https = https://10.20.30.40:3030
..
```

## Agent Logfile

The agent maintains its log file in `/var/log/amplify-agent/agent.log`

Upon installation, the agent's log rotation schedule is added to `/etc/logrotate.d/amplify-agent`.

The default level of logging for the agent is `INFO`. If you ever need to debug the agent, change the level to `DEBUG` as described below. The log file size can grow fast when using the `DEBUG` level. After you change the log level, please [restart]({{< relref "/nginx-amplify-agent/install-configure-amp-agent/installing-agent#starting-and-stopping-the-agent" >}}) the agent.

```nginx
[logger_agent-default]
level = DEBUG
..

[handler_agent-default]
class = logging.handlers.WatchedFileHandler
level = DEBUG
..
```
