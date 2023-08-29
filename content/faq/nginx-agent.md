---
title: NGINX Agent
description: Questions about NGINX Agent
weight: 20
toc: true
tags: ["docs"]
doctypes: ["beta"]
---

### What Operating Systems are Supported by NGINX Agent?

The NGINX Agent is officially packaged and supported only for the following Linux flavors:

  * Ubuntu 22.04 "jammy" (amd64/arm64)
  * Ubuntu 20.04 "focal" (amd64/arm64)
  * Ubuntu 18.04 "bionic" (amd64/arm64)
  * Debian 11 "bullseye" (amd64/arm64)
  * RHEL/CentOS/OEL 8 (amd64/arm64)
  * RHEL/CentOS/OEL 9 (amd64/arm64)
  * Amazon Linux 2 LTS (amd64/arm64)

If you find something that needs fixing, you're welcome to [submit a PR](https://github.com/nginx/agent/) for the issue.

### How Do I Start to Monitor My Systems with NGINX Amplify using NGINX Agent?

Instructions to [install NGINX Agent]({{< relref "/install-manage-nginx-agent/installing-agent" >}})

### What Do I Need to Configure the NGINX Agent to Report Metrics Correctly?

Once you install and launch NGINX Agent, it will immediately begin reporting, sending aggregated data to NGINX Amplify services every minute. Expect the new system to show up in the Amplify web interface within about a minute.

If the new system or NGINX doesn't appear in the web interface, or if some metrics are missing, refer to the [troubleshooting guide]({{< relref "/how-nginx-agent-works/troubleshooting-metrics-collection" >}})


### How Do I Verify that NGINX Agent Is Correctly Installed?

1. On Ubuntu/Debian use:

   ```bash
   dpkg -s nginx-agent
   ```

2. On CentOS and Red Hat use:

   ```bash
   yum info nginx-agent
   ```

### How Can I Update NGINX Agent?

Instructions to [update NGINX Agent]({{< relref "/install-manage-nginx-agent/updating-agent" >}})

### What System Resources are Required?

Expect to use under 10% of the CPU and a few dozen MBs of RSS memory. If you notice any unusual resource consumption, submit a support ticket through Intercom.

### How Do I Restart NGINX Agent?

   ```
   # service nginx-agent restart
   ```

### How Can I Uninstall NGINX Agent?

Instructions to [uninstall NGINX Agent]({{< relref "/install-manage-nginx-agent/uninstalling-agent" >}})

### Can I Use NGINX Agent with Docker?

For details, refer to the [Docker Images](https://docs.nginx.com/nginx-agent/docker-images/) topic in the NGINX Agent documentation. Note that Docker environment support is currently experimental.
