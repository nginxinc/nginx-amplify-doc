---
title: NGINX Configuration Analysis
description: Learn about NGINX Agent's configuration analysis feature.
weight: 600
toc: true
tags: ["docs"]
---

NGINX Agent will find all relevant NGINX configuration files, parse them, extract their logical structure, and send the associated data to the Amplify backend for further analysis and reporting. For more information on configuration analysis, please see the [Analyzer]({{< relref "/user-interface/analyzer.md" >}})) documentation.

After the agent finds a particular NGINX configuration, it then automatically starts to keep track of its changes. When a change is detected with NGINX — e.g., a master process restarts, or the NGINX config is edited, an update is sent to the Amplify backend.

{{< note >}} Before sending the NGINX Config to the Amplify backend the Agent will check for the `ignore_directives` configured in the NGINX Agent's config file. If you installed the NGINX Agent using the [install script]({{< relref "/install-manage-nginx-agent/installing-agent#using-the-install-script" >}}) the following directives in the NGINX configuration are already configured to be ignored — and their parameters aren't exported to the SaaS backend:
[ssl_certificate_key](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_certificate_key), [ssl_client_certificate](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_client_certificate), [ssl_password_file](http://nginx.org/en/docs/mail/ngx_mail_ssl_module.html#ssl_password_file), [ssl_stapling_file](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_stapling_file), [ssl_trusted_certificate](http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_trusted_certificate), [auth_basic_user_file](http://nginx.org/en/docs/http/ngx_http_auth_basic_module.html#auth_basic_user_file), [secure_link_secret](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html#secure_link_secret).{{< /note >}}

{{< note >}}Any directives that point to a file can have the contents of those files not uploaded to the NGINX Amplify services by adding those directives to the [`ignore_directive` section in the NGINX Agent config]({{< relref "/install-manage-nginx-agent/installing-agent#add-ignore-directives-to-the-agent-config-file" >}}).{{< /note >}}