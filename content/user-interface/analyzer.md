---
title: Analyzer
description: Learn about the Analyzer page of the User Interface.
weight: 50
toc: false
tags: ["docs"]
docs: "DOCS-980"
---

NGINX Amplify Agent parses NGINX configuration files and transmits them to the backend component for further analysis. NGINX Amplify offers configuration recommendations to help improve the performance, reliability, and security of your applications. With well-thought-out and detailed recommendations, you’ll know exactly where the problem is, why it is a problem, and how to fix it.

When you switch to the **Analyzer** page, select a particular system on the left to see the associated report. If there are no NGINX instances on a system, there will be no report.

{{< img src="amplify-analyzer.png" alt="Analyzer User Interface page" >}}

The following information is provided when a report is generated from an NGINX config structure:

  * Version information
    * Branch, release date, and the latest version in the branch
  * Overview
    * Path to NGINX config files(s)
    * Whether the parser failed or not, and the results of `nginx -t`
    * Last-modified info
    * 3rd party modules found
    * Breakdown of the key configuration elements (servers, locations, upstreams)
    * Breakdown of IPv4/IPv6 usage
  * Security
    * Any security advisories that apply to this version of NGINX
  * Virtual servers
    * Breakdown of the virtual host configuration (think "apachectl -S")
  * SSL
    * OpenSSL version information
    * Breakdown of the number of SSL or HTTP/2 servers configured
    * Information about the configured SSL certificates
    * Warnings about common SSL configuration errors
  * Static analysis
    * Various suggestions about configuration structure
    * Typical configuration issues highlighted
    * Common advice about proxy configurations
    * Suggestions about simplifying rewrites for certain use cases
    * Key security measures (e.g., *stub_status* is unprotected)
    * Typical errors in configuring locations, especially with *regex*

To parse SSL certificate metadata, NGINX Amplify Agent uses standard OpenSSL(1) functions. SSL certificates are parsed and analyzed only when the corresponding [settings]({{< relref "/user-interface/account-settings" >}}) are turned on. SSL certificate analysis is *off* by default.

Static analysis will only include information about specific issues with the NGINX configuration if those are found in your NGINX setup.

In the future, the **Analyzer** page will also include *dynamic analysis*, effectively linking the observed NGINX behavior to its configuration — e.g., when it makes sense to increase or decrease certain parameters like [proxy_buffers](http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_buffers), etc.

{{< note >}} Config analysis is *on* by default. If you don't want your NGINX configuration to be checked, unset the corresponding setting in either Global, or Local (per-system) settings. See [**Settings**]({{< relref "/user-interface/account-settings" >}}). {{< /note >}}

{{< img src="amplify-analyzer-settings.png" alt="Analyzer Settings" >}}