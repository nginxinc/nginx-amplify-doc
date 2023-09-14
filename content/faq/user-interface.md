---
title: NGINX Amplify User Interface
description: Questions about NGINX Amplify's User Interface
weight: 30
toc: true
tags: ["docs"]
docs: "DOCS-959"
---

### What Browsers are Supported?

Currently, the following desktop browsers are officially supported:

  * Chrome
  * Firefox
  * Safari
  * Opera

### Is the Traffic to the Web Interface Secure?

We only support SSL/TLS connections to the Amplify web interface.

### How Can I Delete a System or an NGINX Instance from NGINX Amplify?

To completely delete a previously monitored object follow these steps:

  1. Uninstall NGINX Amplify Agent
  2. Delete objects from the web interface
  3. Delete alarms

To delete a system using the web interface — find it in the [Inventory](/user-interface/inventory), and select the [i] icon. You can delete objects from the popup window that appears next.

{{< important >}}Deleting objects in the User Interface will not stop NGINX Amplify Agent. To completely remove a system from monitoring, please stop or uninstall NGINX Amplify Agent, clean it up in the web interface, and clean up any alerts.{{< /important >}}
