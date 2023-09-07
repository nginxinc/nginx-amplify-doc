---
title: Update NGINX Agent
description: Learn how to update NGINX Agent.
weight: 300
toc: true
tags: ["docs"]
---

{{< important >}}
We **strongly recommend** that you regularly check for updates and install the most recent stable version of NGINX Agent.
{{< /important >}}

 1. Update NGINX Agent on Ubuntu/Debian:

    ```bash
    apt-get update && \
    apt-get install nginx-agent
    ```

 2. Update NGINX Agent on CentOS/Red Hat:

    ```bash
    yum makecache && \
    yum update nginx-agent
    ```
