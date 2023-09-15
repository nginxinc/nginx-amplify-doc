---
title: Alerts
description: Learn about the Alerts page of the User Interface.
weight: 60
toc: false
tags: ["docs"]
docs: "DOCS-979"
---

The **Alerts** page describes the configuration of the alert rules used to notify you of any anomalies in the behavior of your systems.

Alerts are based on setting a rule to monitor a particular metric. Alert rules allow the user to specify the metric, the trigger condition, the threshold, and the email for notifications.

The way alert rules work is the following:

  1. Incoming metric updates are being continuously monitored against the set of rules.
  2. If there's a rule for a metric, the new metric update is checked against the threshold.
  3. If the threshold is met, an alert notification is generated, and the rule will continue to be monitored.
  4. If subsequent metric updates show that the metric no longer violates the threshold for the configured period, the alert is cleared.

By default, there's no filtering by host. If a specific alert should only be raised for a particular system, you should specify the hostname(s) or tags when configuring the alert. Currently, metrics can't be aggregated across all systems; instead, any system will match a particular rule unless a host is specified.

There's one special rule which is the about **amplify.agent.status** metric. This metric reflects the state of NGINX Amplify Agent (and hence, the state of the system as seen by Amplify). You can only configure a 2 minute interval and only 0 (zero) as the threshold for **amplify.agent.status**.

You shouldn't see consecutive notifications about the same alert repeatedly. Instead, there will be digest information sent out *every 60 minutes*, describing which alerts were generated and which ones were cleared.

{{< note >}} Gauges are *averaged* over the interval configured in the rule. Counters are *summed up*. Currently, this is not user configurable, and these are the only reduce functions available for configuring metric thresholds. {{< /note >}}

{{< note >}} Emails are sent using [AWS SES](https://aws.amazon.com/ses/). Make sure your mail relay accepts their traffic. Also, make sure to verify the specified email and check the verification status in the Account menu. {{< /note >}}
