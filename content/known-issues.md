---
title: Known Issues
weight: 1000
description: "List of known issues in the latest release of NGINX Amplify"
toc: true
tags: ["docs"]
---

{{<rn-styles>}}

---

### {{% icon-bug %}} Unable to add some NGINX HTTP requests metrics to custom graph {#631}

{{<bootstrap-table "table table-striped table-bordered">}}
| Issue ID | Status |
|----------|--------|
| 631      | Open   |
{{</bootstrap-table>}}

#### Description

When trying to create a custom dashboard for the metrics nginx.http.request.reading and nginx.http.request.writing, the option to add them to the dashboard is disabled.
