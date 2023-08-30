---
title: General
description: General questions about NGINX Amplify
weight: 10
toc: true
tags: ["docs"]
docs: "DOCS-956"
---


### What Is NGINX Amplify?

NGINX Amplify is a tool for comprehensive NGINX monitoring. With NGINX Amplify it's easy to proactively analyze and fix problems related to running and scaling NGINX-based web applications.

You can use NGINX Amplify to do the following:

  * Visualize and identify NGINX performance bottlenecks, overloaded servers, or potential DDoS attacks
  * Improve and optimize NGINX performance with intelligent advice and recommendations
  * Get notified when something is wrong with the application infrastructure
  * Plan web application capacity and performance
  * Keep track of the systems running NGINX

### Where Is NGINX Amplify Hosted?

NGINX Amplify is a SaaS and it is currently hosted in [AWS us-west-1](http://docs.aws.amazon.com/general/latest/gr/rande.html) (US West, N. California).

### Is the NGINX Amplify Agent Traffic Protected?

All communications between the Amplify Agent and the backend are done securely over SSL/TLS. The agent always initiates all traffic. The backend system doesn't set up any connections back to the agent.

### Is the NGINX Agent Traffic Protected?

The NGINX Agent and NGINX Amplify services communicate using gRPC connections securely over SSL/TLS.

### Is the NGINX Amplify Agent Code Publicly Available?

NGINX Amplify Agent is an open-source application. It is licensed under the [2-clause BSD license](https://github.com/nginxinc/nginx-amplify-agent/blob/master/LICENSE), and the code is available in [NGINX Amplify's GitHub repository](https://github.com/nginxinc/nginx-amplify-agent).

### Is the NGINX Agent Code Publicly Available?

NGINX Amplify Agent is an open-source application licensed under the [Apache License 2.0](https://github.com/nginx/agent/blob/main/LICENSE). You can find the code in the [NGINX Agent's GitHub repository](https://github.com/nginx/agent).

### What is This Question About My Password When Installing NGINX Amplify Agent?

It could be that you're starting the install script from a non-root account. In this case, you will need *sudo* rights. While it depends on a particular system configuration, with a non-root account *sudo* will typically ask for a password.
