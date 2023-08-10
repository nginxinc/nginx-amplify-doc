---
title: Uninstalling the Agent
description: Learn how to uninstall the NGINX Agent.
weight: 500
toc: true
tags: ["docs"]
---

To completely delete a previously monitored object, perform the following steps:


### Uninstall the agent

- Follow these steps to [Uninstall NGINX Agent](https://docs.nginx.com/nginx-agent/uninstall/)

### Delete objects from the web interface

To delete a system using the web interface — find it in the [Inventory]({{< relref "/user-interface/inventory" >}}), and click on the "Trash" icon.

Deleting objects in the UI will not stop the agent. To completely remove a system from monitoring, stop and uninstall the agent first, then clean it up in the web interface.

### Delete alerts

  Check the [Alerts]({{< relref "/user-interface/alerts" >}}) page and remove or mute the irrelevant rules.
