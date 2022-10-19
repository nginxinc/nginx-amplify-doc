---
title: Inventory
description: Learn about the Inventory page of the User Interface.
weight: 30
toc: false
tags: ["docs"]
docs: "DOCS-000"
---

You can access the inventory by selecting the first icon on the top menu. The inventory gives an overview of the systems that are being monitored. When the agent is running and reporting on a new system, it's listed in the system index on the left side of the user interface and in the **Inventory** section.

{{< img src="amplify-inventory.png" alt="Inventory section of the User Interface" >}}

The **Inventory** allows you to check the status of all systems at a glance. It also provides a quick overview of the key metrics.

In the rightmost column of the **Inventory**, you will find the settings and the metadata viewer icons. Select the "Info" icon to access useful information about the OS and the monitored NGINX instances. If you need to remove an object from the monitoring, select the "Trash" icon.

You can apply sorting, search, and filters to the **Inventory** to quickly find the system in question. You can search and filter by hostname, IP address, architecture, etc. You can use regular expressions with the search function.

{{< note >}} When removing an object from monitoring, keep in mind that you also need to stop or uninstall the agent on the systems being removed; otherwise, the objects will reappear in the User Interface. Be sure to delete any system-specific alert rules too.{{< /note >}}