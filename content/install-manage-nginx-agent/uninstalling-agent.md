---
title: Uninstalling NGINX Agent
description: Learn how to uninstall NGINX Agent.
weight: 500
toc: true
tags: ["docs"]
---

To completely delete a previously monitored system, perform the following steps:

## Uninstall NGINX

Follow the [Uninstall NGINX Agent](https://docs.nginx.com/nginx-agent/uninstall/) guide to uninstall NGINX Agent.

## Delete Systems from the Web Interface

To delete a system using the web interface, find it in the [Inventory]({{< relref "/user-interface/inventory" >}}) and select the "Trash" icon.

Note: This action doesn't stop NGINX Agent. To fully remove a monitored system, first stop and uninstall NGINX Agent, then proceed to remove the system in the web interface.

## Delete alerts

Check the [Alerts]({{< relref "/user-interface/alerts" >}}) page to delete or mute any irrelevant rules.
