---
title: Detecting and Monitoring NGINX Instances
description: Learn how NGINX Amplify Agent detects NGINX Instances.
weight: 300
toc: true
tags: ["docs"]
docs: "DOCS-962"
---

NGINX Amplify Agent is capable of detecting several types of NGINX instances:

  * Installed from a repository package
  * Built and installed manually

A separate instance of NGINX, as seen by NGINX Amplify Agent, would be the following:

  * A unique master process and its workers, started with an **absolute path** to a distinct NGINX binary
  * A master process running with a default config path; or with a custom path set in the command-line parameters

{{< note >}}NGINX Amplify Agent will try to detect and monitor all unique NGINX instances currently running on a host. Separate sets of metrics and metadata are collected for each unique NGINX instance. {{< /note >}} 
