---
title: NGINX Agent Overview
description: Learn about the NGINX Agent.
weight: 100
toc: true
tags: ["docs"]
---

NGINX Agent is a companion daemon for your NGINX Open Source or NGINX Plus instance. Its role is to collect various metrics and metadata and send them securely to the backend for storage and visualization.

You will need to install the NGINX Agent on all hosts that you wish to monitor.

After installation, the agent will automatically start to report metrics. You should see the real-time metrics data in the NGINX Amplify web interface in about 2 minutes.

NGINX Agent can currently monitor and collect performance metrics for:

  1. Operating system (see the list of supported OS [here]({{< relref "/faq/nginx-amplify-agent#what-operating-systems-are-supported" >}})))
  2. NGINX Open Source Instance and NGINX Plus

{{< note >}}The support for reporting NGINX Plus metrics using NGINX Agent is limited. Displaying metrics specific to a `server_zone` is not supported. {{< /note >}}

The agent considers an NGINX instance to be any running NGINX master process that has a unique path to the binary or a unique configuration.

{{< note >}}There's no need to manually add or configure anything in the web interface after installing the agent. When the agent is started, the metrics and the metadata are automatically reported to the Amplify backend and visualized in the web interface.{{< /note >}}

When a NGINX instance is no longer in use it must be manually deleted in the web interface. The "Remove object" button can be found in the metadata viewer popup — see the [User Interface]({{< relref "/user-interface/">}}) documentation.

Check out the [NGINX Agent documentation](https://docs.nginx.com/nginx-agent/overview/) to learn more about how the NGINX Agent works. 