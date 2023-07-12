---
title: Known Issues
weight: 900
description: "List of known issues in the latest release of NGINX Amplify"
toc: true
tags: ["docs"]
---

{{<rn-styles>}}

---
## July 12th, 2023

### {{% icon-bug %}} Custom Time Ranges are Not Supported {#507}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 507      | Open   |
{{</bootstrap-table>}}

#### Description

Graphs and custom dashboards only support selecting a time range from a predefined set and do not yet support selecting a custom time range.

---

### {{% icon-bug %}} Unable to Copy Existing Dashboard Widgets {#859}

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