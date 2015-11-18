<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Overview](#overview)
  - [What is NGINX Amplify](#what-is-nginx-amplify)
  - [Main components](#main-components)
- [Amplify Agent](#amplify-agent)
  - [Installation](#installation)
    - [Using install.sh](#using-installsh)
    - [Installing Amplify Agent manually](#installing-amplify-agent-manually)
      - [Ubuntu/Debian](#ubuntudebian)
      - [CentOS/Red Hat/Amazon Linux](#centosred-hatamazon-linux)
      - [Create config file from template](#create-config-file-from-template)
      - [Start the agent](#start-the-agent)
      - [Verify that Amplify agent is started](#verify-that-amplify-agent-is-started)
  - [Updating](#updating)
  - [Configuration](#configuration)
  - [Logging](#logging)
  - [Source code](#source-code)
  - [How Amplify Agent works](#how-amplify-agent-works)
  - [Metadata and metrics collection](#metadata-and-metrics-collection)
  - [Detecting and monitoring NGINX instances](#detecting-and-monitoring-nginx-instances)
  - [Configuring NGINX for Amplify metric collection](#configuring-nginx-for-amplify-metric-collection)
  - [NGINX configuration reports](#nginx-configuration-reports)
  - [What to check if Agent isn't reporting metrics](#what-to-check-if-agent-isnt-reporting-metrics)
- [User interface](#user-interface)
  - [Graphs page](#graphs-page)
    - [Systems list](#systems-list)
    - [Preview](#preview)
    - [Graph feed](#graph-feed)
  - [Reports](#reports)
  - [Events](#events)
  - [Alerts](#alerts)
  - [Settings](#settings)
- [Metrics and metadata](#metrics-and-metadata)
  - [OS metrics](#os-metrics)
  - [NGINX metrics](#nginx-metrics)
    - [HTTP connections and requests](#http-connections-and-requests)
    - [HTTP methods](#http-methods)
    - [HTTP status codes](#http-status-codes)
    - [HTTP protocol versions](#http-protocol-versions)
    - [Additional HTTP metrics](#additional-http-metrics)
    - [Upstream metrics](#upstream-metrics)
    - [Cache metrics](#cache-metrics)
    - [NGINX process metrics](#nginx-process-metrics)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Overview

### What is NGINX Amplify

NGINX Amplify is a tool designed to monitor and optimize application delivery infrastructure. With Amplify it becomes possible to proactively analyze and fix problems related to running and scaling modern web applications.

You can use NGINX Amplify to do the following:

 * Visualize and identify performance bottlenecks, overloaded servers, or potential DDoS attacks
 * Improve and optimize NGINX performance with intelligent advice and recommendations
 * Get notified when something is wrong with the application delivery
 * Plan web application capacity and performance
 * Keep track of the systems running NGINX

### Main components

NGINX Amplify is mainly a SaaS product, and it's hosted on AWS public cloud. It includes the following key components:

 1. **Agent**

    Amplify Agent is a Python application that runs on monitored systems. Its role is to collect various metrics from the operating system and from the NGINX instances, aggregate and send them to the backend system for visualization.

    All communications between the agent and Amplify SaaS are done securely over TLS/SSL. All traffic is always initiated by the agent.

 2. **Amplify UI**

    This is the user interface accessible from all major browsers. Web interface is only accessible via TLS/SSL.

 3. **Backend** (implemented as a SaaS)

    This is the core system component encompassing scalable metrics collection infrastructure, database, and core API.


## Amplify Agent

### Installation

In order to be able to use NGINX Amplify to monitor your infrastructure, you need to install Amplify Agent on each system that has to be checked.

**Note.** Amplify Agent will drop *root* privileges on startup. It will then use effective UID of the user `nginx`. Package install procedure will add the `nginx` user automatically unless it's already found in the system. If there's the [user](http://nginx.org/en/docs/ngx_core_module.html#user) directive found in NGINX configuration, the agent will pick up the user specified in NGINX config for its effective UID (e.g. `www-data`).

#### Using install.sh

This could done as simple as:

 1. Download and run install script.

        # curl -sS -L -O \
        https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
        API_KEY='ecfdee2e010899135c258d741a6effc7' sh ./install.sh

    Where API_KEY is a unique API key assigned when you create an account with Amplify. You will see your API key when adding new system in the Amplify UI.

 2. Verify that Amplify agent is started.

        # ps ax | grep -i 'amplify\-'
        2552 ?        S      0:00 amplify-agent


#### Installing Amplify Agent manually

##### Ubuntu/Debian

 * Add nginx public key.

```
    # curl -fs http://nginx.org/keys/nginx_signing.key | \
    apt-key add -
```

   or if using *wget(1)* instead of *curl(1)*

```
    # wget -q -O - \
    http://nginx.org/keys/nginx_signing.key | \
    apt-key add -
```

 * Create repository config as follows.

```
    # codename=`lsb_release -cs` && \
    os=`lsb_release -is | tr '[:upper:]' '[:lower:]'` && \
    echo "deb http://packages.amplify.nginx.com/${os}/ ${codename} amplify-agent" > \
    /etc/apt/sources.list.d/nginx-amplify.list
```

 * Verify repository config file.

```
    # cat /etc/apt/sources.list.d/nginx-amplify.list
    deb http://packages.amplify.nginx.com/ubuntu/ trusty amplify-agent
```

 * Update package index files.

```
    # apt-get update
```

 * Install Amplify agent.

```
    # apt-get install nginx-amplify-agent
```

##### CentOS/Red Hat/Amazon Linux

 * Add nginx public key.

```
    # curl -sS -L -O http://nginx.org/keys/nginx_signing.key && \
    rpm --import nginx_signing.key
```

   or if using *wget(1)* instead of *curl(1)*

```
    # wget -q -O nginx_signing.key http://nginx.org/keys/nginx_signing.key && \
    rpm --import nginx_signing.key
```

 * Create repository config as follows (mind the correct release number).

```
    # release="7" && \
    printf "[nginx-amplify]\nname=nginx amplify repo\nbaseurl=http://packages.amplify.nginx.com/centos/${release}/\$basearch\ngpgcheck=1\nenabled=1\n" > \
    /etc/yum.repos.d/nginx-amplify.repo
```

 * Verify repository config file.

```
    # cat /etc/yum.repos.d/nginx-amplify.repo 
    [nginx-amplify]
    name=nginx repo
    baseurl=http://packages.amplify.nginx.com/centos/7/$basearch
    gpgcheck=1
    enabled=1
```
    
 * Update package metadata.

```
    # yum makecache
```

 * Install Amplify agent.

```
    # yum install nginx-amplify-agent
```

##### Create config file from template

```
    # api_key="ecfdee2e010899135c258d741a6effc7" && \
    sed "s/api_key.*$/api_key = ${api_key}/" \
    /etc/amplify-agent/agent.conf.default > \
    /etc/amplify-agent/agent.conf
```

Where API_KEY is a unique API key assigned when you create an account with Amplify. You will see your API key when adding new system in the Amplify UI.

##### Start the agent

```
    # service amplify-agent start
```

##### Verify that Amplify agent is started

        # ps ax | grep -i 'amplify\-'
        2552 ?        S      0:00 amplify-agent

### Updating

It is highly recommended to periodically check for updates and install the latest stable version of the agent.

 * On Ubuntu/Debian use:

        # apt-get update && \
        apt-get install nginx-amplify-agent

        # service amplify-agent restart

 * On CentOS/Red Hat use:

        # yum makecache && \
        yum update nginx-amplify-agent

        # service amplify-agent restart        

### Configuration

Amplify Agent's configuration resides in `/etc/amplify-agent/agent.conf`.

When you first install the agent using the procedure above, your API key is written to the `agent.conf` file automatically. If you'll need to ever change the API key, look for the following section in `agent.conf`, and edit it accordingly:

```
    [credentials]
    api_key = ecfdee2e010899135c258d741a6effc7
```

If the agent is not able to determine system's hostname, you can define it manually in `/etc/amplify-agent/agent.conf`. Check for the following section, and fill in the desired hostname:

```
    [credentials]
    ..
    hostname = myhostname1
```

Hostname should be something real — the following aren't valid hostnames:

 * localhost
 * localhost.localdomain
 * localhost6.localdomain6
 * ip6-localhost
 
You can also use the above method to substitute system's hostname with an arbitrary alias.

**Note.** Keep in mind that if you redefine hostname for a live object, it will appear as a failed one in the UI. Redefining hostname in the agent's configuration essentially creates a new system for monitoring.

### Logging

The agent maintains its log file in `/var/log/amplify-agent/agent.log`.

Upon installation, the agent's log rotation schedule is added to `/etc/logrotate.d/amplify-agent`.

Normal level of logging for the agent is `INFO`. If you'd ever need to debug the agent, you'd need to change it to `DEBUG` as follows. Bear in mind, the size of the agent's log file could grow really fast with the `DEBUG`:

```

    [logger_agent-default]
    level = DEBUG
    ..

    [handler_agent-default]
    class = logging.handlers.WatchedFileHandler
    level = DEBUG
    ..
````

### Source code

Amplify Agent is an open source application. It is licensed under the [2-clause BSD license](https://github.com/nginxinc/nginx-amplify-agent/blob/master/LICENSE), and it's available here:

 * Sources: https://github.com/nginxinc/nginx-amplify-agent
 * Public package repository: http://packages.amplify.nginx.com
 * Install script for Linux: https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh

### How Amplify Agent works

NGINX Amplify Agent is a compact application written in Python. The role of the agent is to collect various metrics and metadata and export them to the main system for visualization.

You will need to install Amplify Agent on all hosts that you'd like to monitor.

Upon proper installation, the agent will automatically start to report metrics, and you should see something in the Amplify UI in about a minute or so.

Amplify Agent collects metrics and sends them to the Amplify SaaS on a 'per-object' basis. Basically, each distinct type of a monitored entity is seen as a (data) object internally.

There're currently the following object types:

 1. Operating system (this is the parent object)
 2. NGINX instance

By NGINX instance the agent assumes any running NGINX master process that has a unique path to the binary, and possibly a unique configuration.

**Note.** When objects are first seen by the agent, they will be automatically created in Amplify SaaS, and visualized in the web UI. You don't have to manually add NGINX instances after you install the Amplify Agent on a host.

When a system or an NGINX instance is removed from the infrastructure for whatever reason, and is no longer reporting&nbsp;— and no longer necessary, you should manually delete it in the web UI. The 'Remove object' button can be found in the meta viewer popup (see **User interface** below).

### Metadata and metrics collection

Amplify agent collects the following type of data:

 * **System metadata.** This is basic information about the OS environment where the agent runs. This could be hostname, uptime information, and so on.
 * **System metrics.** This is various data describing key system characteristics, e.g. CPU usage, memory usage, network traffic etc.
 * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, path to binary, configure options etc. NGINX metadata also includes config file breakdown.
 * **NGINX metrics.** Amplify Agent collects NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), and also from the NGINX logs files.

Amplify Agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the data, but occasionally may also invoke certain system utilities like *ps(1)*.

While the agent is running on the host, it collects metrics with steady 20 second intervals. Metrics then get aggregated and sent to SaaS once per minute.

Metadata is also reported every minute. Changes in the metadata can be examined through the Amplify UI using a web browser.

NGINX config updates are reported only when a configuration change is detected.

If the agent is not able to reach Amplify SaaS and send the accumulated metrics, it will continue to collect metrics, and will send them over to Amplify as soon as the connectivity is re-established.

### Detecting and monitoring NGINX instances

Amplify Agent is capable of detecting several types of NGINX instances:

 1. Installed from a repository package
 2. Built and installed manually

A separate instance of NGINX as seen by the Amplify Agent would be the following:

 * A unique master process and its workers, started from a distinct binary
 * Runs with a default config path, or with a custom path set in the command-line parameters

**Note.** The agent will try to detect all unique NGINX instances currently running on a host, and will create *separate* objects for monitoring. On a single system several NGINX objects always have the same parent object (the OS).

### Configuring NGINX for Amplify metric collection

In order to be able to see NGINX graphs in the UI, you will need to have [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) defined in your NGINX configuration. If it's there already, the agent should be able to pick it automatically. Otherwise, add it as follows:

```

    # cd /etc/nginx

    # grep -i include\.*conf nginx.conf
        include /etc/nginx/conf.d/*.conf;

    # cat > conf.d/stub_status.conf
    server {
        listen 127.0.0.1:80;
        server_name 127.0.0.1;
        location /nginx_status {
            stub_status on;
            allow 127.0.0.1;
            deny all;
        }
    }
    ^D

    # ls -la conf.d/stub_status.conf
    -rw-r--r-- 1 root root 162 Nov  4 02:40 conf.d/stub_status.conf

    # kill -HUP `cat /var/run/nginx.pid`
```

Without *stub_status* the agent will **not** be able to collect quite a few essential NGINX metrics required for further monitoring and analysis.

**Note.** There's no need to use exactly the above illustrated `nginx_status` URI for [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html). The agent will determine the right URI automatically upon parsing your NGINX configuration.

For more information about *stub_status*, please refer to our reference documentation [here](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html).

Amplify agent uses data from *stub_status* to calculate a number of metrics related to server-wide HTTP connections and requests as follows:

    nginx.http.conn.accepted = stub_status.accepts
    nginx.http.conn.active = stub_status.active - stub_status.waiting
    nginx.http.conn.current = stub_status.active
    nginx.http.conn.dropped = stub_status.accepts - stub_status.handled
    nginx.http.conn.idle = stub_status.waiting

    nginx.http.request.count = stub_status.requests
    nginx.http.request.current = stub_status.reading + stub_status.writing
    nginx.http.request.reading = stub_status.reading
    nginx.http.request.writing = stub_status.writing

For more information about the metric list, please refer to the **Metrics and metadata** section below.

Amplify Agent will also try to collect all additional metrics relevant to a particular NGINX instance from the [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and the [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files. In order to do that, the agent should be able to read the logs. Make sure that either the `nginx` user or the user [defined in NGINX config](http://nginx.org/en/docs/ngx_core_module.html#user) can read log files. Please also make sure that your log files are being written normally and are growing.

You don't have to specifically point the agent to either NGINX configuration or NGINX log files — it should detect their location automatically.

Agent will also try to detect the log format for a particular log, in order to be able to parse it properly and possibly extract even more useful metrics, e.g. [$upstream_response_time](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_upstream_response_time).

**Note.** A number of metrics outlined in **Metrics and metadata** will only be available if corresponding variables are included in a custom [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) format used for logging requests. You can find complete list of NGINX log variables [here](http://nginx.org/en/docs/varindex.html).

### NGINX configuration reports

Amplify Agent is able to automatically find all relevant NGINX configuration files, parse configuration, extract their logical structure and send the associated JSON data to Amplify SaaS for further analysis and reports. For more information on configuration analysis and reports see **Reports** section below.

After the agent finds a particular NGINX configuration, it'll then automatically start to keep track of its changes.

When a change is detected with NGINX — e.g. a master process restarts, or the NGINX config is edited, such updates will be sent to Amplify SaaS.

**Note.** The following directives and their parameters aren't exported to the SaaS: *ssl_certificate*, *ssl_certificate_key*, *ssl_client_certificate*, *ssl_password_file*, *ssl_stapling_file*, *ssl_trusted_certificate*, *auth_basic_user_file*, *secure_link_secret*.

### What to check if Agent isn't reporting metrics

After you install and start the agent, normally it should just start reporting right away, pushing aggregated data to the SaaS in regular 1 minute intervals. It'll take about a minute for the new system to appear in the Amplify UI.

If you don't see the new system in the UI, or metrics aren't being collected, please make sure that:

 1. Amplify Agent package has been successfully installed
 2. `amplify-agent` process is running
 3. [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) is properly set up in your NGINX configuration
 4. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) configured in NGINX config)
 5. Oubound TLS/SSL from the system is not restricted
 6. System DNS resolver is properly configured, and `receiver.amplify.nginx.com` can be successfully resolved.
 7. Check if *selinux(8)* interferes. Check `/etc/selinux/config`, try `setenforce 0` temporarily and see if it improves the situation.


## User interface

### Graphs page

When you first login to Amplify, you’re presented with a graphical dashboard on the **Graphs** page. From here you can see an overview of all your systems with graphs of key statistics, such as CPU, memory, and disk usage.

#### Systems list

On the left is the list of the Systems being monitored by Amplify, those that have the Amplify agent installed on it. The systems do not have to have NGINX installed, though you get additional visibility into NGINX if they do. For systems that do have NGINX installed, the version of NGINX is listed under the hostname for that server.

When you install the agent on a new system, it'll automatically appear in the Systems list. The Systems list persists across all pages in the UI (**Graphs**, **Reports**, **Events**, **Alerts**).

Systems list allows you to quickly check their status. It also provides a quick overview of the key metrics being reported. Hovering mouse pointer over any of the Systems in the list reveals 4 vertical dots — if you click on them, a pullout toolbar will appear. The toolbar will display numerical and text information about current CPU and memory usage, traffic in and out, OS flavor, and NGINX version.

While on the **Graphs** page, clicking on any of the systems will bring up the graphs for that system in the center **Preview** column (see below).

You can apply sorting and search/filter to the inventory list to quickly find the system in question. You can search by hostname, IP address, architecture etc. Search accepts regular expressions.

#### Preview

In the middle of the screen there's the **Preview** section where you can quickly browse and check what graphs are available, and whether there are any anomalies to be analyzed.

The graphs in the **Preview** column are split in distinct sections. Each section is a collection of graphs for a particular system. If you click on a system in the leftmost column, **Preview** will scroll to the corresponding section. You can also just scroll the **Preview** manually to find the necessary graphs.

Clicking on any of the smaller graphs in the Preview column will bring up a larger version of that graph in the **Graph Feed** on the right side for a 'quick look' reference. It will be highlighted with a green border, and it'll stay on top of the graphs in the **Graph feed** (see below).

There are checkboxes on the preview graphs. Clicking on a graph's checkbox will pin it to the bottom of the **Graph feed** for further analysis.

Some graphs in the **Preview** have an additional selector for the label associated with a metric. E.g. with 'Disk latency', or 'Network traffic' you can select what device or interface you're analyzing. Switching label on a graph changes the preview graph to display the corresponding data.

Up above the **Graph feed** is the time range, that helps to scale displayed data for up to the past week.

#### Graph feed

Section on the right is called **Graph feed**. When analyzing the graphs, you can populate this section from **Preview**. In order to do that, click on a graph's checkbox in **Preview**. The 'checked' graph from **Preview** will then be added to the bottom of the **Graph feed**. When you uncheck the graph, it'll be removed from the **Graph feed**.

You can also add the topmost 'quick look' graph to the **Graph feed** by clicking on (+) sign.

If you need to zoom into graphs, you can click on the 'expand' icon to the left of the 'Graph feed' label.

Up above the **Graph feed** you'll find controls to switch the time intervals that are applied to all graphs on the **Graphs** page. You can switch between `1H` `4H` `1D` `2D` and `1W` intervals depending on the time period you'd like to analyze.

You will also see a ruler on all graphs that might be very helpful when trying to manually correlate events.

A typical workflow when analyzing OS and/or NGINX behavior would be:

 * Browse through the graphs in **Preview**
 * With a single click bring the interesting ones to the right for a quick look
 * Populate the **Graph feed** with the graphs from **Preview** that require further analysis and correlation
 * Change time intervals for visualization to see a bigger picture
 * Scroll through the **Graph feed** to visually match the graphs in the feed to the 'quick look' view
 * Expand/collapse the **Graph feed** depending on the required level of detalization
 * Find anomalies, correlations, trends
 * Leave graphs in the **Graph feed** for future analysis/monitoring

You can also just pin the graphs that you want to check regularly to the **Graph** feed with, and use it as a general monitoring dashboard.

In the **Graph feed** you can click on the graph title to quickly scroll **Preview** to the relevant section.

State of the **Graphs** page is automatically saved, so next time you log in, you should see the same **Graph** page that you previously built for monitoring and analysis.

### Reports

Reports are based on the capabilities of the Amplify Agent to parse NGINX configuration files and provide them for further analysis through the features in the SaaS core. This is where Amplify offers configuration recommendations to help improving performance, reliability, and security of your applications. With well thought-out and explained recommendations you’ll know exactly where the problem is, why it is a problem and how to fix it.

When you switch to the **Reports** page, click on a particular system in the Systems list in order to see the associated report. If there isn't an NGINX instance found on a system, there will be no report for it.

Currently only static analysis is done over the NGINX configuration. The following information is provided when a report is run against an NGINX config:

 * Overview information
   * Path to NGINX config files(s)
   * Whether the parser failed or not, and the results of `nginx -t`
   * First-seen and last-modified info
   * 3rd party modules found
   * Breakdown of IPv4/IPv6 usage
   * Breakdown of key configuration elements (servers, locations, upstreams)
   * OpenSSL version information
 * Static analysis
   * Various suggestions about configuration structure
   * Typical configuration gotchas highlighted
   * Common advice about proxy configurations
   * Suggestions about simplifying rewrites for certain use cases
   * Key security measures (e.g. *stub_status* is unprotected)
   * Typical errors in configuring locations, esp. with *regex*

Static analysis will only include information about specific issues with the NGINX configuration if those are found in your NGINX setup.

Going further, the **Reports** section will also include *dynamic analysis*, effectively linking the observed NGINX behavior to its configuration — e.g. when it makes sense to increase or decrease certain parameter like [proxy_buffers](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffers) etc. Stay tuned!

Config analysis and reports are *on* by default. If you don't want your NGINX configuration to be checked, unset the corresponding setting in either Global, or Local (per-system) settings. See **Settings** below.

### Events

There're local (per-agent) and global events.

In order to see events generated by a particular agent, click on a system on the left, and browse through local events in the middle column. You may think of it as of a mini-log from the agents.

In the rightmost corner you'll see SaaS-wide events such as general notifications about Amplify updates or outages.

### Alerts

Alerts page describes configuration of system monitors and associated triggers used to notify you of any anomalies in your systems' behavior.

Alerts are based on setting a rule to monitor a particular metric. When the rule is being set you will also be able to specify the threshold, and the email for notifications.

The way rules and alerts work is the following:

 1. Metrics are being continuously monitored against the rulesets
 2. If there's a rule for a metric, the new metric update is checked against the threshold
 3. If the threshold is met, alert notification is generated, and the rule will continue to be monitored.
 4. If subsequent metric updates show that the metric doesn't violate anymore the threshold for the configured period, the alert is cleared.

By default there's no filtering by hostname. If a specific alert should only be raised for a particular host, you should specify the hostname in the ruleset. Currently metrics can't be aggregated across all systems, instead any system will match a particular ruleset unless a hostname is specified.

There's on special rule which is about *amplify.agent.status* metric. This metric reflect the state of the agent (and hence, the state of the system as seen by Amplify). You can only configure 2 min. interval and only 0 (zero) as threshold for *amplify.agent.status*.

With the notifications you shouldn't see continuous redundant ones about the same single alert over and over again. Instead there will be digest information sent out *every 30 minutes*, describing what alerts were generated and which ones were cleared.

**Note.** For the thresholds you should currently use exact measurement units as described in the **Metrics and metadata** section below. You can't currently use abbreviations like GB, KB or Kbps.

**Note.** Gauges are averaged over the interval configured in the ruleset. Counters are summed up. Currently that's not user configurable and these are the only reduce functions available for configurating metric thresholds.

**Note.** Emails are sent using [AWS SES](https://aws.amazon.com/ses/). Make sure your mail relay accepts their traffic.

### Settings

There's the **Settings** option in the 'hamburger' menu at the top right corner of the UI — that describes global settings.

Global settings are used to set account-wide behavior for:

 * Analyzing NGINX configuration files
 * Checking NGINX configuration syntax
 * Checking SSL certs and configuration (currently not implemented)

Local settings are accessible via the 'Settings' icon that can be found when the pullout tray for a particular system is extended.

Local settings override corresponding global setting on a per-object basis. E.g. if you'd generally want to monitor your NGINX configurations for everything but specific systems, you can uncheck them in the their local settings menu.



## Metrics and metadata

Most metrics will be collected by the agent without requiring the user to perform any additional setup (for troubleshooting see section "What do I need to get the Agent reporting metrics?" above).

Some additional metrics for NGINX will only be reported if NGINX configuration file is adjusted accordingly. See section "Additional HTTP metrics" below, and pay attention to Source and Variable fields in metric descriptions that follow.

### OS metrics

 * Agent
   * **amplify.agent.status**

```
     Type: internal, integer
     Description: 1 - agent is up, 0 - agent is down.
```

 * CPU usage
   * **system.cpu.idle**
   * **system.cpu.iowait**
   * **system.cpu.system**
   * **system.cpu.user**

```
     Type: gauge, percent
     Description: System CPU utilization.
```

 * Disk usage
   * **system.disk.free**
   * **system.disk.total**
   * **system.disk.used**

```
     Type: gauge, bytes
     Description: System disk usage statistics.
```

   * **system.disk.in_use**

```
     Type: gauge, percent
     Description: System disk usage statistics, percentage.
```

 * Disk I/O
   * **system.io.iops_r**
   * **system.io.iops_w**

```
     Type: counter, integer
     Description: Number of reads or writes per sampling window.
```

   * **system.io.kbs_r**
   * **system.io.kbs_w**

```
     Type: counter, kilobytes
     Description: Number of kilobytes read or written.
```

   * **system.io.wait_r**
   * **system.io.wait_w**

```
     Type: gauge, milliseconds
     Description: Time spent reading from or writing to disk.
```

 * Load average
   * **system.load.1**
   * **system.load.5**
   * **system.load.15**

```
     Type: gauge, float
     Description: Number of processes in the system run queue averaged
     over the last 1, 5, and 15 min.
```

 * Memory usage
   * **system.mem.available**
   * **system.mem.buffered**
   * **system.mem.cached**
   * **system.mem.free**
   * **system.mem.shared**
   * **system.mem.total**
   * **system.mem.used**

```
     Type: gauge, bytes
     Description: Statistics about system memory usage.
```

   * **system.mem.pct_used**

```
     Type: gauge, percent
     Description: Statistics about system memory usage, percentage.
```

 * Network
   * **system.net.bytes_rcvd**
   * **system.net.bytes_sent**

```
     Type: counter, bytes
     Description: Network I/O statistics. Number of bytes received or sent,
     per network interface.
```

   * **system.net.drops_in.count**
   * **system.net.drops_out.count**

```
     Type: counter, integer
     Description: Network I/O statistics. Total number of inbound or
     outbound packets dropped, per network interface.
```

   * **system.net.packets_in.count**
   * **system.net.packets_out.count**

```
     Type: counter, integer
     Description: Network I/O statistics. Number of packets received
     or sent, per network interface.
```

   * **system.net.packets_in.error**
   * **system.net.packets_out.error**

```
     Type: counter, integer
     Description: Network I/O statistics. Total number of errors while
     receiving or sending, per network interface.
```

   * **system.net.listen_overflows**

```
     Type: counter, integer
     Description: Number of times the listen queue of a socket overflowed.
```

 * Swap
   * **system.swap.free**
   * **system.swap.total**
   * **system.swap.used**

```
     Type: gauge, bytes
     Description: System swap memory statistics.
```

   * **system.swap.pct_free**

```
     Type: gauge, percent
     Description: System swap memory statistics, percentage.
```

### NGINX metrics

#### HTTP connections and requests

 * HTTP
   * **nginx.http.conn.accepted**
   * **nginx.http.conn.dropped**

```
     Type: counter, integer
     Description: NGINX-wide statistics describing HTTP connections.
     Source: stub_status
```

   * **nginx.http.conn.active**
   * **nginx.http.conn.current**
   * **nginx.http.conn.idle**

```
     Type: gauge, integer
     Description: NGINX-wide statistics describing HTTP connections.
     Source: stub_status
```

   * **nginx.http.request.count**

```
     Type: counter, integer
     Description: Total number of client requests.
     Source: stub_status
```

   * **nginx.http.request.current**
   * **nginx.http.request.reading**
   * **nginx.http.request.writing**

```
     Type: gauge, integer
     Description: Number of currently active requests (reading and writing).
     Number of requests reading headers or writing responses to clients.
     Source: stub_status
```

   * **nginx.http.request.malformed**

```
     Type: counter, integer
     Description: Number of malformed requests.
     Source: access.log
```

   * **nginx.http.request.body_bytes_sent**

```
     Type: counter, integer
     Description: Number of bytes sent to clients, not counting
     response headers.
     Source: access.log
```

#### HTTP methods

   * **nginx.http.method.get**
   * **nginx.http.method.head**
   * **nginx.http.method.post**
   * **nginx.http.method.put**
   * **nginx.http.method.delete**
   * **nginx.http.method.options**

```
     Type: counter, integer
     Description: Statistics about observed request methods.
     Source: access.log
```

#### HTTP status codes

   * **nginx.http.status.1xx**
   * **nginx.http.status.2xx**
   * **nginx.http.status.3xx**
   * **nginx.http.status.4xx**
   * **nginx.http.status.5xx**

```
     Type: counter, integer
     Description: Number of requests with specific HTTP status codes.
     Source: access.log
```

   * **nginx.http.status.discarded**

```
     Type: counter, integer
     Description: Number of requests finalized with 499/444/408.
     E.g. 499 is logged when the client closes connection.
     Source: access.log
```

#### HTTP protocol versions

   * **nginx.http.v0_9**
   * **nginx.http.v1_0**
   * **nginx.http.v1_1**
   * **nginx.http.v2**

```
     Type: counter, integer
     Description: Number of requests using specific version of HTTP protocol.
     Source: access.log
```

#### Additional HTTP metrics

Metrics below require additional configuration of NGINX logging. Please check the following sections of NGINX reference documentation for more information:

 1. [Alphabetical index of variables](http://nginx.org/en/docs/varindex.html)
 2. [Configuring NGINX access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html)
 3. [Configuring NGINX error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) 

Example configuration for an extended log format could be as follows:

```
    log_format  main_ext '$remote_addr - $remote_user [$time_local] "$request" '
                         ' $status $body_bytes_sent "$http_referer" '
                         '"$http_user_agent" "$http_x_forwarded_for" '
                         'rt=$request_time ua="$upstream_addr" '
                         'us="$upstream_status" ut="$upstream_response_time" '
                         'cs=$upstream_cache_status' ;

    access_log  /var/log/nginx/access.log  main_ext;
```

Amplify will build a few more graphs in Preview if **nginx.http.request.time**, **nginx.upstream.response.time** and **nginx.http.request.buffered** are found by the agent.

   * **nginx.http.request.bytes_sent**

```
     Type: counter, integer
     Description: Number of bytes sent to clients.
     Source: access.log (requires custom log format)
     Variable: $bytes_sent
```

   * **nginx.http.request.length**

```
     Type: counter, integer
     Description: Request length, including request line, header and body.
     Source: access.log (requires custom log format)
     Variable: $request_length
```

   * **nginx.http.request.time**
   * **nginx.http.request.time.count**
   * **nginx.http.request.time.max**
   * **nginx.http.request.time.median**
   * **nginx.http.request.time.pctl95**

```
     Type: gauge, seconds.milliseconds
     Description: Request processing time — time elapsed between reading
     the first bytes from the client and writing log entry after the
     last bytes were sent.
     Source: access.log (requires custom log format)
     Variable: $request_time
```

   * **nginx.http.request.buffered**

```
     Type: counter, integer
     Description: Number of requests that were buffered to disk.
     Source: error.log (requires 'warn' log level)
```

   * **nginx.http.gzip.ratio**

```
     Type: gauge, float
     Description: Achieved compression ratio, calculated as the ratio
     between the original and compressed response sizes.
     Source: access.log (requires custom log format)
     Variable: $gzip_ratio
```

#### Upstream metrics

 * Upstream
   * **nginx.upstream.connect.time**
   * **nginx.upstream.connect.time.count**
   * **nginx.upstream.connect.time.max**
   * **nginx.upstream.connect.time.median**
   * **nginx.upstream.connect.time.pctl95**

```
     Type: gauge, seconds.milliseconds
     Description: Time spent on establishing connections with upstream
     servers. With SSL, it also includes time spent on handshake.
     Source: access.log (requires custom log format)
     Variable: $upstream_connect_time
```

   * **nginx.upstream.header.time**
   * **nginx.upstream.header.time.count**
   * **nginx.upstream.header.time.max**
   * **nginx.upstream.header.time.median**
   * **nginx.upstream.header.time.pctl95**

```
     Type: gauge, seconds.milliseconds
     Description: Time spent on receiving response headers from upstream servers.
     Source: access.log (requires custom log format)
     Variable: $upstream_header_time
```

   * **nginx.upstream.response.buffered**

```
     Type: counter. integer
     Description: Number of upstream responses buffered to disk.
     Source: error.log (requires 'warn' log level)
```

   * **nginx.upstream.request.failed**
   * **nginx.upstream.response.failed**

```
     Type: counter, integer
     Description: Number of requests and responses that failed while proxying.
     Source: error.log (requires 'error' log level)
```

   * **nginx.upstream.response.time**
   * **nginx.upstream.response.time.count**
   * **nginx.upstream.response.time.max**
   * **nginx.upstream.response.time.median**
   * **nginx.upstream.response.time.pctl95**

```
     Type: gauge, seconds.milliseconds
     Description: Time spent on receiving responses from upstream servers.
     Source: access.log (requires custom log format)
     Variable: $upstream_response_time
```

#### Cache metrics

 * Cache
   * **nginx.cache.bypass**
   * **nginx.cache.expired**
   * **nginx.cache.hit**
   * **nginx.cache.miss**
   * **nginx.cache.revalidated**
   * **nginx.cache.stale**
   * **nginx.cache.updating**

```
     Type: counter, integer
     Description: Various statistics about NGINX cache usage.
     Source: access.log (requires custom log format)
     Variable: $upstream_cache_status
```

#### NGINX process metrics

 * Workers
   * **nginx.workers.count**

```
     Type: gauge, integer
     Description: Number of NGINX worker processes observed.
```

   * **nginx.workers.cpu.system**
   * **nginx.workers.cpu.total**
   * **nginx.workers.cpu.user**

```
     Type: gauge, percent
     Description: CPU utilization percentage observed from NGINX worker processes.
```

   * **nginx.workers.fds_count**

```
     Type: counter, integer
     Description: Number of file descriptors utilized by NGINX worker processes.
```

   * **nginx.workers.io.kbs_r**
   * **nginx.workers.io.kbs_w**

```
     Type: counter, integer
     Description: Number of kilobytes read from or written to disk by
     NGINX worker processes.
```

   * **nginx.workers.mem.rss**
   * **nginx.workers.mem.vms**

```
     Type: gauge, bytes
     Description: Memory utilization by NGINX worker processes.
```

   * **nginx.workers.mem.rss_pct**

```
     Type: gauge, percent
     Description: Memory utilization by NGINX worker processes.
```

   * **nginx.workers.rlimit_nofile**

```
     Type: gauge, integer
     Description: Hard limit on the number of file descriptors
     as seen by NGINX worker processes.
```
