## Overview


### What is NGINX Amplify

NGINX Amplify is a monitoring and configuration help product. It is a SaaS product, and it's hosted on AWS public cloud.

You can use NGINX Amplify to do the following:

 * Keep track of the systems running NGINX
 * Proactively identify issues related to NGINX configuration and operations
 * Find bottlenecks in NGINX infrastructure
 * Improve and optimize NGINX configuration and setup
 * Plan web applications capacity and performance

### Main components

NGINX Amplify includes the following key components:

 1. **Agent**

    Amplify Agent is a Python application running on end systems. Its role is to collect various metrics from the operating system and from the NGINX instances, aggregate and send them to the backend system for visualization.
    
    NGINX Amplify is hosted on AWS. All communications between the Amplify Agent and the Amplify SaaS are done securely over TLS/SSL, using 2048-bit encryption.

 2. **Web UI**

    This is the user interface accessible from all major browsers.

 3. **Backend** (implemented as a SaaS)

    This is the core system component encompassing scalable metrics collection infrastructure, database, and Core API.


## Amplify Agent

### Installation

In order to be able to use NGINX Amplify to monitor your infrastructure, you need to install Amplify Agent on each system that has to be checked.

This is done as simple as:

 1. Download and run install script.

        # curl -sS -L -O http://pp.nginx.com/andrew/files/install.sh && \
        API_KEY='ecfdee2e010899135c258d741a6effc7' sh ./install.sh`
     
    (where API_KEY is a unique API key assigned when you create an account with Amplify)

 2. Start Amplify Agent.

        # /etc/init.d/amplify-agent start

Amplify Agent will drop *root* privileges after it's started. It will then use the effective UID of the user `nginx`. The package install procedure will add the `nginx` user automatically unless it's already found in the system. If there's the [user](http://nginx.org/en/docs/ngx_core_module.html#user) directive found in NGINX configuration, the agent will pick up the user specified in NGINX config for its effective UID (e.g. `www-data`).

### Updates

It is highly recommended to periodically check for updates and install the latest stable version of the agent.

 * On Ubuntu/Debian use:

       apt-get update && \
       apt-get install nginx-amplify-agent && \
       service amplify-agent restart
 
 * On CentOS use:
 
       XXXX

### Configuration and logging

Amplify Agent's configuration resides in `/etc/amplify-agent/agent.conf`.

When you first install the agent using the procedure above, your API key is written to the `agent.conf` file automatically. If you'll need to ever change the API key, look for the following section in `agent.conf`, and edit it accordingly:

```
    [credentials]
    api_key = ecfdee2e010899135c258d741a6effc7
```

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

Amplify Agent is an open source application. It's licensed under the 2-clause BSD license, and it is available here:

 * `Sources: https://github.com/nginxinc/naas-agent`
 * `Packages repo (public): http://packages.naas.nginx.com/ (TBD)`

### How Amplify Agent works

#### What happens after install

NGINX Amplify Agent is a compact application written in Python. The role of the agent is to collect various metrics and metadata and export them to the main system for visualization.

You will need to install the Amplify Agent on all hosts that you'd like to monitored.

Upon proper installation, the agent will automatically start to report metrics, and you should see something in the Amplify Web UI in about a minute or so.

Amplify Agent collects metrics and sends them to the Amplify SaaS on a 'per-object' basis. Basically, each distinct type of a monitored entity is seen as a (data) object.

There're currently the following object types:

 1. Operating system (this is the parent object)
 2. NGINX instance
 
By NGINX instance the agent assumes any running NGINX master process that has a unique path to the binary, and possibly a unique configuration.

**Note.** When objects are first seen by the agent, they will be automatically created in Amplify SaaS, and visualized in the Web UI. You don't have to manually add NGINX instances after you install the Amplify Agent on a host.

When an NGINX instance disappears from the system for whatever reason and is no longer reporting — and no longer necessary, you should manually delete it from the Web UI. The 'Delete' object button is in the meta viewer popup (see **User interface** below).

#### Metadata and metrics collection

##### Types of data

The agent collects the following type of data:

 * **System metadata.** This is basic information about the OS environment where the agent runs. This could be hostname, uptime information, and so on.
 * **System metrics.** This is various data describing key system characteristics, e.g. CPU usage, memory usage, network traffic etc.
 * **NGINX metadata.** This is what describes your NGINX instances, and it includes a particular package and build information, path to binary, configure options etc. NGINX metadata also includes config file breakdown.
 * **NGINX metrics.** Amplify Agent collects NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), and also from the NGINX logs files.

Amplify Agent will mostly use Python's **psutil()** to collect the data, but occasionally may also invoke select system utilities like **ps(1)**.

While the agent is running on the host, it collects metrics with steady 20s intervals. Metrics then get aggregated and sent to SaaS once per minute.

Metadata is also reported every minute. Changes in the metadata can be examined through the Amplify Web UI using a web browser.

NGINX config updates are reported only when a configuration change is detected.

##### Detecting and monitoring NGINX instances

Amplify Agent is capable of detecting several types of NGINX instances:

 1. Installed from a repository package
 2. Built and installed manually
 
A separate instance of NGINX as seen by the Amplify Agent would be the following:

 * A unique master process and its workers, started from a distinct binary
 * Runs with a default config path, or with a custom path set in the command-line parameters

**Note.** The agent will try to detect all unique NGINX instances currently running on a host, and will create *separate* leaf objects for monitoring. NGINX objects are always the leaf objects having a single parent object (the OS).

##### Configuring NGINX for Amplify metric collection

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
            stub_status;
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

Amplify Agent will also try to collect all additional metrics relevant to a particular NGINX instance from the [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and the [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files. In order to do that, the agent should be able to read the logs. Make sure that either the `nginx` user or the user [defined in NGINX config](http://nginx.org/en/docs/ngx_core_module.html#user) can read log files. Please also make sure that your log files are being written normally and are growing.

You don't have to specifically point the agent to either NGINX configuration or NGINX log files — it should detect their location automatically.

Agent will also try to detect the log format for a particular log, in order to be able to parse it properly and possibly extract even more useful metrics, e.g. [$upstream_response_time](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_upstream_response_time).

##### NGINX configuration analysis

Amplify Agent is able to automatically find all relevant NGINX configuration files, parse configuration, extract their logical structure and send them to Amplify SaaS for further analysis and reports. For more information on configuration analysis and reports see **Reports** section below.

After the agent finds a particular NGINX configuration, it'll then start to keep track of them.

When a change is detected with NGINX — e.g. a master process restarts, or the NGINX config is changed, such updates will be automatically sent to Amplify SaaS.

**Note.** The following directives and their parameters aren't exported to the SaaS: *ssl_certificate*, *ssl_certificate_key*, *ssl_client_certificate*, *ssl_password_file*, *ssl_stapling_file*, *ssl_trusted_certificate*, *auth_basic_user_file*, *secure_link_secret*.


## User interface

### Graphs page

Upon logging in, the first thing you see is going to be the **Graphs** page.

**Graphs** page is essentially what the name suggests. It's a collection of graphs that visualize the metrics collected from your systems.

#### Inventory

On the left you'll find the inventory list of all hosts that are currently monitored — those that have the Amplify Agent installed. In the inventory list you will always see the parent OS object and the NGINX objects combined into a single 'system'.

When you install the agent on a new system, it'll automatically appear in the inventory. The inventory list is persistent across all menu pages (**Graphs**, **Reports**, **Events**, **Alerts**).

Inventory list allows you to quickly check the status of the monitored systems. It also provides a quick overview of the key metrics being reported. When you hover on a particular system, the UI element will extend a little bit to the right, and then it is possible to unhide more information about the key metrics, such as current CPU and memory usage, traffic in and out, OS flavor and version, NGINX version.

When you extend the system UI element, you will also find two additional controls our there — namely, per-system settings, and the viewer of metadata.

You can apply sorting and search/filter to the inventory list to quickly find the system in question.

#### Preview

In the middle of the screen there's the **Preview** section where you can quickly browse and check what graphs are available, and whether there are any anomalies to be analyzed.

The graphs in the **Preview** column are split in distinct sections. Each section is a collection of graphs for a particular system. If you click on a system in the inventory list, the **Preview** column will scroll to the corresponding section. You can also just scroll the **Preview** manually to find the necessary graphs.

When you click on a graph in **Preview**, a bigger form of it appears on the right for a 'quick look' analysis. It will be highlighted with a green border, and it'll stay on top of the graphs in the **Graph feed** (see below).

Some graphs have an additional selector for the label associated with a metric. E.g. with 'Disk latency', or 'Network traffic' you can select what device or interface you're analyzing. Switching label on a graph changes the preview graph to display the corresponding data.

#### Graph feed

Section on the right is called **Graph feed**. When analyzing the graphs, you can populate this section from **Preview**. In order to do that, click on a graph's checkbox in **Preview**. The 'checked' graph from **Preview** will then be added to the bottom of the **Graph feed**. When you uncheck the graph, it'll be removed from the **Graph feed**.

You can also add the top-most graph opened earlier for a 'quick look' view to the Graph feed.

If you need to extend **Graph feed** to a bigger form, you can click on the 'expand' icon to the left of the 'Graph feed' label.

On top of the **Graph feed** you'll find controls to switch the time intervals that are applied to all graphs on the **Graphs** page. You can switch between `1H` `4H` `1D` `2D` and `1W` intervals depending on the time period you'd like to analyze.

You will also see a ruler on all graphs that might be very helpful when trying to manually correlate events.

A typical workflow when analyzing OS and/or NGINX behavior would be:

 * Browse through the graphs in **Preview**
 * With a single click sequantially bring the interesting ones to the right for a quick look
 * Populate the **Graph feed** with the graphs from **Preview** that require further analysis and correlation
 * Change time intervals for visualization to see a bigger picture
 * Scroll through the **Graph feed** matching the graphs in the feed to the 'quick look' view
 * Expand/collapse the **Graph feed** depending on the required level of detalization
 * Find anomalies, correlations, trends
 * Leave graphs in the **Graph feed** for future analysis/monitoring

In the **Graph feed** you can click on the graph title to quickly scroll **Preview** to the relevant section.

You can also just populate the **Graph** feed with the graphs you want to check regularly, and use it as a general monitoring dashboard.

State of the **Graphs** page is automatically saved, so next time you log in, you should see the same **Graph** page that you previously built for monitoring and analysis.

### Reports

Reports are based on the capabilities of the Amplify Agent to parse NGINX configuration files and provide them for further analysis through the features in the SaaS core.

The agent can also periodically invoke `nginx -t` in order to check NGINX configuration and assume the results in the report.

Config analysis and reports are *on* by default. If you don't want your NGINX configuration to be checked, configure the appropriate behavior either in Global, or Local (per-system) settings.

When you switch to the **Reports** page, click on a particular system in the inventory list in order to see the associated report. If there isn't an NGINX instance found on a system, there will be no report for it.

Currently only static analysis is done over the NGINX configuration. The following information is provided when a report is run against an NGINX config:

 * Overview information
   * path to NGINX config files(s)
   * status of parsing and testing the config  
   * first seen and last modified info
   * 3rd party modules found
   * breakdown of IPv4/IPv6 usage
   * breakdown of key configuration elements (servers, locations, upstreams)
   * OpenSSL version information
 * Static analysis
   * various suggestions about configuration structure
   * typical configuration gotchas highlighted
   * basic proxy configuration advice
   * suggestions about simplifying rewrites for certain use cases
   * basic security measures (e.g. *stub_status* is unprotected)
   * typical errors in configuring locations, esp. with *regex*

Static analysis will only include information about specific issues with the NGINX configuration if those are found in your NGINX setup.

Going further, the **Reports** section will also include *dynamic analysis*, effectively linking the observed NGINX behavior to its configuration (e.g. when it makes sense to increase or decrease certain parameter etc.). Stay tuned!

### Events

There're local (per-agent) and global events.

In order to see events generated by a particular agent, click on a host in the inventory list, and browse through local events in the middle column.

In the right-most corner you'll see SaaS-wide events such as general notifications about Amplify updates or outages.

### Alerts

Alerts page describes configuration of system monitors and associated triggers used to notify you of any anomalies in your systems' behavior.

Alerts are based on setting a monitor for a particular metric. When the monitor is being set you will also be able to specify the threshold, and the email for notifications. You can use any email, e.g. your PagerDuty email routing for that.

**Note.** Emails are sent using [AWS SES](https://aws.amazon.com/ses/). Make sure your mail relay accepts their traffic.

The way monitors and alerts work is the following:

 1. Metrics are being continuously monitored against the rulesets
 2. If there's a rule for a metric, the new metric update is checked to violate the threshold
 3. If the threshold is met, alert notification is generated (the rule will continue to be monitored)
 4. If subsequent metric updates show that the metric doesn't violate anymore the threshold for the configured period, the alert is cleared.

For the thresholds you should currently use metrics' absolute values. `E.g. for something like XXXX you should use 14747920 to set the threshold of XX KB/s.` Please see the **Metrics** section below for more information about metric names, and their descriptions.
 
**Note.** Metrics are averaged over the interval configured in the ruleset. Currently this is the only reduce function available for configurating metric thresholds.

You shouldn't see continuous redundant notifications about the same single alert over and over again. Instead there will be digest information sent out every 30m, describing what alerts were generated and which ones were cleared.

Monitors are generally 'across all systems' — meaning, there's no filtering by hostname by default. If a specific alert should only be raised for a particular host, you should specify the hostname in question in the ruleset.

### Settings

There's the **Settings** option in the 'hamburger' menu at the top right corner of the UI — that describes global settings.

Global settings are used to set account-wide behavior for:

 * Analyzing NGINX configuration files
 * Checking NGINX configuration syntax
 * Checking SSL certs and configuration (currently not implemented)

Local settings are accessible via the 'settings' icon in the inventory list (you'd need to extend a particular system box first to access additional functions).

Local settings override corresponding global setting on a per-object basis. E.g. if you'd generally want to monitor your NGINX configurations for everything but specific systems, you can uncheck it in the their local settings.



## Metrics and metadata

## OS metrics

 * Agent
   * **amplify.agent.status**
 * CPU usage
   * **system.cpu.idle**
   * **system.cpu.iowait**
   * **system.cpu.system**
   * **system.cpu.user**
 * Disk usage
   * **system.disk.free**
   * **system.disk.in_use**
   * **system.disk.total**
   * **system.disk.used**
 * I/O
   * **system.io.iops_r**
   * **system.io.iops_w**
   * **system.io.kbs_r**
   * **system.io.kbs_w**
   * **system.io.wait_r**
   * **system.io.wait_w**
 * Load average
   * **system.load.1**
   * **system.load.15**
   * **system.load.5**
 * Memory usage
   * **system.mem.available**
   * **system.mem.buffered**
   * **system.mem.cached**
   * **system.mem.free**
   * **system.mem.pct_used**
   * **system.mem.shared**
   * **system.mem.total**
   * **system.mem.used**
 * Network
   * **system.net.bytes_rcvd**
   * **system.net.bytes_sent**
   * **system.net.drops_in.count**
   * **system.net.drops_out.count**
   * **system.net.listen_overflows**
   * **system.net.packets_in.count**
   * **system.net.packets_in.error**
   * **system.net.packets_out.count**
   * **system.net.packets_out.error**
 * Swap
   * **system.swap.free**
   * **system.swap.pct_free**
   * **system.swap.total**
   * **system.swap.used**

### NGINX metrics

 * Cache
   * **nginx.cache.bypass**
   * **nginx.cache.expired**
   * **nginx.cache.fs.errors**
   * **nginx.cache.hit**
   * **nginx.cache.lock.timeouts**
   * **nginx.cache.miss**
   * **nginx.cache.revalidated**
   * **nginx.cache.stale**
   * **nginx.cache.updating**
 * HTTP
   * **nginx.http.conn.accepted**
   * **nginx.http.conn.active**
   * **nginx.http.conn.current**
   * **nginx.http.conn.dropped**
   * **nginx.http.conn.idle**
   * **nginx.http.gzip.ratio**
   * **nginx.http.method.delete**
   * **nginx.http.method.get**
   * **nginx.http.method.head**
   * **nginx.http.method.options**
   * **nginx.http.method.post**
   * **nginx.http.method.put**
   * **nginx.http.request.body_bytes_sent**
   * **nginx.http.request.buffered**
   * **nginx.http.request.bytes_sent**
   * **nginx.http.request.count**
   * **nginx.http.request.current**
   * **nginx.http.request.failed**
   * **nginx.http.request.length**
   * **nginx.http.request.limited**
   * **nginx.http.request.malformed**
   * **nginx.http.request.reading**
   * **nginx.http.request.time**
   * **nginx.http.request.time.count**
   * **nginx.http.request.time.max**
   * **nginx.http.request.time.median**
   * **nginx.http.request.time.pctl95**
   * **nginx.http.request.writing**
   * **nginx.http.response.failed**
   * **nginx.http.ssl_handshake.failed**
   * **nginx.http.status.1xx**
   * **nginx.http.status.2xx**
   * **nginx.http.status.3xx**
   * **nginx.http.status.4xx**
   * **nginx.http.status.5xx**
   * **nginx.http.status.discarded**
   * **nginx.http.v0_9**
   * **nginx.http.v1_0**
   * **nginx.http.v1_1**
   * **nginx.http.v2**
 * Upstream
   * **nginx.upstream.connect.time**
   * **nginx.upstream.connect.time.count**
   * **nginx.upstream.connect.time.max**
   * **nginx.upstream.connect.time.median**
   * **nginx.upstream.connect.time.pctl95**
   * **nginx.upstream.fastcgi.errors**
   * **nginx.upstream.header.time**
   * **nginx.upstream.header.time.count**
   * **nginx.upstream.header.time.max**
   * **nginx.upstream.header.time.median**
   * **nginx.upstream.header.time.pctl95**
   * **nginx.upstream.health_check.failed**
   * **nginx.upstream.next.count**
   * **nginx.upstream.request.count**
   * **nginx.upstream.request.failed**
   * **nginx.upstream.response.buffered**
   * **nginx.upstream.response.failed**
   * **nginx.upstream.response.time**
   * **nginx.upstream.response.time.count**
   * **nginx.upstream.response.time.max**
   * **nginx.upstream.response.time.median**
   * **nginx.upstream.response.time.pctl95**
 * Workers
   * **nginx.workers.count**
   * **nginx.workers.cpu.system**
   * **nginx.workers.cpu.total**
   * **nginx.workers.cpu.user**
   * **nginx.workers.fds_count**
   * **nginx.workers.io.kbs_r**
   * **nginx.workers.io.kbs_w**
   * **nginx.workers.mem.rss**
   * **nginx.workers.mem.rss_pct**
   * **nginx.workers.mem.vms**
   * **nginx.workers.rlimit_nofile**
   * **nginx.workers.warn.low_conn**





