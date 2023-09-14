---
title: NGINX Metrics
description: List of NGINX Metrics
weight: 30
toc: true
tags: ["docs"]
docs: "DOCS-973"
---

## HTTP Connections and Requests

- ####  **nginx.http.conn.accepted**
- ####  **nginx.http.conn.dropped**


  ```
  Type:        counter, integer
  Description: NGINX-wide statistics describing HTTP connections.
  Source:      stub_status (or NGINX Plus status API)
  ```


- ####  **nginx.http.conn.active**
- ####  **nginx.http.conn.current**
- ####  **nginx.http.conn.idle**


  ```
  Type:        gauge, integer
  Description: NGINX-wide statistics describing HTTP connections.
  Source:      stub_status (or NGINX Plus status API)
  ```


- ####  **nginx.http.request.count**


  ```
  Type:        counter, integer
  Description: Total number of client requests.
  Source:      stub_status (or NGINX Plus status API)
  ```


- ####  **nginx.http.request.current**
- ####  **nginx.http.request.reading**
- ####  **nginx.http.request.writing**


  ```
  Type:        gauge, integer
  Description: Number of currently active requests (reading and writing). 
               Number of requests reading headers or writing responses to clients.
  Source:      stub_status (or NGINX Plus status API)
  ```


- ####  **nginx.http.request.malformed**


  ```
  Type:        counter, integer
  Description: Number of malformed requests.
  Source:      access.log
  ```


- ####  **nginx.http.request.body_bytes_sent**


  ```
  Type:        counter, integer
  Description: Number of bytes sent to clients, not counting response headers.
  Source:      access.log
  ```


## HTTP Methods

- ####  **nginx.http.method.get**
- ####  **nginx.http.method.head**
- ####  **nginx.http.method.post**
- ####  **nginx.http.method.put**
- ####  **nginx.http.method.delete**
- ####  **nginx.http.method.options**


  ```
  Type:        counter, integer
  Description: Statistics about observed request methods.
  Source:      access.log
  ```


#### HTTP Status Codes

- ####  **nginx.http.status.1xx**
- ####  **nginx.http.status.2xx**
- ####  **nginx.http.status.3xx**
- ####  **nginx.http.status.4xx**
- ####  **nginx.http.status.5xx**


  ```
  Type:        counter, integer
  Description: Number of requests with HTTP status codes per class.
  Source:      access.log
  ```


- ####  **nginx.http.status.403**
- ####  **nginx.http.status.404**
- ####  **nginx.http.status.500**
- ####  **nginx.http.status.502**
- ####  **nginx.http.status.503**
- ####  **nginx.http.status.504**


  ```
  Type:        counter, integer
  Description: Number of requests with specific HTTP status codes above.
  Source:      access.log
  ```


- ####  **nginx.http.status.discarded**


  ```
  Type:        counter, integer
  Description: Number of requests finalized with status code 499 which is 
               logged when the client closes the connection.
  Source:      access.log
  ```


## HTTP Protocol Versions

- ####  **nginx.http.v0_9**
- ####  **nginx.http.v1_0**
- ####  **nginx.http.v1_1**
- ####  **nginx.http.v2**


  ```
  Type:        counter, integer
  Description: Number of requests using a specific version of the HTTP protocol.
  Source:      access.log
  ```


#### NGINX Process Metrics

- ####  **nginx.workers.count**


  ```
  Type:        gauge, integer
  Description: Number of NGINX worker processes observed.
  ```


- ####  **nginx.workers.cpu.system**
- ####  **nginx.workers.cpu.total**
- ####  **nginx.workers.cpu.user**


  ```
  Type:        gauge, percent
  Description: CPU utilization percentage observed for NGINX worker processes.
  ```


- ####  **nginx.workers.fds_count**


  ```
  Type:        gauge, integer
  Description: Number of file descriptors utilized by NGINX worker processes.
  ```


- ####  **nginx.workers.io.kbs_r**
- ####  **nginx.workers.io.kbs_w**


  ```
  Type:        counter, integer
  Description: Number of kilobytes read from or written to disk by NGINX worker processes.
  ```


- ####  **nginx.workers.mem.rss**
- ####  **nginx.workers.mem.vms**


  ```
  Type:        gauge, bytes
  Description: Memory utilized by NGINX worker processes.
  ```


- ####  **nginx.workers.mem.rss_pct**


  ```
  Type:        gauge, percent
  Description: Memory utilization percentage for NGINX worker processes.
  ```


- ####  **nginx.workers.rlimit_nofile**


  ```
  Type:        gauge, integer
  Description: Hard limit on the number of file descriptors as seen 
               by NGINX worker processes.
  ```


## Additional NGINX Metrics

NGINX Amplify Agent can collect many additional useful metrics described below. To enable these metrics, please make the following configuration changes. More predefined graphs will be added to the **Graphs** page if NGINX Amplify Agent finds additional metrics. With the required log format configuration, you'll can build more specific custom graphs.

The [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) log format should include an extended set of NGINX [variables](http://nginx.org/en/docs/varindex.html). Please add a new log format or modify the existing one — and use it with the `access_log` directives in your NGINX configuration.

  ```
  log_format  main_ext  '$remote_addr - $remote_user [$time_local] "$request" '
                        '$status $body_bytes_sent "$http_referer" '
                        '"$http_user_agent" "$http_x_forwarded_for" '
                        '"$host" sn="$server_name" '
                        'rt=$request_time '
                        'ua="$upstream_addr" us="$upstream_status" '
                        'ut="$upstream_response_time" ul="$upstream_response_length" '
                        'cs=$upstream_cache_status' ;
  ```

To use the extended log format with your access log configuration:

  ```
  access_log  /var/log/nginx/access.log  main_ext;
  ```

{{< note >}} Please keep in mind that by default, NGINX Amplify Agent will process all access logs that are found in your log directory. If you define a new log file with the extended log format that will contain the entries being already logged to another access log, your metrics might be counted twice. Please refer to the NGINX Amplify Agent configuration section above to learn how to exclude specific log files from processing.{{< /note >}}

The [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) log level should be set to `warn`.

  ```
  error_log  /var/log/nginx/error.log warn;
  ```

  **Note.** Don't forget to [reload](http://nginx.org/en/docs/control.html) your NGINX configuration with either `kill -HUP` or `service nginx reload`.

List of additional metrics that can be collected from the NGINX log files:

- ####  **nginx.http.request.bytes_sent**


  ```
  Type:        counter, integer
  Description: Number of bytes sent to clients.
  Source:      access.log (requires custom log format)
  Variable:    $bytes_sent
  ```


- ####  **nginx.http.request.length**


  ```
  Type:        gauge, integer
  Description: Request length, including request line, header, and body.
  Source:      access.log (requires custom log format)
  Variable:    $request_length
  ```


- ####  **nginx.http.request.time**
- ####  **nginx.http.request.time.count**
- ####  **nginx.http.request.time.max**
- ####  **nginx.http.request.time.median**
- ####  **nginx.http.request.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Request processing time — time elapsed between reading the first bytes from
               the client and writing a log entry after the last bytes were sent.
  Source:      access.log (requires custom log format)
  Variable:    $request_time
  ```


- ####  **nginx.http.request.buffered**


  ```
  Type:        counter, integer
  Description: Number of requests that were buffered to disk.
  Source:      error.log (requires 'warn' log level)
  ```


- ####  **nginx.http.gzip.ratio**


  ```
  Type:        gauge, float
  Description: Achieved compression ratio, calculated as the ratio between the original
               and compressed response sizes.
  Source:      access.log (requires custom log format)
  Variable:    $gzip_ratio
  ```


### Upstream Metrics

- ####  **nginx.upstream.connect.time**
- ####  **nginx.upstream.connect.time.count**
- ####  **nginx.upstream.connect.time.max**
- ####  **nginx.upstream.connect.time.median**
- ####  **nginx.upstream.connect.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Time spent on establishing connections with upstream servers. With SSL, it
               also includes time spent on the handshake.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_connect_time
  ```


- ####  **nginx.upstream.header.time**
- ####  **nginx.upstream.header.time.count**
- ####  **nginx.upstream.header.time.max**
- ####  **nginx.upstream.header.time.median**
- ####  **nginx.upstream.header.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Time spent on receiving response headers from upstream servers.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_header_time
  ```


- ####  **nginx.upstream.response.buffered**


  ```
  Type:        counter, integer
  Description: Number of upstream responses buffered to disk.
  Source:      error.log (requires 'warn' log level)
  ```


- ####  **nginx.upstream.request.count**
- ####  **nginx.upstream.next.count**


  ```
  Type:        counter, integer
  Description: Number of requests that were sent to upstream servers.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_*
  ```


- ####  **nginx.upstream.request.failed**
- ####  **nginx.upstream.response.failed**


  ```
  Type:        counter, integer
  Description: Number of requests and responses that failed while proxying.
  Source:      error.log (requires 'error' log level)
  ```


- ####  **nginx.upstream.response.length**


  ```
  Type:        gauge, bytes
  Description: Average length of the responses obtained from the upstream servers.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_response_length
  ```


- ####  **nginx.upstream.response.time**
- ####  **nginx.upstream.response.time.count**
- ####  **nginx.upstream.response.time.max**
- ####  **nginx.upstream.response.time.median**
- ####  **nginx.upstream.response.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Time spent on receiving responses from upstream servers.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_response_time
  ```


- ####  **nginx.upstream.status.1xx**
- ####  **nginx.upstream.status.2xx**
- ####  **nginx.upstream.status.3xx**
- ####  **nginx.upstream.status.4xx**
- ####  **nginx.upstream.status.5xx**


  ```
  Type:        counter, integer
  Description: Number of responses from upstream servers with specific HTTP status codes.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_status
  ```


### Cache Metrics

- ####  **nginx.cache.bypass**
- ####  **nginx.cache.expired**
- ####  **nginx.cache.hit**
- ####  **nginx.cache.miss**
- ####  **nginx.cache.revalidated**
- ####  **nginx.cache.stale**
- ####  **nginx.cache.updating**


  ```
  Type:        counter, integer
  Description: Various statistics about NGINX cache usage.
  Source:      access.log (requires custom log format)
  Variable:    $upstream_cache_status
  ```


## NGINX Plus Metrics

In [NGINX Plus](https://www.nginx.com/products/) several additional metrics describing various aspects of NGINX performance are available. The [API module](http://nginx.org/en/docs/http/ngx_http_api_module.html) in NGINX Plus is responsible for collecting and exposing all of the additional counters and gauges.

The NGINX Plus metrics currently supported by NGINX Amplify Agent are described below. The NGINX Plus metrics have the "plus" prefix in their names.

Some of the NGINX Plus metrics extracted from the `connections` and the `requests` datasets are used to generate the following server-wide metrics (instead of using the *stub_status* metrics):

```
nginx.http.conn.accepted = connections.accepted
nginx.http.conn.active = connections.active
nginx.http.conn.current = connections.active + connections.idle
nginx.http.conn.dropped = connections.dropped
nginx.http.conn.idle = connections.idle
nginx.http.request.count = requests.total
nginx.http.request.current = requests.current
```

The NGINX Plus metrics below are collected *per zone*. When configuring a graph using these metrics, please make sure to pick the correct server, upstream, or cache zone. A more granular peer-specific breakdown of the metrics below is currently not supported in NGINX Amplify.

{{< note >}}NGINX Amplify Agent does not support reporting the following metrics *per zone* but it can be used to display a cumulative sum of values from each zone.{{< /note >}}

A cumulative metric set is also maintained internally by summing up the per-zone metrics. If you don't configure a specific zone when building graphs, this will result in an "all zones" visualization. E.g., for something like **plus.http.status.2xx** omitting zone will display the instance-wide sum of the successful requests across all zones.

### Server Zone Metrics

- ####  **plus.http.request.count**
- ####  **plus.http.response.count**


  ```
  Type:        counter, integer
  Description: Number of client requests received, and responses sent to clients.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.request.bytes_rcvd**
- ####  **plus.http.request.bytes_sent**


  ```
  Type:        counter, bytes
  Description: Number of bytes received from clients, and bytes sent to clients.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.status.1xx**
- ####  **plus.http.status.2xx**
- ####  **plus.http.status.3xx**
- ####  **plus.http.status.4xx**
- ####  **plus.http.status.5xx**


  ```
  Type:        counter, integer
  Description: Number of responses with status codes 1xx, 2xx, 3xx, 4xx, and 5xx.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.status.discarded**


  ```
  Type:        counter, integer
  Description: Number of requests completed without sending a response.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.ssl.handshakes**


  ```
  Type:        counter, integer
  Description: Total number of successful SSL handshakes.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.ssl.failed**


  ```
  Type:        counter, integer
  Description: Total number of failed SSL handshakes.
  Source:      NGINX Plus status API
  ```


- ####  **plus.http.ssl.reuses**


  ```
  Type:        counter, integer
  Description: Total number of session reuses during SSL handshake.
  Source:      NGINX Plus status API
  ```


### Upstream Zone Metrics

- ####  **plus.upstream.peer.count**


  ```
  Type:        gauge, integer
  Description: Current number of live ("up") upstream servers in an upstream group. If
               graphed/monitored without specifying an upstream, it's the current
               number of all live upstream servers in all upstream groups.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.request.count**
- ####  **plus.upstream.response.count**


  ```
  Type:        counter, integer
  Description: Number of client requests forwarded to the upstream servers, and responses obtained.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.conn.active**


  ```
  Type:        gauge, integer
  Description: Current number of active connections to the upstream servers.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.conn.keepalive**


  ```
  Type:        gauge, integer
  Description: Сurrent number of idle keepalive connections.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.zombies**


  ```
  Type:        gauge, integer
  Description: Current number of servers removed from the group but still processing
               active client requests.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.bytes_rcvd**
- ####  **plus.upstream.bytes_sent**


  ```
  Type:        counter, integer
  Description: Number of bytes received from the upstream servers, and bytes sent.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.status.1xx**
- ####  **plus.upstream.status.2xx**
- ####  **plus.upstream.status.3xx**
- ####  **plus.upstream.status.4xx**
- ####  **plus.upstream.status.5xx**


  ```
  Type:        counter, integer
  Description: Number of responses from the upstream servers with status codes 1xx, 2xx,
               3xx, 4xx, and 5xx.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.header.time**
- ####  **plus.upstream.header.time.count**
- ####  **plus.upstream.header.time.max**
- ####  **plus.upstream.header.time.median**
- ####  **plus.upstream.header.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Average time to get the response header from the upstream servers.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.response.time**
- ####  **plus.upstream.response.time.count**
- ####  **plus.upstream.response.time.max**
- ####  **plus.upstream.response.time.median**
- ####  **plus.upstream.response.time.pctl95**


  ```
  Type:        gauge, seconds.milliseconds
  Description: Average time to get the full response from the upstream servers.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.fails.count**
- ####  **plus.upstream.unavail.count**


  ```
  Type:        counter, integer
  Description: Number of unsuccessful attempts to communicate with upstream servers, and
               how many times upstream servers became unavailable for client requests.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.health.checks**
- ####  **plus.upstream.health.fails**
- ####  **plus.upstream.health.unhealthy**


  ```
  Type:        counter, integer
  Description: Number of performed health check requests, failed health checks, and
               how many times the upstream servers became unhealthy.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.queue.size**


  ```
  Type:        gauge, integer
  Description: Current number of queued requests.
  Source:      NGINX Plus status API
  ```


- ####  **plus.upstream.queue.overflows**


  ```
  Type:        counter, integer
  Description: Number of requests rejected due to queue overflows.
  Source:      NGINX Plus status API
  ```


### Cache Zone Metrics

- ####  **plus.cache.bypass**
- ####  **plus.cache.bypass.bytes**
- ####  **plus.cache.expired**
- ####  **plus.cache.expired.bytes**
- ####  **plus.cache.hit**
- ####  **plus.cache.hit.bytes**
- ####  **plus.cache.miss**
- ####  **plus.cache.miss.bytes**
- ####  **plus.cache.revalidated**
- ####  **plus.cache.revalidated.bytes**
- ####  **plus.cache.size**
- ####  **plus.cache.stale**
- ####  **plus.cache.stale.bytes**
- ####  **plus.cache.updating**
- ####  **plus.cache.updating.bytes**


  ```
  Type:        counter, integer; counter, bytes
  Description: Various statistics about NGINX Plus cache usage.
  Source:      NGINX Plus status API
  ```


### Stream Zone Metrics

- ####  **plus.stream.conn.active**


  ```
  Type:        gauge, integer
  Description: Current number of client connections that are currently being processed.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.conn.accepted**


  ```
  Type:        counter, integer
  Description: Total number of connections accepted from clients.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.status.2xx**
- ####  **plus.stream.status.4xx**
- ####  **plus.stream.status.5xx**


  ```
  Type:        counter, integer
  Description: Number of sessions completed with status codes 2xx, 4xx, or 5xx.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.discarded**


  ```
  Type:        counter, integer
  Description: Total number of connections completed without creating a session.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.bytes_rcvd**
- ####  **plus.stream.bytes_sent**


  ```
  Type:        counter, integer
  Description: Number of bytes received from clients, and bytes sent.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.peers**


  ```
  Type:        gauge, integer
  Description: Current number of live ("up") upstream servers in an upstream group.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.conn.active**


  ```
  Type:        gauge, integer
  Description: Current number of connections.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.conn.count**


  ```
  Type:        counter, integer
  Description: Total number of client connections forwarded to this server.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.conn.time**
- ####  **plus.stream.upstream.conn.time.count**
- ####  **plus.stream.upstream.conn.time.max**
- ####  **plus.stream.upstream.conn.time.median**
- ####  **plus.stream.upstream.conn.time.pctl95**


  ```
  Type:        timer, integer
  Description: Average time to connect to an upstream server.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.conn.ttfb**


  ```
  Type:        timer, integer
  Description: Average time to receive the first byte of data.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.response.time**


  ```
  Type:        timer, integer
  Description: Average time to receive the last byte of data.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.bytes_sent**
- ####  **plus.stream.upstream.bytes_rcvd**


  ```
  Type:        counter, integer
  Description: Number of bytes received from upstream servers, and bytes sent.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.fails.count**
- ####  **plus.stream.upstream.unavail.count**


  ```
  Type:        counter, integer
  Description: Number of unsuccessful attempts to communicate with upstream servers, and
               how many times upstream servers became unavailable for client requests.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.health.checks**
- ####  **plus.stream.upstream.health.fails**
- ####  **plus.stream.upstream.health.unhealthy**


  ```
  Type:        counter, integer
  Description: Number of performed health check requests, failed health checks, and
               how many times the upstream servers became unhealthy.
  Source:      NGINX Plus status API
  ```


- ####  **plus.stream.upstream.zombies**


  ```
  Type:        gauge, integer
  Description: Current number of servers removed from the group but still
               processing active client connections.
  Source:      NGINX Plus status API
  ```


### Slab Zone Metrics

- ####  **plus.slab.pages.used**


  ```
  Type:        gauge, integer
  Description: Сurrent number of used memory pages.
  Source:      NGINX Plus status API
  ```


- ####  **plus.slab.pages.free**


  ```
  Type:        gauge, integer
  Description: Сurrent number of free memory pages.
  Source:      NGINX Plus status API
  ```


- ####  **plus.slab.pages.total**


  ```
  Type:        gauge, integer
  Description: Sum of free and used memory pages above.
  ```


- ####  **plus.slab.pages.pct_used**


  ```
  Type:        gauge, percentage
  Description: Percentage of free pages.
  ```
