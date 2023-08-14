---
title: Installing the Agent
description: Learn how to install the NGINX Agent.
weight: 100
toc: true
tags: ["docs"]
---

To use NGINX Amplify to monitor your infrastructure, you need to install NGINX Agent on each system you wish to monitor.

## Prerequisites

- NGINX installed and running. If you don't have it installed already, follow these steps to install [NGINX](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/)
- A [supported operating system and architecture](../technical-specifications/#supported-distributions)
- `root` privilege

## Using the Install Script

Take the following steps to install the Agent:

1. Download and run the install script.

   ```bash
   curl -sS -L -O \
   https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install-nginx-agent.sh && \
   API_KEY='YOUR_API_KEY' sh ./install-nginx-agent.sh
   ```

   Where YOUR_API_KEY is a unique API key assigned to your Amplify account. You will see the API key when adding a new system in the Amplify web interface. You can also find it in the **Account** menu.

2. Verify that the agent has started.

   ```bash
   ps ax | grep -i 'nginx-agent'
   2552 ?        S      0:00 /usr/bin/nginx-agent
   ```

## Installing the Agent Manually

Take the following steps to install the Agent manually:

1. ### Installing the NGINX Agent

    Follow the instructions provided here to install the NGINX Agent manually: [NGINX Agent install instructions](https://docs.nginx.com/nginx-agent/installation-oss/)

2. ### Edit the Agent config file

   After successfully installing the NGINX Agent edit the config file present at `/etc/nginx-agent/nginx-agent.conf` to include the following block:

   ```yaml
   server:
      token: "<YOUR_API_KEY>"
      host: receiver-grpc.amplify.nginx.com
      grpcPort: 443
   ```
   Where YOUR_API_KEY is a unique API key assigned to your Amplify account. You will see the API key when adding a new system in the Amplify web interface. You can also find it in the **Account** menu.

## Starting and Stopping the Agent

```bash
service nginx-agent start
```

```bash
service nginx-agent stop
```

```bash
service nginx-agent restart
```

## Verifying that the Agent Has Started

```bash
ps ax | grep -i 'nginx-agent'
2552 ?        Ssl    0:00 /usr/bin/nginx-agent
```
