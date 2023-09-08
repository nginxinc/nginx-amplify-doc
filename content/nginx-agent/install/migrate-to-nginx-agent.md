---
title: Migrating from Amplify Agent to NGINX Agent
description: Learn how to migrate to the NGINX Agent from the Amplify Agent.
weight: 200
toc: true
tags: ["docs"]
---

This stepwise guide will walk you through how to migrate to the NGINX Agent from a previous Amplify Agent deployment. For more indepth details on how to install the NGINX Agent please see the [install docs]({{< relref "/nginx-agent/install/installing-nginx-agent" >}}).

## Migrate to NGINX Agent

1. Connect to your data plane instance

Using your preferred method connect to your data plane instance that is currently running NGINX and the Amplify Agent.

2. Stop your running Amplify Agent

```bash
sudo systemctl stop amplify-agent
```

**Note:** The new NGINX Agent can run alongside the old Amplify Agent. If you would like to ensure the new NGINX Agent is running as expected you may optionally defer this step til the end.

3. (Optional) Ensure NGINX Agent is available

The NGINX Agent uses a different endpoint to submit data than the Amplify Agent. If need be please ensure that the endpoint `receiver-grpc.amplify.nginx.com` on port `443` is available from src instances.

4. Locate your API key

* In the UI click on the drop down for your account
* In the drop down select the Account option
* Your account details will contain your API key which you will need to copy for the next step

5. Install the NGINX Agent with your API key

On your same data plane instance that is now presently only running NGINX run the following to install the NGINX Agent:

```bash
curl -sS -L -O \
https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install-nginx-agent.sh && \
API_KEY='YOUR_API_KEY' sh ./install-nginx-agent.sh
```
Using your API key which you identified in your previous step replace `YOUR_API_KEY`.

6. Verify that the NGINX Agent is running

```bash
$ ps ax | grep -i 'nginx-agent'
  33764 ?        Ssl    0:18 /usr/bin/nginx-agent
```

If successful you ought to see the executable running the NGINX Agent along with its process ID.

**Note:** The NGINX Agent ought to also be enabled on system reboot running as `nginx-agent`.

7. Clean up existing Amplify Agent

At this point you have fully migrated over from the old Amplify Agent to the new NGINX Agent. Shortly after startup the NGINX Agent will communicate with our services and you should see it listed in the `Systems` inventory of our UI.

Within the `Systems` inventory you may now safely remove the Amplify Agent as it is no longer in use.

Note: Our services don’t offer data contiguity between the agents that were monitoring the active NGINX instance. If you wish to retain the metrics from the previous Amplify Agent for historical purposes you may delete the old Amplify Agent from the `Systems` inventory in the UI at a later time.
