---
title: Set Up NGINX for Metric Collection
description: Learn how to configure NGINX Instances to collect data.
weight: 400
toc: true
tags: ["docs"]
---

To monitor an NGINX instance, NGINX Agent must [find the relevant NGINX master process]({{< relref "/how-nginx-agent-works/detecting-monitoring-instances" >}}) and determine its key characteristics.

## Metrics from stub_status

To see key NGINX graphs in the web interface, you need to enable [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) in your NGINX configuration. If `stub_status` is already on, NGINX Agent will find it on its own.

For NGINX Plus, you need to enable either the `stub_status` module or the NGINX Plus [API module](http://nginx.org/en/docs/http/ngx_http_api_module.html) to report key NGINX metrics.

Here’s how to add `stub_status` to your configuration:

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

After adding the `stub_status`, test your NGINX configuration. Make sure the [listen](http://nginx.org/en/docs/http/ngx_http_core_module.html#listen) and [server_name](http://nginx.org/en/docs/http/ngx_http_core_module.html#server_name) settings are clear and unambiguous. NGINX Agent should recognize the `stub_status` URL, defaulting to `127.0.0.1` if incomplete.

{{< note >}}If you group common elements in your NGINX setup under the `conf.d*` directory, skip the above snippet. Instead, manually set up [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html) within an appropriate location or server block.{{< /note >}}

The example above shows an `nginx_status` URI for [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html). NGINX Agent automatically determines the correct URI when it parses your NGINX configuration. Make sure NGINX Agent can read both the directory and the specific configuration file that contains `stub_status`. Otherwise, NGINX Agent won't accurately identify the `stub_status` URL.

Make sure you've correctly set up the `stub_status` [ACL](http://nginx.org/en/docs/http/ngx_http_access_module.html), particularly if you're running an IPv6-enabled system. Test if you can reach the `stub_status` metrics using `wget(1)` or `curl(1)`. Use the exact URL that matches your NGINX configuration when testing.

For more information about `stub_status`, refer to the [NGINX documentation](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html).

If you've set up everything correctly, running a test with `curl(1)` should produce output similar to the following:

```bash
$ curl http://127.0.0.1/nginx_status
Active connections: 2
server accepts handled requests
 344014 344014 661581
Reading: 0 Writing: 1 Waiting: 1
```

If the command doesn't produce the expected output, confirm where `/nginx_status` requests are going. Often, other [server blocks](http://nginx.org/en/docs/http/ngx_http_core_module.html#server) might be the reason you can't access `stub_status`.

NGINX Agent uses data from `stub_status` to calculate various metrics related to server-wide HTTP connections and requests, as described below:

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

For NGINX Plus, NGINX Agent automatically uses similar metrics from the status API.

For more information on the types of metrics collected, refer to [Metrics and Metadata]({{< relref "/metrics-metadata" >}}).

## Metrics from access.log and error.log

NGINX Agent also gathers additional metrics from the [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files. To enable this, make sure the `nginx` user, or any user defined in the NGINX config like `www-data`, has read access to these logs. Confirm that the log files are writing data as expected.

There's no need to direct NGINX Agent to the NGINX configuration or log files—it automatically finds them.

NGINX Agent also attempts to identify the [log format](http://nginx.org/en/docs/http/ngx_http_log_module.html#log_format) for each log, enabling it to accurately parse and extract more valuable metrics, such as [$upstream_response_time](http://nginx.org/en/docs/http/ngx_http_upstream_module.html#var_upstream_response_time).

{{<note>}}
- Certain metrics listed in [Metrics and Metadata]({{< relref "metrics-metadata" >}}) are only available if the corresponding variables are included in a custom [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) format. A full list of NGINX log variables can be found [here](http://nginx.org/en/docs/varindex.html).
- NGINX Agent can't read the access.log or error.log files if they're part of a syslog.
- NGINX Agent has limited support for NGINX Plus metrics. Metrics tied to a specific `server_zone` aren't supported.
{{</note>}}
