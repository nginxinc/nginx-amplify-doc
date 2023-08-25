---
title: Known Issues
weight: 900
description: "List of known issues in the latest release of NGINX Amplify"
toc: true
tags: ["docs"]
---

{{<rn-styles>}}

---

### NGINX Agent does not support PHP-FPM metrics. {#647}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 647      | Open   |
{{</bootstrap-table>}}

#### Description

The [NGINX Agent](https://github.com/nginx/agent) does not yet support [PHP-FPM metrics](https://docs.nginx.com/nginx-amplify/metrics-metadata/other-metrics/#php-fpm-metrics).

### NGINX Agent does not support MySQL metrics. {#648}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 648      | Open   |
{{</bootstrap-table>}}

#### Description

The [NGINX Agent](https://github.com/nginx/agent) does not yet support [MySQL metrics](https://docs.nginx.com/nginx-amplify/metrics-metadata/other-metrics/#mysql-metrics).

### NGINX Agent does not support Agent metrics. {#650}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 650      | Open   |
{{</bootstrap-table>}}

#### Description

The [NGINX Agent](https://github.com/nginx/agent) does not yet support agent performance metrics.

* amplify.agent.status

* amplify.agent.cpu.system

* amplify.agent.cpu.user

* amplify.agent.mem.rss

* amplify.agent.mem.vms

### NGINX Agent does not support remote Agent Settings. {#679}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 679      | Open   |
{{</bootstrap-table>}}

#### Description

The NGINX Agent does not yet support remote configuration as documented in [Account Settings]({{< relref "/user-interface/account-settings.md" >}}).

#### Workaround
NGINX configuration file analysis and SSL analysis are enabled by default.  To disable NGINX configuration upload remove the **nginx-config-async** string from the feature list in the [NGINX Agent Configuration](https://docs.nginx.com/nginx-agent/configuration-overview/).  To disable SSL analysis remove **nginx-ssl-config**.

### NGINX Agent does not perform periodic `nginx -t`. {#711}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 711      | Open   |
{{</bootstrap-table>}}

#### Description
The NGINX Agent does not have the capability to run `nginx -t` periodically.

#### Workaround
You can run the `nginx -t` command manually on your NGINX instance host.

### NGINX Agent does not manage multiple NGINX instances. {#683}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 683      | Open   |
{{</bootstrap-table>}}

#### Description
The NGINX Agent can only manage one NGINX instance per system.

### NGINX Agent does not support Metric Filters. {#680}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 680      | Open   |
{{</bootstrap-table>}}

#### Description
The NGINX Agent does not support [metric filters](https://docs.nginx.com/nginx-amplify/user-interface/dashboards/).  If the NGINX Agent manages your NGINX instance, you cannot add a metric filter when you create a custom dashboard.

### {{% icon-bug %}} Inaccurate alert when NGINX agent disconnects {#988}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 988      | Open   |
{{</bootstrap-table>}}

#### Description
Host connectivity alerts may reference the incorrect server when using the NGINX Agent.

#### Workaround
The correct server to check connectivity is `receiver-grpc.amplify.nginx.com`.


### {{% icon-bug %}} NGINX Plus zone metrics not supported {#665}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 665      | Open   |
{{</bootstrap-table>}}

#### Description
NGINX Agent does not support reporting the `plus.*`` metrics per zone, but it can be used to display a cumulative sum of values from each zone.

### {{% icon-bug %}} Configuration analysis fails when NGINX root configuration is not named `nginx.conf` {#658}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 658      | Open   |
{{</bootstrap-table>}}

#### Description
Amplify cannot perform configuration analysis for NGINX instances managed by the NGINX agent when the root NGINX configuration file is not named `nginx.conf`.

#### Workarand
This issue does not affect the Amplify Agent.

### {{% icon-resolved %}} Adding new Slack integration not supported in Beta user interface. {#907}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 907      | Resolved   |
{{</bootstrap-table>}}

#### Description

Adding a new Slack channel in the Notifications Settings page does not work in the Beta user interface.

#### Workaround

Add any new Slack channel integrations in the Classic user interface.

---

### {{% icon-bug %}} Custom Time Ranges are Not Supported in Beta user interface {#507}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 507      | Open   |
{{</bootstrap-table>}}

#### Description

Graphs and custom dashboards only support selecting a time range from a predefined set and do not yet support selecting a custom time range.

---

### {{% icon-bug %}} Unable to Copy Existing Dashboard Widgets in Beta user interface {#859}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 859      | Open   |
{{</bootstrap-table>}}

#### Description

Custom dashboards do not yet support copying individual dashboard widgets to another dashboard.

#### Workaround

Default graphs can be added to dashboards, and entire dashboards can be cloned. To replicate an existing widget, it needs to be recreated directly.

---

### {{% icon-bug %}} Unable to add some NGINX HTTP requests metrics to custom graph {#631}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 631      | Open   |
{{</bootstrap-table>}}

#### Description

When trying to create a custom dashboard for the metrics nginx.http.request.reading and nginx.http.request.writing, the option to add them to the dashboard is disabled.

---