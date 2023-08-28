---
title: Overview and Main Components
description: Learn about NGINX Amplify and its main components.
weight: 10
toc: true
tags: ["docs"]
docs: "DOCS-976"
---

Your text provides a comprehensive overview of what NGINX Amplify is and its main components. However, to align with your guidelines for active voice, clarity, and engagement, here's a revised version:

## What Is NGINX Amplify?

[NGINX Amplify](https://amplify.nginx.com/signup/) offers in-depth monitoring for NGINX-based web applications. It simplifies the process of analyzing and resolving issues related to performance and scalability.

With NGINX Amplify, you can:

- Spot performance issues, server overloads, and possible DDoS attacks easily.
- Receive intelligent advice to boost NGINX performance.
- Get alerts about issues in your application infrastructure.
- Plan for your web application's performance and capacity needs.
- Monitor all systems that run NGINX.

## Main Components

Hosted on the AWS public cloud, NGINX Amplify consists of several key components:

### Agents

- **Amplify Agent**: This Python app runs on the systems you're monitoring. It communicates securely with the SaaS backend using SSL/TLS. The Amplify Agent always initiates the traffic.
- **NGINX Agent**: This daemon works alongside your NGINX instance. It interacts with NGINX processes and reads logs to measure and report metrics.

### NGINX Amplify Web Interface

- Compatible with all major web browsers, this interface is only accessible through TLS/SSL.

### NGINX Amplify Backend (SaaS Implementation)

- This core system component handles metrics collection, data storage, analytics, and the core API. It's implemented as a SaaS.
