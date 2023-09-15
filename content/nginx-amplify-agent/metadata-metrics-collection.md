---
title: Metadata and Metrics Collection
description: Learn how NGINX Amplify Agent collects data.
weight: 200
toc: true
tags: ["docs"]
docs: "DOCS-964"
---

NGINX Amplify Agent collects the following types of data:

  * **NGINX metrics.** NGINX Amplify Agent collects a lot of NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), the NGINX Plus status API, the NGINX log files, and from the NGINX process state.
  * **System metrics.** These are various key metrics describing the system, e.g., CPU usage, memory usage, network traffic, etc.
  * **PHP-FPM metrics.** NGINX Amplify Agent can obtain metrics from the PHP-FPM pool status if it detects a running PHP-FPM main process.
  * **MySQL metrics.** NGINX Amplify Agent can obtain metrics from the MySQL global status set of variables.
  * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, the path to the binary, build configuration options, etc. NGINX metadata also includes the NGINX configuration elements.
  * **System metadata.** This is the basic information about the OS environment where NGINX Amplify Agent runs. This can be the hostname, uptime, OS flavor, and other data.

NGINX Amplify Agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the metrics, but occasionally it may also invoke certain system utilities like *ps(1)*.

While NGINX Amplify Agent is running on the host, it collects metrics at regular 20 second intervals. Metrics then get downsampled and sent to the Amplify backend once a minute.

Metadata is also reported every minute. Changes in the metadata can be examined through the Amplify web interface.

NGINX config updates are reported only when a configuration change is detected.

If NGINX Amplify Agent can't reach the Amplify backend to send the accumulated metrics, it will continue to collect metrics. Once the connectivity is re-established, it will send them over to Amplify. The maximum amount of data NGINX Amplify Agent can buffer is about 2 hours.
