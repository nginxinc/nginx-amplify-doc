---
title: "Changelog"
description: "These release notes list and describe the new features, enhancements, and resolved issues in NGINX Amplify"
weight: 800
toc: true
---

## August 28, 2023

### What's New

- {{% icon-feature %}} **NGINX Agent Compatibility (Beta)**

  The NGINX Amplify team is pleased to announce beta support for the [NGINX Agent](https://github.com/nginx/agent).  The NGINX Agent is an open-source companion daemon for your NGINX Open Source or NGINX Plus instance. It enables remote management of NGINX configurations, collection and reporting of real-time NGINX performance and operating system metrics, and notifications of NGINX events. The NGINX Agent is written in Go and acts as a drop-in replacement for the Amplify Agent, with the benefit of not having a Python
  dependency.

  The NGINX Agent supports the same NGINX and OS metrics as the Amplify Agent, but does not yet provide full feature parity.  While we continue to add features please give it a try and let us know what you think.  You can learn more about NGINX Agent by referring to the [NGINX Agent Documentation](https://docs.nginx.com/nginx-agent/).  For more information about what features are not yet supported see the compatibility table below or visit the [Known Issues]({{< relref "/known-issues.md" >}}) topic.

  {{<bootstrap-table "table table-striped table-bordered">}}

| Feature                     | Amplify Agent | NGINX Agent |
|-----------------------------|---------------|-------------|
| Application Health Score    |     Yes       |     Yes     |
| NGINX Config Analysis       |     Yes       |     Yes     |
| OS Metrics                  |     Yes       |     Yes     |
| NGINX Metrics               |     Yes       |     Yes     |
| PHP-FPM Metrics             |     Yes       |     No      |
| MySQL Metrics               |     Yes       |     No      |
| Agent Metrics               |     Yes       |     No      |
| Metric Filters              |     Yes       |     No      |
| Multiple NGINX Instances    |     Yes       |     No      |

{{</bootstrap-table>}}


## July 26, 2023

### What's New
 
- {{% icon-feature %}} **Configure Slack Notifications in Beta UI and other bug fixes**

  The Beta UI now supports adding Slack channels when configuring notifications in the Settings -> Notifications page. (Issue 907)

  A number of cosmetic and performance related bugs have also been fixed.

## July 14th, 2023

 ### What's New

This release includes the following updates:

- {{% icon-feature %}} **NGINX Amplify Beta User Interface**

  The new Amplify user interface is in beta! To enable it, you can select the  **Try New UI** button in the upper right corner of your browser.  Please give it a try and let us know what you think by selecting **Give Feedback** in the upper right corner of your browser window.

  If you want to revert to the classic user interface, you can navigate to the Settings page by selecting the gear icon in the upper right corner of your browser and selecting **Switch to Classic UI**.


### Known Issues

- You can find information about known issues with NGINX Amplify in the [Known Issues]({{< relref "/known-issues.md" >}}) topic.
