---
title: Detecting and Monitoring NGINX Instances
description: Learn how the NGINX Agent detects NGINX Instances.
weight: 300
toc: true
tags: ["docs"]
---

NGINX Agent can detect two main types of NGINX instances:

* Those installed from a [repository package](https://nginx.org/en/docs/install.html)
* Those you [build and install manually](https://nginx.org/en/docs/configure.html)

Once installed and running, NGINX Agent automatically detects the NGINX instance running on the system and begins reporting metrics. You can view real-time metrics data on the NGINX Amplify web interface within about two minutes.

To enable NGINX Agent to report additional NGINX metrics follow the instructions to [configure metric collection.]({{< relref "/how-nginx-agent-works/configuring-metric-collection" >}})

{{< note >}}NGINX Agent can't report data from multiple NGINX instances running on a single system.{{< /note >}}
