---
title: Configuring NGINX for Metric Collection
description: Learn how to configure NGINX Instances to collect data.
weight: 400
toc: true
tags: ["docs"]
---

To monitor an NGINX instance, the agent must [find the relevant NGINX master process]({{< relref "/how-nginx-agent-works/detecting-monitoring-instances" >}}) and determine its key characteristics.

## Metrics from stub_status

You must define [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) in your NGINX configuration for key NGINX graphs to appear in the web interface. If `stub_status` is already enabled, the agent should be able to locate it automatically.

If you're using NGINX Plus, you must configure either the `stub_status` module or the NGINX Plus [API module](http://nginx.org/en/docs/http/ngx_http_api_module.html).

Without `stub_status` or the NGINX Plus status API, the agent will NOT be able to collect key NGINX metrics required for further monitoring and analysis.

Add the `stub_status` configuration as follows:

```bash

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
<Ctrl-D>

# ls -la conf.d/stub_status.conf
-rw-r--r-- 1 root root 162 Nov  4 02:40 conf.d/stub_status.conf

# nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

# kill -HUP `cat /var/run/nginx.pid`
```

Test your nginx configuration after you've added the `stub_status` section above. Make sure there's no ambiguity with either [listen](http://nginx.org/en/docs/http/ngx_http_core_module.html#listen) or [server_name](http://nginx.org/en/docs/http/ngx_http_core_module.html#server_name) configuration. The agent should be able to identify the [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) URL and will default to use 127.0.0.1 if the configuration is incomplete.

{{< note >}} If you use the `conf.d*`directory to keep common parts of your NGINX configuration that are then automatically included in the [server](http://nginx.org/en/docs/http/ngx_http_core_module.html#server) sections across your NGINX config, do not use the snippet above. Instead, you should configure [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) manually within an appropriate location or server block. {{< /note >}}

The above is an example `nginx_status` URI for [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html). The agent will determine the correct URI automatically upon parsing your NGINX configuration. Please make sure that the directory and the actual configuration file with `stub_status` are readable by the agent; otherwise, the agent won't be able to determine the `stub_status` URL correctly.

Please ensure the `stub_status` [ACL](http://nginx.org/en/docs/http/ngx_http_access_module.html) is correctly configured, especially if your system is IPv6-enabled. Test the reachability of `stub_status` metrics with `wget(1)` or `curl(1)`. When testing, use the exact URL matching your NGINX configuration.

For more information about `stub_status`, please refer to the NGINX documentation [here](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html).

If everything is configured properly, you should see something along these lines when testing it with `curl(1)`:

```bash
$ curl http://127.0.0.1/nginx_status
Active connections: 2
server accepts handled requests
 344014 344014 661581
Reading: 0 Writing: 1 Waiting: 1
```

If the command doesn't produce the expected output, confirm where the requests to `/nginx_status` are being routed. In many cases other [server](http://nginx.org/en/docs/http/ngx_http_core_module.html#server) blocks can be why you can't access `stub_status`.

The agent uses data from `stub_status` to calculate metrics related to server-wide HTTP connections and requests as described below:

```nginx  
nginx.http.conn.accepted = stub_status.accepts
nginx.http.conn.active = stub_status.active - stub_status.waiting
nginx.http.conn.current = stub_status.active
nginx.http.conn.dropped = stub_status.accepts - stub_status.handled
nginx.http.conn.idle = stub_status.waiting
nginx.http.request.count = stub_status.requests
nginx.http.request.current = stub_status.reading + stub_status.writing
nginx.http.request.reading = stub_status.reading
nginx.http.request.writing = stub_status.writing
```

For NGINX Plus the agent will automatically use similar metrics available from the status API.

For more information about the metric list, please refer to [Metrics and Metadata]({{< relref "/metrics-metadata" >}}).

## Metrics from access.log and error.log

NGINX Agent will also collect more NGINX metrics from the [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and the [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files. To do that, the agent should be able to read the logs. Ensure that the `nginx` user or the user [defined in the NGINX config](http://nginx.org/en/docs/ngx_core_module.html#user) (such as `www-data`) can read the log files. Please also make sure that the log files are being written normally.

You don't have to specifically point the agent to either the NGINX configuration or the NGINX log files — it should detect their location automatically.

The agent will also try to detect the [log format](http://nginx.org/en/docs/http/ngx_http_log_module.html#log_format) for a particular log to parse it properly and try to extract even more useful metrics, e.g., [$upstream_response_time](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_upstream_response_time).

{{< note >}}Several metrics outlined in [Metrics and Metadata]({{< relref "metrics-metadata" >}}) will only be available if the corresponding variables are included in a custom [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) format used for logging requests. You can find a complete list of NGINX log variables [here](http://nginx.org/en/docs/varindex.html).{{< /note >}}

{{< note >}}NGINX Agent does not support reading the access.log or error.log files from syslog.{{< /note >}}

{{< note >}}The support for reporting NGINX Plus metrics using NGINX Agent is limited. Displaying metrics specific to a `server_zone` is not supported. {{< /note >}}