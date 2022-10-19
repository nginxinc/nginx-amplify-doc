---
title: Metadata and Metrics Collection
description: Learn how the Amplify Agent collects data.
weight: 200
toc: true
tags: ["docs"]
docs: "DOCS-000"
---

NGINX Amplify Agent collects the following types of data:

  * **NGINX metrics.** The agent collects a lot of NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), the NGINX Plus status API, the NGINX log files, and from the NGINX process state.
  * **System metrics.** These are various key metrics describing the system, e.g., CPU usage, memory usage, network traffic, etc.
  * **PHP-FPM metrics.** The agent can obtain metrics from the PHP-FPM pool status if it detects a running PHP-FPM main process.
  * **MySQL metrics.** The agent can obtain metrics from the MySQL global status set of variables.
  * **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, the path to the binary, build configuration options, etc. NGINX metadata also includes the NGINX configuration elements.
  * **System metadata.** This is the basic information about the OS environment where the agent runs. This can be the hostname, uptime, OS flavor, and other data.

The agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the metrics, but occasionally it may also invoke certain system utilities like *ps(1)*.

While the agent is running on the host, it collects metrics at regular 20 second intervals. Metrics then get downsampled and sent to the Amplify backend once a minute.

Metadata is also reported every minute. Changes in the metadata can be examined through the Amplify web interface.

NGINX config updates are reported only when a configuration change is detected.

If the agent can't reach the Amplify backend to send the accumulated metrics, it will continue to collect metrics. Once the connectivity is re-established, it will send them over to Amplify. The maximum amount of data the agent can buffer is about 2 hours.
