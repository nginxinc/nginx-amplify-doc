---
title: NGINX Agent
description: Questions about NGINX Agent
weight: 20
toc: true
tags: ["docs"]
---

### What Operating Systems are Supported?

The agent is currently officially packaged and supported for the following Linux flavors only:

  * Ubuntu 22.04 "jammy" (amd64/arm64)
  * Ubuntu 20.04 "focal" (amd64/arm64)
  * Ubuntu 18.04 "bionic" (amd64/arm64)
  * Debian 11 "bullseye" (amd64/arm64)
  * RHEL/CentOS/OEL 8 (amd64/arm64)
  * RHEL/CentOS/OEL 9 (amd64/arm64)
  * Amazon Linux 2 LTS (amd64/arm64)

The following platforms are no longer supported but still can be used with older agent packages powered by Python 2:

  * Ubuntu 16.04 "xenial" (i386/amd64/arm64)
  * Debian 9 "stretch" (i386/amd64)
  * RHEL/CentOS/OEL 6 (i386/amd64)
  * RHEL/CentOS/OEL 7 (amd64)
  * Amazon Linux (amd64)

Other OS and distributions below are not fully supported yet (and no agent packages are available), however you can grab a specialized install script [here](https://raw.githubusercontent.com/nginxinc/naas-agent/blob/main/packages/install-nginx-agent.sh) and see if it works for you. Run [install-nginx-agent.sh](https://raw.githubusercontent.com/nginxinc/naas-agent/blob/main/packages/install-nginx-agent.sh) (as root) instead of *install.sh* and follow the dialog. You can copy the API key from the Amplify UI (find it in the **Settings** or in the **New System** pop-up).

  * FreeBSD
  * SLES
  * Alpine
  * Fedora

Feel free to [submit](https://github.com/nginx/agent/) an issue or a PR if you find something that has to be fixed.

### How Do I Start to Monitor My Systems with NGINX Amplify?

1. Download and run the install script.

  ```bash
    curl -sS -L -O \
    https://github.com/nginxinc/naas-agent/blob/main/packages/install-nginx-agent.sh && \
    API_KEY='YOUR_API_KEY' sh ./install-nginx-agent.sh
  ```

   where YOUR_API_KEY is a unique API key assigned when you create an account with NGINX Amplify. You can also find the API key in the **Account** menu.

2. Verify that the Agent has started.

   ```bash
   ps ax | grep -i 'nginx-agent'
   3725474 ?        Ssl    0:00 /usr/bin/nginx-agent
   ```

For manual installation, please check the [user guide]({{< relref "/install-manage-nginx-agent/installing-agent#installing-the-agent-manually" >}}).

### What Do I Need to Configure the NGINX Agent to Report Metrics Correctly?

After you install and start the agent, it should start reporting right away, pushing aggregated data to the Amplify backend at regular 1-minute intervals. It'll take about a minute for the new system to appear in the Amplify web interface.

If you don't see the new system or NGINX in the web interface, or (some) metrics aren't being collected, please check the following:

1. The Nginx Agent package has been successfully [installed]({{< relref "/install-manage-nginx-agent" >}}), and no warnings were shown during the installation.

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

We work hard to make the agent consume as little memory and CPU as possible. Usually, it should be under 10% of CPU usage and a few dozen MBs of RSS memory. If you notice any anomalies in the system resource consumption, please fill in a support request through my.f5.com, Instructions for submitting a support case to F5: https://support.f5.com/csp/article/K2633. Please attach the debug log to the support case. 

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

### How Can I Override System Hostname?

If the agent is not able to determine the system's hostname, you can define it manually in **/etc/nginx-agent/nginx-agent.conf**

Find the following section, and fill in the desired hostname:

```nginx
[credentials]
..
hostname = myhostname1
```

The hostname should be valid — the following aren't valid hostnames:

  * localhost
  * localhost.localdomain
  * localhost6.localdomain6
  * ip6-localhost


### Can I Use NGINX Agent with Docker?

Please check the [following section](https://docs.nginx.com/nginx-agent/docker-images/) of the agent repository to find out more. Keep in mind that the support for a Docker environment is currently experimental.
