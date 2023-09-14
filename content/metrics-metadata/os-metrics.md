---
title: OS Metrics
description: List of OS Metrics
weight: 20
toc: true
tags: ["docs"]
docs: "DOCS-974"
---

## System Metrics

- ####  **system.disk.free**
- ####  **system.disk.total**
- ####  **system.disk.used**


  ```
  Type:        gauge, bytes
  Description: System disk usage statistics.
  ```


- ####  **system.disk.in_use**


  ```
  Type:        gauge, percent
  Description: System disk usage statistics, percentage.
  ```


- ####  **system.io.iops_r**
- ####  **system.io.iops_w**


  ```
  Type:        counter, integer
  Description: Number of reads or writes per sampling window.
  ```


- ####  **system.io.kbs_r**
- ####  **system.io.kbs_w**


  ```
  Type:        counter, kilobytes
  Description: Number of kilobytes read or written.
  ```


- ####  **system.io.wait_r**
- ####  **system.io.wait_w**


  ```
  Type:        gauge, milliseconds
  Description: Time spent reading from or writing to disk.
  ```


- ####  **system.load.1**
- ####  **system.load.5**
- ####  **system.load.15**


  ```
  Type:        gauge, float
  Description: Number of processes in the system run queue, averaged over the last 1, 5,
               and 15 min.
  ```


- ####  **system.mem.available**
- ####  **system.mem.buffered**
- ####  **system.mem.cached**
- ####  **system.mem.free**
- ####  **system.mem.shared**
- ####  **system.mem.total**
- ####  **system.mem.used**


  ```
  Type:        gauge, bytes
  Description: Statistics about system memory usage.
  ```


- ####  **system.mem.pct_used**


  ```
  Type:        gauge, percent
  Description: Statistics about system memory usage, percentage.
  ```


- ####  **system.net.bytes_rcvd**
- ####  **system.net.bytes_sent**


  ```
  Type:        counter, bytes
  Description: Network I/O statistics. Number of bytes received or sent, per network
               interface.
  ```


- ####  **system.net.drops_in.count**
- ####  **system.net.drops_out.count**


  ```
  Type:        counter, integer
  Description: Network I/O statistics. Total number of inbound or outbound packets
               dropped, per network interface.
  ```


- ####  **system.net.packets_in.count**
- ####  **system.net.packets_out.count**


  ```
  Type:        counter, integer
  Description: Network I/O statistics. Number of packets received or sent, per network
               interface.
  ```


- ####  **system.net.packets_in.error**
- ####  **system.net.packets_out.error**


  ```
  Type:        counter, integer
  Description: Network I/O statistics. Total number of errors while receiving or sending,
               per network interface.
  ```


- ####  **system.net.listen_overflows**


  ```
  Type:        counter, integer
  Description: Number of times the listen queue of a socket overflowed.
  ```


- ####  **system.swap.free**
- ####  **system.swap.total**
- ####  **system.swap.used**


  ```
  Type:        gauge, bytes
  Description: System swap memory statistics.
  ```


- ####  **system.swap.pct_free**


  ```
  Type:        gauge, percent
  Description: System swap memory statistics, percentage.
  ```

## Agent Metrics

{{< note >}} Agent metrics are available only if you are using the Amplify Agent.{{< /note >}}

- ####  **amplify.agent.status**
  
   ```
   Type:        internal, integer
   Description: 1 - agent is up, 0 - agent is down.
   ```
- ####  **amplify.agent.cpu.system**
- ####  **amplify.agent.cpu.user**

   ```
   Type:        gauge, percent
   Description: CPU utilization percentage observed from NGINX Amplify Agent process.
   ```


- ####  **amplify.agent.mem.rss**
- ####  **amplify.agent.mem.vms**


  ```
  Type:        gauge, bytes
  Description: Memory utilized by NGINX Amplify Agent process.
  ```