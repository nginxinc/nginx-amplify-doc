---
title: Metrics and Metadata Overview
description: Learn about the metrics and metadata NGINX Amplify collects.
weight: 10
toc: true
tags: ["docs"]
docs: "DOCS-972"
---

Most metrics are collected by the agent without requiring the user to perform any additional setup. For troubleshooting, see [Troubleshooting Metrics Collection]({{< relref "/nginx-agent/troubleshooting-metrics-collection.md" >}}).

Some additional metrics for NGINX monitoring will only be reported if the NGINX configuration file is modified accordingly. See [Additional NGINX Metrics]({{< relref "/metrics-metadata/nginx-metrics#additional-nginx-metrics" >}}), and review the *Source* and *Variable* fields in the metric descriptions that follow.