---
title: NGINX Amplify Agent
description: Questions about NGINX Amplify Agent
weight: 20
toc: true
tags: ["docs"]
docs: "DOCS-958"
---

### What Operating Systems are Supported?

The NGINX Amplify Agent is currently officially packaged and supported for the following Linux flavors only:

  * Ubuntu 22.04 "jammy" (amd64/arm64)
  * Ubuntu 20.04 "focal" (amd64/arm64)
  * Ubuntu 18.04 "bionic" (amd64/arm64)
  * Debian 11 "bullseye" (amd64/arm64)
  * Debian 10 "buster" (amd64/arm64)
  * RHEL/CentOS/OEL 8 (amd64/arm64)
  * RHEL/CentOS/OEL 9 (amd64/arm64)
  * Amazon Linux 2 LTS (amd64/arm64)

The following platforms are no longer supported but still can be used with older agent packages powered by Python 2:

  * Ubuntu 16.04 "xenial" (i386/amd64/arm64)
  * Debian 9 "stretch" (i386/amd64)
  * RHEL/CentOS/OEL 6 (i386/amd64)
  * RHEL/CentOS/OEL 7 (amd64)
  * Amazon Linux (amd64)

Other OS and distributions below are not fully supported yet (and no agent packages are available), however you can grab a specialized install script [here](https://raw.githubusercontent.com/nginxinc/nginx-amplify-agent/master/packages/install-source.sh) and see if it works for you. Run [install-source.sh](https://raw.githubusercontent.com/nginxinc/nginx-amplify-agent/master/packages/install-source.sh) (as root) instead of *install.sh* and follow the dialog. You can copy the API key from the Amplify UI (find it in the **Settings** or in the **New System** pop-up).

  * FreeBSD
  * SLES
  * Alpine
  * Fedora

Feel free to [submit](https://github.com/nginxinc/nginx-amplify-agent/) an issue or a PR if you find something that has to be fixed.

We also have an experimental Ebuild for Gentoo.

### What Version of Python is Required?

NGINX Amplify Agent starting from version 1.8.0, works with Python >= 3.6.

Previous versions were powered by Python 2.6 and 2.7, depending on the target platform.

### How Do I Start to Monitor My Systems with NGINX Amplify?

1. Download and run the install script.

  ```bash
    curl -sS -L -O \
    https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
    API_KEY='YOUR_API_KEY' sh ./install.sh
  ```

   where YOUR_API_KEY is a unique API key assigned when you create an account with NGINX Amplify. You can also find the API key in the **Account** menu.

2. Verify that the Agent has started.

   ```bash
   ps ax | grep -i 'amplify\-'
   2552 ?        S      0:00 amplify-agent
   ```

For manual installation, please check the [user guide]({{< relref "/install-manage-amp-agent/installing-agent#installing-the-agent-manually" >}}).

### What Do I Need to Configure the NGINX Amplify Agent to Report Metrics Correctly?

Once you install NGINX Amplify Agent, it will automatically begin sending metrics. You can expect to see real-time metrics in the Amplify web interface within about a minute.

If you don't see the new system or NGINX in the web interface, or (some) metrics aren't being collected, please check the following:

1. The Amplify Agent package has been successfully [installed]({{< relref "/install-manage-amp-agent" >}}), and no warnings were shown during the installation.

2. The `amplify-agent` process is running and updating its [log file]({{< relref "/install-manage-amp-agent/configuring-agent#agent-logfile" >}}).

3. The agent is running under the same user as your NGINX worker processes.

4. The NGINX instance is started with an absolute path. Currently, the agent **can't** detect NGINX instances launched with a relative path (e.g., "./nginx").

5. The [user ID that is used by the agent and the NGINX ]({{< relref "/install-manage-amp-agent/configuring-agent#overriding-the-effective-user-id" >}}), can run *ps(1)* to see all system processes. If *ps(1)* is restricted for non-privileged users, the agent won't be able to find and properly detect the NGINX master process.

6. The time is set correctly. If the time on the system where the agent runs is ahead or behind the world's clock, you won't be able to see the graphs.

7. *stub_status* is [properly configured]({{< relref "/how-agent-works/configuring-metric-collection" >}}), and the *stub_status module* is included in the NGINX build (this can be checked with `nginx -V`).

8. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) set in NGINX config).

9. All NGINX configuration files are readable by the agent user ID (check owner, group, and permissions).

10. Extra [configuration steps have been performed as required]({{< relref "/metrics-metadata/nginx-metrics#additional-nginx-metrics" >}}) for the additional metrics to be collected.

11. The system DNS resolver is correctly configured, and *receiver.amplify.nginx.com* can be successfully resolved.

12. Outbound TLS/SSL from the system to *receiver.amplify.nginx.com* is not restricted. This can be checked with *curl(1)*. [Configure a proxy server]({{< relref "/install-manage-amp-agent/configuring-agent#setting-up-a-proxy" >}}) for the agent if required.

13. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering with the metric collection. E.g. for *selinux(8)* check **/etc/selinux/config**, try `setenforce 0` temporarily and see if it improves the situation for certain metrics.

14. Some VPS providers use hardened Linux kernels that may restrict non-root users from accessing */proc* and */sys*. Metrics describing system and NGINX disk I/O are usually affected. There is no easy workaround except for allowing the agent to run as `root`. Sometimes fixing permissions for */proc* and */sys/block* may work.

### How Do I Verify that NGINX Amplify Agent Is Correctly Installed?

1. On Ubuntu/Debian use:

   ```bash
   dpkg -s nginx-amplify-agent
   ```

2. On CentOS and Red Hat use:

   ```bash
   yum info nginx-amplify-agent
   ```

### How Can I Update NGINX Amplify Agent?

1. On Ubuntu/Debian use:

   ```bash
   apt-get update && \
   apt-get install nginx-amplify-agent
   ```

2. On CentOS use:

   ```bash
   yum makecache && \
   yum update nginx-amplify-agent
   ```

### What System Resources are Required?

Under 10% of the CPU and a few dozen MBs of RSS memory will be consumed. If you notice any anomalies in the system resource consumption, please submit a support request through https://my.f5.com/, please attach the debug log to the support case.

### How Do I Restart NGINX Amplify Agent?

   ```
   # service amplify-agent restart
   ```

### How Can I Uninstall NGINX Amplify Agent?

Guide to [uninstall Amplify Agent]({{< relref "/install-manage-amp-agent/uninstalling-agent" >}})

### How Can I Override System Hostname?

If the agent is not able to determine the system's hostname, you can define it manually in **/etc/amplify-agent/agent.conf**

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

### How Can I Override the User ID for the Agent to Use?

Refer to the [Configuring the Agent]({{< relref "/install-manage-amp-agent/configuring-agent#overriding-the-effective-user-id" >}}) section in the documentation.

### Can I Use NGINX Amplify Agent with Docker?

Please check the [following section](https://github.com/nginxinc/docker-nginx-amplify) of the agent repository to find out more. Keep in mind that the support for a Docker environment is currently experimental.
