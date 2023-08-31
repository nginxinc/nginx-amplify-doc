---
title: Troubleshooting Metrics Collection
description: Learn what to check if NGINX Agent isn't reporting metrics.
weight: 500
toc: true
tags: ["docs"]
---


Certainly, your text is retained, and the original links are restored:

After you [install and start]({{< relref "nginx-agent/install/installing-nginx-agent" >}}) NGINX Agent, it begins reporting data immediately. NGINX Agent sends aggregated data to the Amplify backend every minute. You should see your new system appear in the Amplify web interface within about one minute.

If you don't see your new system or NGINX instance in the web interface, or some metrics are missing, please review the following:

1. NGINX Agent has been [installed]({{< relref "/nginx-agent/install/installing-nginx-agent" >}}) with no warnings reported during installation.
2. NGINX Agent is running and updating its [log file]({{< relref "/nginx-agent/install/configuring-nginx-agent#agent-logfile" >}}).
3. Your NGINX instance starts using an absolute path; NGINX Agent can't detect instances that start with a relative path (e.g., "./nginx").
4. System time is accurate; incorrect time settings can prevent graphs from displaying.
5. `stub_status` is [properly configured]({{< relref "/nginx-agent/configuring-metric-collection" >}}), and `stub_status module` is in the NGINX build (verify this with `nginx -V`).
6. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by either the `nginx` user or the user [defined in the NGINX config](http://nginx.org/en/docs/ngx_core_module.html#user).
7. All [required additional configurations]({{< relref "/metrics-metadata/nginx-metrics#additional-nginx-metrics" >}}) are completed for collecting extra metrics.
8. The system DNS resolver is working correctly, and *receiver-grpc.amplify.nginx.com* can be resolved.
9. Outbound TLS/SSL traffic to *receiver-grpc.amplify.nginx.com* is not restricted. Confirm this with `curl(1)`. If needed, [set up a proxy server]({{< relref "/nginx-agent/install/configuring-nginx-agent#setting-up-a-proxy" >}}) for NGINX Agent.
10. Security features like *selinux(8)*, *apparmor(7)*, or [grsecurity](https://grsecurity.net) are not disrupting metric collection. For *selinux(8)* issues, consult **/etc/selinux/config** and try `setenforce 0` temporarily if needed.


