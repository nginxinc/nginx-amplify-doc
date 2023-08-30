---
title: Metadata and Metrics Collection
description: Learn how NGINX Agent collects data.
weight: 200
toc: true
tags: ["docs"]
---

NGINX Agent collects the following types of data:

* **NGINX metrics.** NGINX Agent pulls various metrics related to NGINX from sources like [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), the NGINX Plus status API, log files, and the process state.
* **System metrics.** These include key indicators like CPU usage, memory consumption, and network traffic.
* **NGINX metadata.** This covers details about your NGINX instances, such as package info, build data, binary paths, and configuration settings.
* **System metadata.** This captures basic details about the operating environment, including the hostname, uptime, OS type, and more.

To collect these metrics, NGINX Agent mainly relies on Go's [gopsutil](https://github.com/shirou/gopsutil), although it sometimes calls system utilities like *ps(1)*.

NGINX Agent collects metrics every 15 seconds. It then aggregates this data and sends it to the Amplify backend once a minute. Metadata also updates every minute and you can review any changes on the Amplify web interface.

If there's a change in the NGINX configuration, NGINX Agent reports it specifically.

Should NGINX Agent lose connection with the Amplify backend, it keeps collecting metrics. Once the connection is restored, it sends the buffered data, with a maximum buffer capacity of about 15 minutes.

{{< note >}}NGINX Agent does not support MySQL and PHP-FPM metrics reporting to Amplify.{{< /note >}}
