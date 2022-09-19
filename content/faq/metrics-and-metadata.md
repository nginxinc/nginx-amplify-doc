---
title: NGINX Amplify Metrics and Metadata
description: Questions about NGINX Amplify's Metrics and Metadata
weight: 40
toc: true
tags: ["docs"]
docs: "DOCS-000"
---

### What Metrics and Metadata are Collected?

NGINX Amplify Agent collects the following types of data:

* **NGINX metrics.** The agent collects a lot of NGINX related metrics from [stub_status](http://nginx.org/en/docs/http/ngx_http_stub_status_module.html), the NGINX Plus status API, the NGINX log files, and from the NGINX process state.

* **System metrics.** These are various key metrics describing the system, e.g. CPU usage, memory usage, network traffic, etc.

* **PHP-FPM metrics.** The agent can obtain metrics from the PHP-FPM pool status, if it detects a running PHP-FPM master process.

* **NGINX metadata.** This is what describes your NGINX instances, and it includes package data, build information, the path to the binary, build configuration options, etc. NGINX metadata also includes the NGINX configuration elements.

* **System metadata.** This is the basic information about the OS environment where the agent runs. This could be the hostname, uptime, OS flavor, and other data.

The agent will mostly use Python's [psutil()](https://github.com/giampaolo/psutil) to collect the metrics, but occasionally it may also invoke certain system utilities like *ps(1)*.

To see the full list of metrics, please check the [Metrics and Medatada documentation]({{< relref "/metrics-metadata" >}}).

### How Is the NGINX Configuration Parsed and Analyzed?

The agent can automatically find all relevant NGINX configuration files, parse them, extract their logical structure, and send the associated JSON data to the Amplify backend for further analysis and reporting.

To parse SSL certificate metadata the Amplify Agent uses standard openssl(1) functions. SSL certificates are parsed and analyzed only when the corresponding [settings]({{< relref "/user-interface/account-settings" >}}) are turned on. SSL certificate analysis is *off* by default.

The agent DOES NOT ever send the raw unprocessed config files to the backend system. In addition, the following directives in the NGINX configuration are NOT analyzed — and their parameters ARE NOT exported to the SaaS backend:
[ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key), [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate), [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file), [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file), [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate), [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file), [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret).

For more information on configuration analysis and reports see the [Analyzer documentation]({{< relref "/user-interface/analyzer" >}}).
