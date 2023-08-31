---
title: NGINX Agent Overview
description: Learn about NGINX Agent.
weight: 1
toc: true
tags: ["docs"]
---

NGINX Agent is a companion daemon for your NGINX Open Source or NGINX Plus instance. It gathers various metrics and metadata, then securely sends this data to the backend for storage and visualization.

You need to install NGINX Agent on any hosts you want to monitor.

Once installed, NGINX Agent begins reporting metrics automatically. You can view real-time metrics data on the NGINX Amplify web interface within about two minutes.

Currently, NGINX Agent can monitor:

- [Supported operating systems]({{< relref "/faq/nginx-agent#what-operating-systems-are-supported" >}})
- NGINX Open Source and NGINX Plus instances

{{< note >}}Support for NGINX Plus metrics is limited in NGINX Agent. For example, metrics specific to a server_zone won't display.{{< /note >}}

NGINX Agent identifies an NGINX instance as any running NGINX master process with a unique binary path or unique configuration.

{{< note >}}After you install NGINX Agent, there's no need for further setup in the web interface. Metrics and metadata report automatically to the Amplify backend and appear on the web interface.{{< /note >}}

When a NGINX instance is no longer in use, you must manually deleted it in the web interface. To do this, find the "Remove object" button in the metadata viewer pop-up window. For more details, see the [User Interface]({{< relref "/user-interface/">}}) documentation.

{{<see-also>}}Check out the [NGINX Agent documentation](https://docs.nginx.com/nginx-agent/overview/) to learn more about how NGINX Agent works.{{</see-also>}}