---
title: Troubleshooting Metrics Collection
description: Learn what to check if the NGINX Agent isn't reporting metrics.
weight: 500
toc: true
tags: ["docs"]
---

After you [install and start]({{< relref "/install-manage-nginx-agent/installing-agent" >}}) the agent, it should start reporting right away, pushing aggregated data to the Amplify backend at regular 1 minute intervals. It'll take about a minute for a new system to appear in the Amplify web interface.

If you don't see the new system or NGINX instance in the web interface, or (some) metrics aren't being collected, please review the following:

  1. The NGINX Agent package has been successfully [installed]({{< relref "/install-manage-amp-agent/installing-agent" >}}), and no warnings were reported during the installation.
  2. The `nginx-agent` process is running and updating its [log file]({{< relref "/install-manage-nginx-agent/configuring-agent#agent-logfile" >}}).
  3. The NGINX instance is started with an absolute path. The agent **can't** detect NGINX instances launched with a relative path (e.g. "./nginx").
  4. The time is set correctly. If the time on the system where the agent runs is ahead or behind the world's clock, you won't be able to see the graphs.
  5. `stub_status` is [configured correctly]({{< relref "/how-nginx-agent-works/configuring-metric-collection" >}}), and the `stub_status module` is included in the NGINX build (this can be confirmed with `nginx -V`).
  6. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) set in NGINX config).
  7. Extra [configuration steps have been performed as required](/metrics-metadata/nginx-metrics#additional-nginx-metrics) for the additional metrics to be collected.
  8. The system DNS resolver is correctly configured, and *receiver-grpc.amplify.nginx.com* can be successfully resolved.
  9. Outbound TLS/SSL from the system to *receiver-grpc.amplify.nginx.com* is not restricted. This can be confirmed with `curl(1)`. [Configure a proxy server]({{< relref "/install-manage-nginx-agent/configuring-agent#setting-up-a-proxy" >}}) for the agent if required.
  10. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering with the metric collection. E.g., for _selinux_(8)* review **/etc/selinux/config**. Try `setenforce 0` temporarily and see if it improves the situation for certain metrics.
  