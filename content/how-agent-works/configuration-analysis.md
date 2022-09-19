---
title: NGINX Configuration Analysis
description: Learn about NGINX Amplify Agent's configuration analysis feature.
weight: 600
toc: true
tags: ["docs"]
docs: "DOCS-000"
---

NGINX Amplify Agent can automatically find all relevant NGINX configuration files, parse them, extract their logical structure, and send the associated JSON data to the Amplify backend for further analysis and reporting. For more information on configuration analysis, please see the [Analyzer]({{< relref "/user-interface/analyzer.md" >}})) documentation.

After the agent finds a particular NGINX configuration, it then automatically starts to keep track of its changes. When a change is detected with NGINX — e.g., a master process restarts, or the NGINX config is edited, an update is sent to the Amplify backend.

{{< note >}} The agent never sends the raw unprocessed config files to the backend system. In addition, the following directives in the NGINX configuration are never analyzed — and their parameters aren't exported to the SaaS backend:
[ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key), [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate), [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file), [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file), [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate), [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file), [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret).{{< /note >}}
