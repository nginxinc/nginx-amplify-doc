---
title: Troubleshooting Metrics Collection
description: Learn what to check if the NGINX Amplify Agent isn't reporting metrics.
weight: 500
toc: true
tags: ["docs"]
docs: "DOCS-966"
---

After you [install and start]({{< relref "/nginx-amplify-agent/install/installing-amplify-agent" >}}) the agent, it should start reporting right away, pushing aggregated data to the Amplify backend at regular 1 minute intervals. It'll take about a minute for a new system to appear in the Amplify web interface.

If you don't see the new system or NGINX instance in the web interface, or (some) metrics aren't being collected, please review the following:

  1. The Amplify Agent package has been successfully [installed]({{< relref "/nginx-amplify-agent/install/installing-amplify-agent" >}}), and no warnings were reported during the installation.
  2. The `amplify-agent` process is running and updating its [log file]({{< relref "/nginx-amplify-agent/install/configuring-amplify-agent#agent-logfile" >}}).
  3. The agent is running under the same user as your NGINX worker processes.
  4. The NGINX instance is started with an absolute path. The agent **can't** detect NGINX instances launched with a relative path (e.g. "./nginx").
  5. The [user ID that is used by the agent and the NGINX instance ]({{< relref "/nginx-amplify-agent/install/configuring-amplify-agent#overriding-the-effective-user-id" >}}), can run `ps(1)` to see all system processes. If `ps(1)` is restricted for non-privileged users, the agent won't be able to find and properly detect the NGINX master process.
  6. The time is set correctly. If the time on the system where the agent runs is ahead or behind the world's clock, you won't be able to see the graphs.
  7. `stub_status` is [configured correctly]({{< relref "/nginx-amplify-agent/configuring-metric-collection" >}}), and the `stub_status module` is included in the NGINX build (this can be confirmed with `nginx -V`).
  8. NGINX [access.log](http://nginx.org/en/docs/http/ngx_http_log_module.html) and [error.log](http://nginx.org/en/docs/ngx_core_module.html#error_log) files are readable by the user `nginx` (or by the [user](http://nginx.org/en/docs/ngx_core_module.html#user) set in NGINX config).
  9. All NGINX configuration files are readable by the agent user ID (check owner, group, and permissions).
  10. Extra [configuration steps have been performed as required](/metrics-metadata/nginx-metrics#additional-nginx-metrics) for the additional metrics to be collected.
  11. The system DNS resolver is correctly configured, and *receiver.amplify.nginx.com* can be successfully resolved.
  12. Outbound TLS/SSL from the system to *receiver.amplify.nginx.com* is not restricted. This can be confirmed with `curl(1)`. [Configure a proxy server]({{< relref "/nginx-amplify-agent/install/configuring-amplify-agent#setting-up-a-proxy" >}}) for the agent if required.
  13. *selinux(8)*, *apparmor(7)* or [grsecurity](https://grsecurity.net) are not interfering with the metric collection. E.g., for _selinux_(8)* review **/etc/selinux/config**. Try `setenforce 0` temporarily and see if it improves the situation for certain metrics.
  14. Some VPS providers use hardened Linux kernels that may restrict non-root users from accessing */proc* and */sys*. Metrics describing system and NGINX disk I/O are usually affected. There is no easy workaround except for allowing the agent to run as `root`. Sometimes fixing permissions for */proc* and */sys/block* may work.
  