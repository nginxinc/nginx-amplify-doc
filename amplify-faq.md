<!-- menu -->

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. General](#1-general)
  - [1.1. What Is NGINX Amplify?](#11-what-is-nginx-amplify)
  - [1.2. Where Is NGINX Amplify Hosted?](#12-where-is-nginx-amplify-hosted)
  - [1.3. Is the NGINX Amplify Agent Traffic Protected?](#13-is-the-nginx-amplify-agent-traffic-protected)
  - [1.4. Is the NGINX Amplify Agent Code Publicly Available?](#14-is-the-nginx-amplify-agent-code-publicly-available)
  - [1.5. What is This Question About My Password When Installing NGINX Amplify Agent?](#15-what-is-this-question-about-my-password-when-installing-nginx-amplify-agent)
- [2. NGINX Amplify Agent](#2-nginx-amplify-agent)
  - [2.1. What Operating Systems are Supported?](#21-what-operating-systems-are-supported)
  - [2.2. What Version of Python is Required?](#22-what-version-of-python-is-required)
  - [2.3. How Do I Start to Monitor My Systems with NGINX Amplify?](#23-how-do-i-start-to-monitor-my-systems-with-nginx-amplify)
  - [2.4. What Do I Need to Configure the NGINX Amplify Agent to Properly Report Metrics?](#24-what-do-i-need-to-configure-the-nginx-amplify-agent-to-properly-report-metrics)
  - [2.5. How Do I Verify that NGINX Amplify Agent Is Correctly Installed?](#25-how-do-i-verify-that-nginx-amplify-agent-is-correctly-installed)
  - [2.6. How Can I Update NGINX Amplify Agent?](#26-how-can-i-update-nginx-amplify-agent)
  - [2.7. What System Resources are Required?](#27-what-system-resources-are-required)
  - [2.8. How Do I Restart NGINX Amplify Agent?](#28-how-do-i-restart-nginx-amplify-agent)
  - [2.9. How Can I Uninstall NGINX Amplify Agent?](#29-how-can-i-uninstall-nginx-amplify-agent)
  - [2.10. How Can I Override System Hostname?](#210-how-can-i-override-system-hostname)
  - [2.11. How Can I Override the User ID for the Agent to Use?](#211-how-can-i-override-the-user-id-for-the-agent-to-use)
  - [2.12. Can I Use NGINX Amplify Agent with Docker?](#212-can-i-use-nginx-amplify-agent-with-docker)
- [3. NGINX Amplify User Interface](#3-nginx-amplify-user-interface)
  - [3.1. What Browsers are Supported?](#31-what-browsers-are-supported)
  - [3.2. Is the Traffic to the Web Interface Secure?](#32-is-the-traffic-to-the-web-interface-secure)
  - [3.3. How Can I Delete a System or an NGINX Instance from NGINX Amplify?](#33-how-can-i-delete-a-system-or-an-nginx-instance-from-nginx-amplify)
- [4. NGINX Amplify Metrics and Metadata](#4-nginx-amplify-metrics-and-metadata)
  - [4.1. What Metrics and Metadata are Collected?](#41-what-metrics-and-metadata-are-collected)
  - [4.2. How Is the NGINX Configuration Parsed and Analyzed?](#42-how-is-the-nginx-configuration-parsed-and-analyzed)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

<!-- /menu -->

<!-- section:1 -->

## 1. General

### 1.1. What Is NGINX Amplify?

NGINX Amplify is a tool for comprehensive NGINX monitoring. With NGINX Amplify it's easy to proactively analyze and fix problems related to running and scaling NGINX-based web applications.

You can use NGINX Amplify to do the following:

  * Visualize and identify NGINX performance bottlenecks, overloaded servers, or potential DDoS attacks
  * Improve and optimize NGINX performance with intelligent advice and recommendations
  * Get notified when something is wrong with the application infrastructure
  * Plan web application capacity and performance
  * Keep track of the systems running NGINX

### 1.2. Where Is NGINX Amplify Hosted?

NGINX Amplify is a SaaS and it is currently hosted in [AWS us-west-1](http://docs.aws.amazon.com/general/latest/gr/rande.html) (US West, N. California).

### 1.3. Is the NGINX Amplify Agent Traffic Protected?

All communications between the agent and the backend are done securely over SSL/TLS. All traffic is always initiated by the agent. The backend system doesn't set up any connections back to the agent.

### 1.4. Is the NGINX Amplify Agent Code Publicly Available?

NGINX Amplify Agent is an open source application. It is licensed under the [2-clause BSD license](https://github.com/nginxinc/nginx-amplify-agent/blob/master/LICENSE), and is available [here](https://github.com/nginxinc/nginx-amplify-agent).

### 1.5. What is This Question About My Password When Installing NGINX Amplify Agent?

It could be that you're starting the install script from a non-root account. In this case you will need *sudo* rights. While it depends on a particular system configuration, with a non-root account *sudo* will typically ask for a password.

<!-- /section:1 -->

<!-- section:2 -->

## 2. NGINX Amplify Agent

### 2.1. What Operating Systems are Supported?

The agent is currently officially packaged and supported for the following Linux flavors only:

  * Ubuntu 22.04 "jammy" (amd64/arm64)
  * Ubuntu 20.04 "focal" (amd64/arm64)
  * Ubuntu 18.04 "bionic" (amd64/arm64)
  * Debian 11 "bullseye" (amd64/arm64)
  * Debian 10 "buster" (amd64/arm64)
  * RHEL/CentOS/OEL 8 (amd64/arm64)
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

### 2.2. What Version of Python is Required?

NGINX Amplify Agent starting from version 1.8.0 works with Python >= 3.6.

Previous versions were powered by Python 2.6 and 2.7 depending on the target platform.

### 2.3. How Do I Start to Monitor My Systems with NGINX Amplify?

<!-- advancedList -->

  1. Download and run the install script.

  ```
  # curl -sS -L -O \
  https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
  API_KEY='YOUR_API_KEY' sh ./install.sh
  ```

  where YOUR_API_KEY is a unique API key assigned when you create an account with NGINX Amplify. You can also find the API key in the **Account** menu.

  2. Verify that the Agent has started.

  ```
  # ps ax | grep -i 'amplify\-'
  2552 ?        S      0:00 amplify-agent
  ```

For manual installation, please check the user guide [here](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#installing-the-agent-manually).

### 2.4. What Do I Need to Configure the NGINX Amplify Agent to Properly Report Metrics?

After you install and start the agent, normally it should just start reporting right away, pushing aggregated data to the Amplify backend at regular 1 minute intervals. It'll take about a minute for the new system to appear in the Amplify web interface.

If you don't see the new system or NGINX in the web interface, or (some) metrics aren't being collected, please check the following:

  1. The Amplify Agent package has been successfully [installed](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#installing-and-managing-nginx-amplify-agent), and no warnings were seen upon the installation.
  2. The `amplify-agent` process is running and updating its [log file](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#agent-logfile).
  3. The agent is running under the same user as your NGINX worker processes.
  4. The NGINX is started with an absolute path. Currently the agent **can't** detect NGINX instances launched with a relative path (e.g. "./nginx").
  5. The [user ID that is used by the agent and the NGINX ](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#overriding-the-effective-user-id), can run *ps(1)* to see all system processes. If *ps(1)* is restricted for non-privileged users, the agent won't be able to find and properly detect the NGINX master process.
  6. The time is set correctly. If the time on the system where the agent runs is ahead or behind the world's clock, you won't be able to see the graphs.
  7. *stub_status* is [properly configured](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#configuring-nginx-for-metric-collection), and the *stub_status module* is included in the NGINX build (this can be checked with `nginx -V`).
  8. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) set in NGINX config).
  9. All NGINX configuration files are readable by the agent user ID (check owner, group and permissions).
  10. Extra [configuration steps have been performed as required](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#additional-nginx-metrics) for the additional metrics to be collected.
  11. The system DNS resolver is correctly configured, and *receiver.amplify.nginx.com* can be successfully resolved.
  12. Oubound TLS/SSL from the system to *receiver.amplify.nginx.com* is not restricted. This can be checked with *curl(1)*. [Configure a proxy server](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#setting-up-a-proxy) for the agent if required.
  13. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering with the metric collection. E.g. for *selinux(8)* check **/etc/selinux/config**, try `setenforce 0` temporarily and see if it improves the situation for certain metrics.
  14. Some VPS providers use hardened Linux kernels that may restrict non-root users from accessing */proc* and */sys*. Metrics describing system and NGINX disk I/O are usually affected. There is no an easy workaround for this except for allowing the agent to run as `root`. Sometimes fixing permissions for */proc* and */sys/block* may work.

### 2.5. How Do I Verify that NGINX Amplify Agent Is Correctly Installed?

<!-- advancedList -->

  1. On Ubuntu/Debian use:

  ```
  # dpkg -s nginx-amplify-agent
  ```

  2. On CentOS and Red Hat use:

  ```
  # yum info nginx-amplify-agent
  ```

### 2.6. How Can I Update NGINX Amplify Agent?

<!-- advancedList -->

  1. On Ubuntu/Debian use:

  ```
  # apt-get update && \
  apt-get install nginx-amplify-agent
  ```

  2. On CentOS use:

  ```
  # yum makecache && \
  yum update nginx-amplify-agent
  ```

### 2.7. What System Resources are Required?

We work very hard to make the agent consume as little memory and CPU as possible. Normally it should be under 10% of CPU usage and a few dozen MBs of RSS memory. If you notice any anomalies in the system resource consumption, please create an issue at [nginx-amplify-agent](https://github.com/nginxinc/nginx-amplify-agent/issues) repo.

### 2.8. How Do I Restart NGINX Amplify Agent?

It's as simple as

```
# service amplify-agent restart
```

### 2.9. How Can I Uninstall NGINX Amplify Agent?

<!-- advancedList -->

  1. On Ubuntu/Debian use:

  ```
  apt-get remove nginx-amplify-agent
  ```

  2. On CentOS and Red Hat use:

  ```
  yum remove nginx-amplify-agent
  ```

### 2.10. How Can I Override System Hostname?

If the agent is not able to determine the system's hostname, you can define it manually in **/etc/amplify-agent/agent.conf**

Check for the following section, and fill in the desired hostname:

```
[credentials]
..
hostname = myhostname1
```

The hostname should be something real — the following aren't valid hostnames:

  * localhost
  * localhost.localdomain
  * localhost6.localdomain6
  * ip6-localhost

### 2.11. How Can I Override the User ID for the Agent to Use?

Please check the following [section](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#overriding-the-effective-user-id) of the NGINX Amplify public documentation.

### 2.12. Can I Use NGINX Amplify Agent with Docker?

Although the support for a Docker environment is currently experimental, in general the answer is yes. Please check the following part of the agent repository to find out [more](https://github.com/nginxinc/docker-nginx-amplify).

<!-- /section:2 -->

<!-- section:3 -->

## 3. NGINX Amplify User Interface

### 3.1. What Browsers are Supported?

Currently the following desktop browsers are officially supported:

  * Chrome
  * Firefox
  * Safari
  * Opera

### 3.2. Is the Traffic to the Web Interface Secure?

We only support SSL/TLS connections to the Amplify web interface.

### 3.3. How Can I Delete a System or an NGINX Instance from NGINX Amplify?

If the goal is to completely delete a previously monitored object, then do the following:

  1. Uninstall the agent
  2. Delete objects from the web interface
  3. Delete alarms

To delete a system using the web interface — find it in the [Inventory](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#inventory), and choose the [i] icon. You can delete objects from the popup window that appears next.

Bear in mind — deleting objects there will not stop the agent. To completely remove a system from monitoring, please stop or uninstall the agent first, and then clean it up in the web interface. Don't forget to also clean up any alerts.

<!-- /section:3 -->

<!-- section:4 -->

## 4. NGINX Amplify Metrics and Metadata

### 4.1. What Metrics and Metadata are Collected?

NGINX Amplify Agent collects the following types of data:

  * **NGINX metrics.** The agent collects a lot of NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), the NGINX Plus status API, the NGINX log files, and from the NGINX process state.
  * **System metrics.** These are various key metrics describing the system, e.g. CPU usage, memory usage, network traffic, etc.
  * **PHP-FPM metrics.** The agent can obtain metrics from the PHP-FPM pool status, if it detects a running PHP-FPM master process.
  * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, the path to the binary, build configuration options, etc. NGINX metadata also includes the NGINX configuration elements.
  * **System metadata.** This is the basic information about the OS environment where the agent runs. This could be the hostname, uptime, OS flavor, and other data.

The agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the metrics, but occasionally it may also invoke certain system utilities like *ps(1)*.

To see the full list of metrics, please check the documentation [here](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#metrics-and-metadata).

### 4.2. How Is the NGINX Configuration Parsed and Analyzed?

The agent is able to automatically find all relevant NGINX configuration files, parse them, extract their logical structure, and send the associated JSON data to the Amplify backend for further analysis and reporting.

To parse SSL certificate metadata the Amplify Agent uses standard openssl(1) functions. SSL certificates are parsed and analyzed only when the corresponding [settings](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#account-settings) are turned on. SSL certificate analysis is *off* by default.

The agent DOES NOT ever send the raw unprocessed config files to the backend system. In addition, the following directives in the NGINX configuration are NOT analyzed — and their parameters ARE NOT exported to the SaaS backend:
[ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key), [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate), [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file), [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file), [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate), [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file), [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret).

For more information on configuration analysis and reports see the [NGINX Amplify documentation](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#analyzer).

<!-- /section:4 -->