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

3. ### Add Ignore Directives to the Agent config file

   To prevent the NGINX Agent from sending sensitive information from your NGINX Config add the following directives to the `ignore_directives` list in the NGINX Agent config file at `/etc/nginx-agent/nginx-agent.conf`:
   1. [ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key)
   2. [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate)
   3. [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file)
   4. [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file)
   5. [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate)
   6. [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file)
   7. [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret)

   ```yaml
   ignore_directives: [ssl_certificate_key, ssl_client_certificate, ssl_password_file, ssl_stapling_file, ssl_trusted_certificate, auth_basic_user_file, secure_link_secret]
   ```

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
