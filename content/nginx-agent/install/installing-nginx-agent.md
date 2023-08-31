---
title: Install NGINX Agent
description: Learn how to install NGINX Agent.
weight: 100
toc: true
tags: ["docs"]
---

To use NGINX Amplify to monitor your infrastructure, you need to install NGINX Agent on each system you wish to monitor.

## Prerequisites

- NGINX is installed and running. If haven't yet, follow these steps to [install NGINX](https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-open-source/)
- A [supported operating system and architecture]({{< relref "/faq/nginx-agent#what-operating-systems-are-supported" >}})
- `root` access

## Using the Install Script

To install NGINX Agent, follow these steps:

1. Download the installation script and run it.

   ```bash
   curl -sS -L -O \
   https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install-nginx-agent.sh && \
   API_KEY='YOUR_API_KEY' sh ./install-nginx-agent.sh
   ```

   Replace `YOUR_API_KEY`` with the unique API key from your Amplify account. You'll see this key when you add a new system on the Amplify website. It's also in the **Account** menu.

2. Verify NGINX Agent has started.

   ```bash
   ps ax | grep -i 'nginx-agent'
   2552 ?        S      0:00 /usr/bin/nginx-agent
   ```

## Installing NGINX Agent Manually

To manually install NGINX Agent, follow these steps:

1. ### Installing NGINX Agent

    Follow the instructions provided here to install NGINX Agent manually: [NGINX Agent install instructions](https://docs.nginx.com/nginx-agent/installation-oss/)

2. ### Update the NGINX Agent Configuration File

   After you install NGINX Agent, update the configuration file located at /etc/nginx-agent/nginx-agent.conf by adding the block below:

   ```yaml
   server:
      token: "<YOUR_API_KEY>"
      host: receiver-grpc.amplify.nginx.com
      grpcPort: 443
   ```

   Replace `YOUR_API_KEY`` with the unique API key from your Amplify account. You'll see this key when you add a new system on the Amplify website. It's also in the **Account** menu.

3. ### Add Ignore Directives to the NGINX Agent config file

   To prevent NGINX Agent from sending sensitive information from your NGINX configuration, add these directives to the `ignore_directives` list at `/etc/nginx-agent/nginx-agent.conf`:

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

## Starting and Stopping NGINX Agent

To start, stop, and restart NGINX Agent, run the following commands:

```bash
service nginx-agent start
```

```bash
service nginx-agent stop
```

```bash
service nginx-agent restart
```

## Verifying NGINX Agent Has Started

```bash
ps ax | grep -i 'nginx-agent'
2552 ?        Ssl    0:00 /usr/bin/nginx-agent
```
