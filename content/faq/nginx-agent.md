---
title: NGINX Agent
description: Questions about NGINX Agent
weight: 20
toc: true
tags: ["docs"]
---

### What Operating Systems are Supported?

The NGINX Agent is officially packaged and supported only for the following Linux flavors:

  * Ubuntu 22.04 "jammy" (amd64/arm64)
  * Ubuntu 20.04 "focal" (amd64/arm64)
  * Ubuntu 18.04 "bionic" (amd64/arm64)
  * Debian 11 "bullseye" (amd64/arm64)
  * RHEL/CentOS/OEL 8 (amd64/arm64)
  * RHEL/CentOS/OEL 9 (amd64/arm64)
  * Amazon Linux 2 LTS (amd64/arm64)

If you find something that needs fixing, you're welcome to [submit a PR](https://github.com/nginx/agent/) for the issue.

### How Do I Start to Monitor My Systems with NGINX Amplify?

1. Download and run the install script.

   ```bash
   curl -sS -L -O \
   https://github.com/nginxinc/naas-agent/blob/main/packages/install-nginx-agent.sh && \
   API_KEY='YOUR_API_KEY' sh ./install-nginx-agent.sh
   ```

   where YOUR_API_KEY is a unique API key assigned when you create an account with NGINX Amplify. You can also find the API key in the **Account** menu.

2. Verify that the NGINX Agent has started.

   ```bash
   ps ax | grep -i 'nginx-agent'
   3725474 ?        Ssl    0:00 /usr/bin/nginx-agent
   ```

For manual installation, refer to the [user guide]({{< relref "/install-manage-nginx-agent/installing-agent#installing-the-agent-manually" >}}).

### What Do I Need to Configure the NGINX Agent to Report Metrics Correctly?

Once you install and launch NGINX Agent, it will immediately begin reporting, sending aggregated data to NGINX Amplify services every minute. Expect the new system to show up in the Amplify web interface within about a minute.

If the new system or NGINX doesn't appear in the web interface, or if some metrics are missing, refer to the following steps:

1. The NGINX Agent package has been successfully [installed]({{< relref "/install-manage-nginx-agent" >}}), and no warnings were shown during the installation.

2. The `nginx-agent` process is running and updating its [log file]({{< relref "/install-manage-nginx-agent/configuring-agent#agent-logfile" >}}).

3. The agent is running under the same user as your NGINX worker processes.

4. The NGINX instance is started with an absolute path. Currently, the agent **can't** detect NGINX instances launched with a relative path (e.g., "./nginx").

5. The time is set correctly. If the time on the system where the agent runs is ahead or behind the world's clock, you won't be able to see the graphs.

6. *stub_status* is [properly configured]({{< relref "/how-agent-works/configuring-metric-collection" >}}), and the *stub_status module* is included in the NGINX build (this can be checked with `nginx -V`).

7. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) set in NGINX config).

8. All NGINX configuration files are readable by the agent user ID (check owner, group, and permissions).

9. The system DNS resolver is correctly configured, and *receiver-grpc.amplify.nginx.com* can be successfully resolved.

10. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering with the metric collection. E.g. for *selinux(8)* check **/etc/selinux/config**, try `setenforce 0` temporarily and see if it improves the situation for certain metrics.

11. Some VPS providers use hardened Linux kernels that may restrict non-root users from accessing */proc* and */sys*. Metrics describing system and NGINX disk I/O are usually affected. There is no easy workaround except for allowing the agent to run as `root`. Sometimes fixing permissions for */proc* and */sys/block* may work.

### How Do I Verify that NGINX Agent Is Correctly Installed?

1. On Ubuntu/Debian use:

   ```bash
   dpkg -s nginx-agent
   ```

2. On CentOS and Red Hat use:

   ```bash
   yum info nginx-agent
   ```

### How Can I Update NGINX Agent?

1. On Ubuntu/Debian use:

   ```bash
   apt-get update && \
   apt-get install nginx-agent
   ```

2. On CentOS use:

   ```bash
   yum makecache && \
   yum update nginx-agent
   ```

### What System Resources are Required?

Expect to use under 10% of the CPU and a few dozen MBs of RSS memory. If you notice any unusual resource consumption, submit a support ticket through Intercom.

### How Do I Restart NGINX Agent?

   ```
   # service nginx-agent restart
   ```

### How Can I Uninstall NGINX Agent?

1. On Ubuntu/Debian use:

   ```bash
   apt-get remove nginx-agent
   ```

2. On CentOS and Red Hat use:

   ```bash
   yum remove nginx-agent
   ```


### Can I Use NGINX Agent with Docker?

For details, refer to the [Docker Images](https://docs.nginx.com/nginx-agent/docker-images/) topic in the NGINX Agent documentation. Note that Docker environment support is currently experimental.
