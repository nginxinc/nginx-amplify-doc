<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. General](#1-general)
  - [1.1. What Is NGINX Amplify?](#11-what-is-nginx-amplify)
  - [1.3. Is the Traffic from the Agent to the SaaS Protected?](#13-is-the-traffic-from-the-agent-to-the-saas-protected)
  - [1.4. Is the Amplify Agent Code Publicly Available?](#14-is-the-amplify-agent-code-publicly-available)
  - [1.5. What is This Question About My Password When Installing the Agent?](#15-what-is-this-question-about-my-password-when-installing-the-agent)
- [2. NGINX Amplify Agent](#2-nginx-amplify-agent)
  - [2.1. What Operating Systems Are Supported?](#21-what-operating-systems-are-supported)
  - [2.2. What Version of Python is Required?](#22-what-version-of-python-is-required)
  - [2.3. How Do I Activate Monitoring for a System?](#23-how-do-i-activate-monitoring-for-a-system)
  - [2.4. What Do I Need to Configure for the Amplify Agent to Properly Report Metrics?](#24-what-do-i-need-to-configure-for-the-amplify-agent-to-properly-report-metrics)
  - [2.5. How Do I Verify that the Amplify Agent Is Correctly Installed?](#25-how-do-i-verify-that-the-amplify-agent-is-correctly-installed)
  - [2.6. How Can I Update the Amplify Agent?](#26-how-can-i-update-the-amplify-agent)
  - [2.7. What System Resources Are Required?](#27-what-system-resources-are-required)
  - [2.8. How Do I Restart the Amplify Agent?](#28-how-do-i-restart-the-amplify-agent)
  - [2.9. How Can I Uninstall the Amplify Agent?](#29-how-can-i-uninstall-the-amplify-agent)
  - [2.10. How Can I Override a System's Hostname?](#210-how-can-i-override-a-systems-hostname)
  - [2.11. Can I Use Amplify Agent with Docker?](#211-can-i-use-amplify-agent-with-docker)
- [3. User Interface](#3-user-interface)
  - [3.1. What Browsers are Supported?](#31-what-browsers-are-supported)
  - [3.2. Is the Web Interface Traffic Secure?](#32-is-the-web-interface-traffic-secure)
  - [3.3. How Can I Delete a System or an NGINX Instance from Monitoring?](#33-how-can-i-delete-a-system-or-an-nginx-instance-from-monitoring)
- [4. Metrics and Metadata](#4-metrics-and-metadata)
  - [4.1. What Metrics and Metadata Are Collected?](#41-what-metrics-and-metadata-are-collected)
  - [4.2. How Is the NGINX Configuration Parsed and Analyzed?](#42-how-is-the-nginx-configuration-parsed-and-analyzed)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. General

### 1.1. What Is NGINX Amplify?

NGINX Amplify is a tool for comprehensive NGINX monitoring. With Amplify it becomes possible to proactively analyze and fix problems related to running and scaling NGINX-based web application architectures.

You can use NGINX Amplify to do the following:

 * Visualize and identify NGINX performance bottlenecks, overloaded servers, or potential DDoS attacks
 * Improve and optimize NGINX performance with intelligent advice and recommendations
 * Get notified when something is wrong with application delivery
 * Plan web application capacity and performance
 * Keep track of the systems running NGINX
 
### 1.2. Where Is the Main System Hosted?

NGINX Amplify SaaS is currently hosted in [AWS us-west-1](http://docs.aws.amazon.com/general/latest/gr/rande.html) (US West, N. California).

### 1.3. Is the Traffic from the Agent to the SaaS Protected?

All communications between the Amplify Agent and the Amplify SaaS backend are done securely over SSL/TLS. All traffic is always initiated by the agent. The backend system doesn't set up any connections back to the agent.

### 1.4. Is the Amplify Agent Code Publicly Available?

Amplify Agent is an open source application. It is licensed under the [2-clause BSD license](https://github.com/nginxinc/nginx-amplify-agent/blob/master/LICENSE), and is available [here](https://github.com/nginxinc/nginx-amplify-agent).

### 1.5. What is This Question About My Password When Installing the Agent?

It could be that you're starting the install script from a non-root account. In this case you will need *sudo* rights. While it depends on a particular system configuration, with a non-root account *sudo* will typically ask for a password.


## 2. NGINX Amplify Agent

### 2.1. What Operating Systems Are Supported?

NGINX Amplify Agent currently works on the following Linux flavors only:

 * Ubuntu 12.04, 14.04, 15.10
 * Debian 7, 8
 * CentOS 6, 7
 * Red Hat 6, 7 (and systems based on it, e.g. Oracle Server)
 * Amazon Linux (latest release)
 * Gentoo Linux (experimental Ebuild)

### 2.2. What Version of Python is Required?

NGINX Amplify Agent will work with Python 2.6+.

### 2.3. How Do I Activate Monitoring for a System?

 1. Download and run the install script.

        # curl -sS -L -O \
        https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
        API_KEY='ecfdee2e010899135c258d741a6effc7' sh ./install.sh

    where API_KEY is a unique API key assigned when you create an account with Amplify. You can also find the API key in the **Account Information** menu.

 2. Verify that Amplify Agent has started.

        # ps ax | grep -i 'amplify\-'
        2552 ?        S      0:00 amplify-agent

For manual installation instructions, please check the user guide [here](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#installing-amplify-agent-manually).

### 2.4. What Do I Need to Configure for the Amplify Agent to Properly Report Metrics?

After you install and start the agent, normally it should just start reporting right away, pushing aggregated data to the Amplify backend at regular 1 minute intervals. It'll take about a minute for the new system to appear in the Amplify web interface.

If you don't see the new system in the web interface, or metrics aren't being collected, please check the following:

 1. The Amplify Agent package has been successfully installed.
 2. The `amplify-agent` process is running.
 3. stub_status is [properly set up](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#configuring-nginx-for-amplify-metric-collection) in your NGINX configuration.
 4. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) configured in NGINX config).
 5. Extra [configuration steps](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#additional-nginx-metrics) have been performed as required for the additional metrics to be collected.
 6. The system DNS resolver is properly configured, and `receiver.amplify.nginx.com` can be successfully resolved.
 7. Oubound TLS/SSL from the system to `receiver.amplify.nginx.com` is not restricted.
 8. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering. E.g. for *selinux(8)* check `/etc/selinux/config`, try `setenforce 0` temporarily and see if it improves the situation for certain metrics. Some VPS providers use hardened Linux kernels that may restrict metric collection.

### 2.5. How Do I Verify that the Amplify Agent Is Correctly Installed?

 1. On Ubuntu/Debian use:

```
    # dpkg -s nginx-amplify-agent
```

 2. On CentOS and Red Hat use:

```
    # yum info nginx-amplify-agent
```

### 2.6. How Can I Update the Amplify Agent?

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

### 2.7. What System Resources Are Required?

We worked very hard to make the agent consume as little memory and CPU as possible. Normally it shouldn't be more than a few % of CPU time and around 25–30MB of RSS memory. If you notice any anomalies in the system resource consumption, please fill in a support ticket through Intercom.
   
### 2.8. How Do I Restart the Amplify Agent?

It's as simple as

```
    # service amplify-agent restart
```

### 2.9. How Can I Uninstall the Amplify Agent?

 1. On Ubuntu/Debian use:

```
    apt-get remove nginx-amplify-agent
```

 2. On CentOS and Red Hat use:

```
    yum remove nginx-amplify-agent
```

### 2.10. How Can I Override a System's Hostname?
 
If the agent is not able to determine the system's hostname, you can define it manually in **/etc/amplify-agent/agent.conf**

Check for the following section, and fill in the desired hostname:

```
    [credentials]
    ..
    hostname = myhostname1
```

The hostname should be something real—the following aren't valid hostnames:

 * localhost
 * localhost.localdomain
 * localhost6.localdomain6
 * ip6-localhost

### 2.11. Can I Use Amplify Agent with Docker?

Although the support for a Docker environment is currently somewhat limited, in general the answer is yes, you can. Please check the following part of the Amplify Agent repository to find out [more](https://github.com/nginxinc/nginx-amplify-agent/tree/master/packages/docker).

## 3. User Interface

### 3.1. What Browsers are Supported?

Currently the following desktop browsers are fully supported:

 * Chrome
 * Firefox
 * Safari
 * Opera

### 3.2. Is the Web Interface Traffic Secure?

We only support SSL/TLS connections to the Amplify web interface.

### 3.3. How Can I Delete a System or an NGINX Instance from Monitoring?

If the goal is to completely delete a previously monitored object, then do the following:

 1. Uninstall the agent
 2. Delete objects from the web interface
 3. Delete alarms

To delete a system using the web interface—find it in the list on the left, hover, click the vertical dots on the right, extend the toolbar and choose the [i] icon. You can delete objects from the popup window that appears next.

Bear in mind—deleting objects there will not stop the agent. To completely remove a system from monitoring, please stop or uninstall the agent first, and then clean it up in the web interface. Don't forget to also clean up any alarms.


## 4. Metrics and Metadata

### 4.1. What Metrics and Metadata Are Collected?

NGINX Amplify Agent collects the following types of data:

 * **System metadata.** This is basic information about the OS environment where the agent runs. This could be the hostname, uptime information, OS flavor, and other data.
 * **System metrics.** This is various data describing key system characteristics, e.g. CPU usage, memory usage, network traffic, etc.
 * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, the path to the binary, build configuration options, etc. NGINX metadata also includes the NGINX configuration elements.
 * **NGINX metrics.** Amplify Agent collects NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), and also from the NGINX log files.

Amplify Agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the data, but may occasionally invoke certain system utilities like *ps(1)*.

### 4.2. How Is the NGINX Configuration Parsed and Analyzed?

Amplify Agent is able to automatically find all relevant NGINX configuration files, parse them, extract their logical structure, and send the associated JSON data to the Amplify backend for further analysis and reporting.

To parse SSL certificate metadata the Amplify Agent uses standard openssl(1) functions. SSL certificates are parsed and analyzed only when the corresponding [settings](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#settings) are turned on. SSL certificate analysis is *off* by default.

The agent DOES NOT ever send the raw unprocessed config files to the backend system. In addition, the following directives in the NGINX configuration are NOT analyzed—and their parameters ARE NOT exported to the SaaS backend:
[ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key), [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate), [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file), [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file), [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate), [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file), [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret). 

For more information on configuration analysis and reports see the [Amplify documentation](https://github.com/nginxinc/nginx-amplify-doc/blob/master/amplify-guide.md#reports).
