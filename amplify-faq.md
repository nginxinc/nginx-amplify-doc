<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [1. General](#1-general)
  - [1.1. What is NGINX Amplify?](#11-what-is-nginx-amplify)
  - [1.2. Where is the main system hosted?](#12-where-is-the-main-system-hosted)
  - [1.3. Is the traffic from the agent to the SaaS protected?](#13-is-the-traffic-from-the-agent-to-the-saas-protected)
  - [1.4. Is the Amplify Agent code publicly available?](#14-is-the-amplify-agent-code-publicly-available)
  - [1.5. Why is my password asked when installing on CentOS?](#15-why-is-my-password-asked-when-installing-on-centos)
- [2. Amplify Agent](#2-amplify-agent)
  - [2.1. What operatings systems are supported?](#21-what-operatings-systems-are-supported)
  - [2.2. What version of Python is required?](#22-what-version-of-python-is-required)
  - [2.3. How do I add a new a system to the monitoring?](#23-how-do-i-add-a-new-a-system-to-the-monitoring)
  - [2.4. What do I need to get the Agent reporting metrics?](#24-what-do-i-need-to-get-the-agent-reporting-metrics)
  - [2.5. How to verify if the Amplify Agent is properly installed](#25-how-to-verify-if-the-amplify-agent-is-properly-installed)
  - [2.6. How can I update the agent?](#26-how-can-i-update-the-agent)
  - [2.7. How much system resources are required?](#27-how-much-system-resources-are-required)
  - [2.8. How to restart the agent](#28-how-to-restart-the-agent)
  - [2.9 How can I uninstall the agent?](#29-how-can-i-uninstall-the-agent)
- [3. User interface](#3-user-interface)
  - [3.1. What browsers are supported](#31-what-browsers-are-supported)
  - [3.2. Is UI traffic secure?](#32-is-ui-traffic-secure)
- [4. Metrics and metadata](#4-metrics-and-metadata)
  - [4.1. What metrics and metadata is collected](#41-what-metrics-and-metadata-is-collected)
  - [4.2. How is the NGINX configuration parsed and analyzed](#42-how-is-the-nginx-configuration-parsed-and-analyzed)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 1. General

### 1.1. What is NGINX Amplify?

NGINX Amplify is a tool designed to monitor and optimize application delivery infrastructures. With Amplify it becomes possible to proactively analyze and fix problems related to running and scaling modern web applications.

You can use NGINX Amplify to do the following:

 * Visualize and identify performance bottlenecks, overloaded servers, or potential DDoS attacks
 * Improve and optimize NGINX performance with intelligent advice and recommendations
 * Get notified when something is wrong with the application delivery
 * Plan web application capacity and performance
 * Keep track of the systems running NGINX
 
### 1.2. Where is the main system hosted?

NGINX Amplify SaaS is currently hosted in [AWS us-west-1](http://docs.aws.amazon.com/general/latest/gr/rande.html) (US West, N. California).

### 1.3. Is the traffic from the agent to the SaaS protected?

All communications between the Amplify Agent and the Amplify SaaS are done securely over TLS/SSL. All traffic is always initiated by the agent. The SaaS system doesn't establish any connections back to the agent running on a host.

### 1.4. Is the Amplify Agent code publicly available?

Amplify Agent is an open source application. It is licensed under the `[2-clause BSD license](https://github.com/nginxinc/nginx-amplify-agent/LICENSE)`, and it's available [here](https://github.com/nginxinc/nginx-amplify-agent).

### 1.5. Why is my password asked when installing on CentOS?

This is the way the package installation works on CentOS. That's not Amplify Agent asking you for the password, and it's not seen by us.


## 2. Amplify Agent

### 2.1. What operatings systems are supported?

Amplify Agent is currently supported on the following Linux flavors only:

 * Ubuntu 12.04, 14.04, 15.04
 * Debian 7, 8
 * CentOS 6, 7

### 2.2. What version of Python is required?

Amplify Agent will work with Python 2.6+.

### 2.3. How do I add a new a system to the monitoring?

This could done as simple as:

 1. `Download and run install script.`

        # curl -sS -L -O http://pp.nginx.com/andrew/files/install.sh && \
        API_KEY='ecfdee2e010899135c258d741a6effc7' sh ./install.sh`

    Where API_KEY is a unique API key assigned when you create an account with Amplify. You will see your API key when adding new system in the Amplify UI.

 2. Start Amplify Agent.

        # /etc/init.d/amplify-agent start

### 2.4. What do I need to get the Agent reporting metrics?

After you install and start the agent, normally it should just start reporting right away, pushing aggregated data to the SaaS in regular 1 minute intervals. It'll take about a minute for the new system to appear in the Amplify UI.

If you don't see the new system in the UI, or metrics aren't being collected, please make sure that:

 1. Amplify Agent package has been successfully installed
 2. `amplify-agent` process is running
 3. [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) is properly set up in your NGINX configuration
 4. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) configured in NGINX config)
 5. Oubound TLS/SSL from the system is not restricted
 6. System DNS resolver is properly configured, and `receiver.amplify.nginx.com` can be successfully resolved.

### 2.5. How to verify if the Amplify Agent is properly installed

 1. On Ubuntu/Debian

```
    # dpkg -s nginx-amplify-agent
    Package: nginx-amplify-agent
    Status: install ok installed
    Priority: optional
    Section: python
    Maintainer: Mike Belov
    Architecture: amd64
    Version: 0.20-1~trusty
    Depends: python (>= 2.6), lsb-release
    Description: Nginx Amplify Agent
    Homepage: https://www.nginx.com/
```

 2. On CentOS

```
    XXXX
```

### 2.6. How can I update the agent?

 1. On Ubuntu/Debian use
 
```
    apt-get update && \
    apt-get install nginx-amplify-agent && \
    service amplify-agent restart
```

 2. On CentOS use

```
    XXXX
```

### 2.7. How much system resources are required?

We worked very hard to make the agent retain as small memory and CPU footprint as possible. Normally it shouldn't be more than a few % of CPU time, and around 25-30MB of RSS memory.
   
### 2.8. How to restart the agent

 1. On Ubuntu/Debian

```
    service amplify-agent restart
```

 2. On CentOS

```
    XXXX
```

### 2.9 How can I uninstall the agent?

 1. On Ubuntu/Debian use


```
    apt-get remove nginx-amplify-agent
```

 2. On CentOS use

```
    XXXX
```


## 3. User interface

### 3.1. What browsers are supported?

Currently the following desktop browsers are officially fully supported:

 * Chrome
 * Firefox
 * Safari

### 3.2. Is UI traffic secure?

We only support TLS/SSL connections the web UI.


## 4. Metrics and metadata

### 4.1. What metrics and metadata is collected

Amplify agent collects the following type of data:

 * **System metadata.** This is basic information about the OS environment where the agent runs. This could be hostname, uptime information, and so on.
 * **System metrics.** This is various data describing key system characteristics, e.g. CPU usage, memory usage, network traffic etc.
 * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, path to binary, configure options etc. NGINX metadata also includes config file breakdown.
 * **NGINX metrics.** Amplify Agent collects NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), and also from the NGINX logs files.

Amplify Agent will mostly use Python's **psutil()** to collect the data, but occasionally may also invoke certain system utilities like **ps(1)**.

### 4.2. How is the NGINX configuration parsed and analyzed

Amplify Agent is able to automatically find all relevant NGINX configuration files, parse configuration, extract their logical structure and send the associated JSON data to Amplify SaaS for further analysis and reports. For more information on configuration analysis and reports see the [Amplify documentation](https://github.com/nginxinc/nginx-amplify-doc/).

