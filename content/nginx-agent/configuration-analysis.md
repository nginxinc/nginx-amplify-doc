---
title: NGINX Configuration Analysis
description: Learn about NGINX Agent's configuration analysis feature.
weight: 600
toc: true
tags: ["docs"]
---

NGINX Agent scans all relevant NGINX configuration files, interprets their logical structure, and sends the data to the Amplify backend for further analysis and reporting. For more details on this, check out the [Analyzer]({{< relref "/user-interface/analyzer.md" >}}) documentation.

Once NGINX Agent identifies a specific NGINX configuration, it starts monitoring it for any changes. If it detects a change, such as a master process restart or an edited NGINX config, it sends an update to the Amplify backend.

Before sending the NGINX config to the Amplify backend, NGINX Agent reviews any `ignore_directives` set in its config file. If you installed NGINX Agent using the [install script]({{< relref "/nginx-agent/install-configure-nginx-agent/installing-agent#using-the-install-script" >}}), the following directives are already set to be ignored and their parameters won't be sent to the Amplify backend:

- [ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key)
- [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate)
- [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file)
- [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file)
- [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate)
- [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file)
- [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret)

{{< note >}} To prevent specific file contents from being uploaded to the Amplify service, add those directives to the [`ignore_directives` section in the NGINX Agent config]({{< relref "/nginx-agent/install-configure-nginx-agent/installing-agent#add-ignore-directives-to-the-agent-config-file" >}}).{{< /note >}}
