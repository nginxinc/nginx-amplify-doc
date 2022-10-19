---
title: Overview and Main Components
description: Learn about NGINX Amplify and its main components.
weight: 10
toc: true
tags: ["docs"]
docs: "DOCS-000"
---

## What Is NGINX Amplify?

[NGINX Amplify](https://amplify.nginx.com/signup/) is a tool for comprehensive NGINX monitoring. With NGINX Amplify it's easy to proactively analyze and fix problems related to running and scaling NGINX-based web applications.

You can use NGINX Amplify to do the following:

  * Visualize and identify NGINX performance bottlenecks, overloaded servers, or potential DDoS attacks
  * Improve and optimize NGINX performance with intelligent advice and recommendations
  * Get notified when something is wrong with the application infrastructure
  * Plan web application capacity and performance
  * Keep track of the systems running NGINX

## Main Components

NGINX Amplify is a SaaS product, and it's hosted on AWS public cloud. It includes the following key components:

### **NGINX Amplify Agent**

- The agent is a Python application that runs on monitored systems. All communications between the agent and the SaaS backend are done securely over SSL/TLS. All traffic is always initiated by the agent.


### **NGINX Amplify Web UI**

- The user interface compatible with all major browsers. The web interface is accessible only via TLS/SSL.


### **NGINX Amplify Backend** (Implemented as a SaaS)

- The core system component, implemented as a SaaS. It encompasses scalable metrics collection infrastructure, a database, an analytics engine, and a core API.
