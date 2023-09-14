---
title: Account Settings
description: Learn about the Account settings for the User Interface.
weight: 70
toc: true
tags: ["docs"]
docs: "DOCS-978"
---

The **Account** option in the user menu at the top right corner of the user interface povides access to several user settings.

### Account Information

In the Account section, you can check the information you provided upon signing up and edit specific fields.

### Limits

You can also see the current limits such as "maximum number of agents", "maximum number of custom dashboards", etc.

### User Roles

In the **Users** section, you can review the list of the user logins that are associated with this particular account. If you are the admin user, you can also invite your team members to the account.

Users can be assigned one of the three roles — Admin, User, or Read-Only. Admin users are allowed to use all the Amplify User Interface functions, add/remove users, and modify everything. The User role is almost unrestricted except for managing other users. Read-only users can't modify graphs or manage users — this role can be useful for your support team members.

### Notifications

In the **Notifications** section, you will find information about the emails currently registered with your account and whether they are verified or not. The alert notifications are only sent to verified emails.

In addition to the email alert notifications, you can optionally configure the integration with your Slack team and workspace. Under the registered emails section, select the "Add to Slack" button to allow Amplify to send you certain notifications on Slack. You will have to log in and provide the necessary details about your team and what channels you'd like to add to Amplify notifications. Both direct messages and channels can be used for notifications. If configured successfully, Amplify can send alert information to Slack. A few more additional notifications are available — e.g., NGINX Amplify Agent not finding a running nginx instance, but also proactive messages about the issues with the SSL certs.


{{< img src="amplify-notifications.png" alt="Notifications" >}}

### Agent Settings

The "Agent settings section is where you enable or disable account-wide behavior for:

  * NGINX configuration files analysis
  * Periodic NGINX configuration syntax checking with "nginx -t"
  * Analyzing SSL certs

Per-system settings are accessible via the "Settings" icon that can be found for a particular NGINX on the [**Analyzer**]({{< relref "/analyzer.md" >}}) page. Per-system settings override the global settings. If you prefer to monitor your NGINX configurations on all but some specific systems, you can uncheck the corresponding settings.
