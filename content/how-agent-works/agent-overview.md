---
title: NGINX Amplify Agent Overview
description: Learn about the NGINX Amplify Agent.
weight: 100
toc: true
tags: ["docs"]
docs: "DOCS-960"
---

NGINX Amplify Agent is a compact application written in Python. Its role is to collect various metrics and metadata and send them securely to the backend for storage and visualization.

You need to install the Amplify Agent on all hosts you want to monitor.

Once you install the NGINX Amplify Agent, it will automatically begin sending metrics. You can expect to see real-time metrics in the NGINX Amplify web interface within about a minute.

NGINX Amplify can currently monitor and collect performance metrics for:

  1. Operating system (see the list of supported OS [here]({{< relref "/faq/nginx-amplify-agent#what-operating-systems-are-supported" >}})))
  2. NGINX and NGINX Plus
  3. [PHP-FPM]({{< relref "/metrics-metadata/other-metrics.md#php-fpm-metrics" >}})
  4. [MySQL]({{< relref "/metrics-metadata/other-metrics.md#mysql-metrics" >}})

The NGINX Amplify Agent identifies an NGINX instance as any running NGINX master process with either a unique binary path or a unique configuration.

{{< note >}}There's no need to manually add or configure anything in the web interface after installing the agent. When the agent is started, the metrics and the metadata are automatically reported to the Amplify backend and visualized in the web interface.{{< /note >}}

When an NGINX instance is no longer in use it must be manually deleted in the web interface. The "Remove object" button can be found in the metadata viewer popup — see the [User Interface]({{< relref "/user-interface/">}}) documentation.