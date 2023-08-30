---
title: Uninstalling Amplify Agent
description: Learn how to uninstall the NGINX Agent.
weight: 500
toc: true
tags: ["docs"]
docs: "DOCS-969"
---

To completely delete a previously monitored object, perform the following steps:


### Uninstall the agent

- On Ubuntu/Debian use:

    ```bash
    apt-get remove nginx-amplify-agent
    ```

- On CentOS and Red Hat use:

    ```bash
    yum remove nginx-amplify-agent
    ```

### Delete objects from the web interface

To delete a system using the web interface — find it in the [Inventory]({{< relref "/user-interface/inventory" >}}), and click on the "Trash" icon.

Deleting objects in the UI will not stop the agent. To completely remove a system from monitoring, stop and uninstall the agent first, then clean it up in the web interface.

### Delete alerts

  Check the [Alerts]({{< relref "/user-interface/alerts" >}}) page and remove or mute the irrelevant rules.
