---
title: Using Amplify Agent with Docker
description: Learn how to use the NGINX Amplify Agent with Docker.
weight: 400
toc: true
tags: ["docs"]
docs: "DOCS-971"
---

You can use NGINX Amplify Agent in a Docker environment. Although it's still work-in-progress, the agent can collect most of the metrics and send them over to the Amplify backend in either "standalone" or "aggregate" mode. The standalone mode of operation is the simplest one, with a separate "host" created for each Docker container. Alternatively, the metrics from the agents running in different containers can be aggregated on a "per-image" basis — this is the aggregate mode of deploying the Amplify Agent with Docker.

For more information, please refer to our [Amplify Dockerfile](https://github.com/nginxinc/docker-nginx-amplify) repository.
