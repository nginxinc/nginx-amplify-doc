---
title: Other Metrics
description: Learn about other metrics used by NGINX Amplify
weight: 40
toc: true
tags: ["docs"]
docs: "DOCS-000"
---


## PHP-FPM metrics

You can also monitor your PHP-FPM applications with NGINX Amplify. The agent should run in the same process environment as PHP-FPM, and be able to find the php-fpm processes with *ps(1)*, otherwise, the PHP-FPM metric collection won't work.

When the agent finds a PHP-FPM master process, it tries to auto-detect the path to the PHP-FPM configuration. When the PHP-FPM configuration is found, the agent will look up the pool definitions and the corresponding `pm.status_path` directives.

The agent will find all pools and status URIs currently configured. The agent then queries the PHP-FPM pool status(es) via FastCGI. There's no need to define HTTP proxy in your NGINX configuration that will point to the PHP-FPM status URIs.

To start monitoring PHP-FPM, follow the steps below:

1. Make sure that your PHP-FPM status is enabled for at least one pool — if it's not, uncomment the `pm.status_path` directive for the pool. For PHP7 on Ubuntu, look inside the **/etc/php/7.0/fpm/pool.d** directory to find the pool configuration files. After you've uncommented the `pm.status_path`, please make sure to restart PHP-FPM.

   ```bash
   # service php7.0-fpm restart
   ```

2. {{< important >}} Check that NGINX, the Amplify Agent, and the PHP-FPM workers are all run under the same user ID (e.g. `www-data`). You may have to change the used ID for the nginx workers, fix the nginx directories permissions, and then restart the agent too. If there are multiple PHP-FPM pools configured with different user IDs, make sure the agent's user ID is included in the group IDs of the PHP-FPM workers. This is required in order for the agent to access the PHP-FPM pool socket when querying for metrics.{{< /important >}}

3. Confirm that the listen socket for the PHP-FPM pool you want to monitor and for which you enabled `pm.status_path`, is correctly configured with `listen.owner` and `listen.group`. Look for the following directives inside the pool configuration file.

    ```
    listen.owner = www-data
    listen.group = www-data
    listen.mode = 0660
    ```

4. Confirm that the PHP-FPM listen socket for the pool exists and has the right permissions.

   ```bash
   # ls -la /var/run/php/php7.0-fpm.sock
   srw-rw---- 1 www-data www-data 0 May 18 14:02 /var/run/php/php7.0-fpm.sock
   ```

5. Confirm that you can query the PHP-FPM status for the pool from the command line:

   ```
   # SCRIPT_NAME=/status SCRIPT_FILENAME=/status QUERY_STRING= REQUEST_METHOD=GET cgi-fcgi -bind -connect /var/run/php/php7.0-fpm.sock
   ```

  Confirm that the command above returns a valid set of PHP-FPM metrics.

  **Note.** The *cgi-fcgi* tool has to be installed separately, usually from the *libfcgi-dev* package. This tool is not required for the agent to collect and report PHP-FPM metrics, however it can be used to quickly diagnose possible issues with PHP-FPM metric collection.

6. If your PHP-FPM is configured to use a TCP socket instead of a Unix domain socket, make sure you can query the PHP-FPM metrics manually with *cgi-fcgi*. Double check that your TCP socket configuration is secure (ideally, PHP-FPM pool listening on 127.0.0.1, and *listen.allowed_clients* enabled as well).

7. [Update]({{< relref "/install-manage/updating-agent.md" >}}) the agent to the most recent version.

8. Make sure that the following options are set in **/etc/amplify-agent/agent.conf**

   ```
   [extensions]
   phpfpm = True
   ```

9. Restart the agent.

   ```bash
   # service amplify-agent restart
   ```

The agent should be able to detect the PHP-FPM master and workers, obtain the access to status, and collect the necessary metrics.

With all of the above successfully configured, the result should be an additional tab displayed on the [Graphs]({{< relref "/user-interface/graphs.md" >}}) page, with the pre-defined visualization of the PHP-FPM metrics.

The PHP-FPM metrics on the [Graphs]({{< relref "/user-interface/graphs.md" >}})) page are cumulative, across all automatically detected pools. If you need per-pool graphs, go to [Dashboards]({{< relref "/user-interface/dashboards.md" >}}) and create custom graphs per pool.

Here is the list of caveats to look for if the PHP-FPM metrics are not being collected:

- No status enabled for any of the pools.
- Different user IDs used by the agent and the PHP-FPM workers, or lack of a single group (when using PHP-FPM with a Unix domain socket).
- Wrong permissions configured for the PHP-FPM listen socket (when using PHP-FPM with a Unix domain socket).
- Agent can't connect to the TCP socket (when using PHP-FPM with a TCP socket).
- Agent can't parse the PHP-FPM configuration. A possible workaround is to not have any ungrouped directives. Try to move any ungrouped directives under [global] and pool section headers.

If checking the above issues didn't help, please enable the agent's [debug log]({{< relref "/install-manage/configuring-agent.md" >}}), restart the agent, wait a few minutes, and then create an issue via Intercom. Please attach the debug log to the Intercom chat.

Below is the list of supported PHP-FPM metrics.

- ####  **php.fpm.conn.accepted**


  ```
  Type:        counter, integer
  Description: The number of requests accepted by the pool.
  Source:      PHP-FPM status (accepted conn)
  ```


- ####  **php.fpm.queue.current**


  ```
  Type:        gauge, integer
  Description: The number of requests in the queue of pending connections.
  Source:      PHP-FPM status (listen queue)
  ```


- ####  **php.fpm.queue.max**


  ```
  Type:        gauge, integer
  Description: The maximum number of requests in the queue of pending connections since FPM has started.
  Source:      PHP-FPM status (max listen queue)
  ```


- ####  **php.fpm.queue.len**


  ```
  Type:        gauge, integer
  Description: The size of the socket queue of pending connections.
  Source:      PHP-FPM status (listen queue len)
  ```


- ####  **php.fpm.proc.idle**


  ```
  Type:        gauge, integer
  Description: The number of idle processes.
  Source:      PHP-FPM status (idle processes)
  ```


- ####  **php.fpm.proc.active**


  ```
  Type:        gauge, integer
  Description: The number of active processes.
  Source:      PHP-FPM status (active processes)
  ```


- ####  **php.fpm.proc.total**


  ```
  Type:        gauge, integer
  Description: The number of idle + active processes.
  Source:      PHP-FPM status (total processes)
  ```


- ####  **php.fpm.proc.max_active**


  ```
  Type:        gauge, integer
  Description: The maximum number of active processes since FPM has started.
  Source:      PHP-FPM status (max active processes)
  ```


- ####  **php.fpm.proc.max_child**


  ```
  Type:        gauge, integer
  Description: The number of times, the process limit has been reached.
  Source:      PHP-FPM status (max children reached)
  ```


- ####  **php.fpm.slow_req**


  ```
  Type:        counter, integer
  Description: The number of requests that exceeded request_slowlog_timeout value.
  Source:      PHP-FPM status (slow requests)
  ```


## MySQL metrics

Version 1.1.0 and above of the Amplify agent has a plugin for monitoring MySQL databases. Again, the agent should run in the same process environment as MySQL, and be able to find the mysqld processes with *ps(1)*. Otherwise, the MySQL metric collection won't work.

The agent doesn't try to find and parse any existing MySQL configuration files. In order for the agent to connect to MySQL and collect the metrics, the following steps need to be performed.

To start monitoring MySQL, follow the instructions below.

1. Create a new user for the Amplify agent.

    ```bash
    $ mysql -u root -p
    [..]
    mysql> CREATE USER 'amplify-agent'@'localhost' IDENTIFIED BY 'xxxxxx';
    Query OK, 0 rows affected (0.01 sec)
   ```

2. Check that the user can read MySQL metrics.

    ```bash
    $ mysql -u amplify-agent -p
    ..
    mysql> show global status;
    +-----------------------------------------------+--------------------------------------------------+
    | Variable_name                                 | Value                                            |
    +-----------------------------------------------+--------------------------------------------------+
    | Aborted_clients                               | 0                                                |
    ..
    | Uptime_since_flush_status                     | 1993                                             |
    +-----------------------------------------------+--------------------------------------------------+
    353 rows in set (0.01 sec)
    ```

   {{< note >}} The agent doesn't use *mysql(1)* for metric collection, however it implements a similar query mechanism via a Python module.{{< /note >}}

3. [Update]({{< relref "/install-manage/updating-agent.md" >}}) the agent to the most recent version.

4. Add the following to **/etc/amplify-agent/agent.conf**

    ```
    [extensions]
    ..
    mysql = True

    [mysql]
    #host =
    #port =
    unix_socket = /var/run/mysqld/mysqld.sock
    user = amplify-agent
    password = xxxxxx
    ```

  where the password option mirrors the password from step 1 above.

5. Restart the agent.

    ```
    # service amplify-agent restart
    ```

With the above configuration steps the agent should be able to detect the MySQL master, obtain the access to status, and collect the necessary metrics. The end result should be an additional tab displayed on the [Graphs]({{< relref "/user-interface/graphs.md" >}})) page, with the pre-defined visualization of the key MySQL metrics.

If the above didn't work, please enable the agent's [debug log]({{< relref "/install-manage/configuring-agent.md#agent-logfile" >}}), restart the agent, wait a few minutes, and then create an issue via Intercom. Please attach the debug log to the Intercom chat.

The agent retrieves most of the metrics from the MySQL global [status variables](https://dev.mysql.com/doc/refman/5.7/en/server-status-variables.html).

Below is the list of supported MySQL metrics.

- ####  **mysql.global.connections**


  ```
  Type:        counter, integer
  Description: The number of connection attempts (successful or not) to the MySQL server.
  Source:      SHOW GLOBAL STATUS LIKE "Connections";
  ```


- ####  **mysql.global.questions**


  ```
  Type:        counter, integer
  Description: The number of statements executed by the server. See MySQL reference manual for details.
  Source:      SHOW GLOBAL STATUS LIKE "Questions";
  ```


- ####  **mysql.global.select**


  ```
  Type:        counter, integer
  Description: The number of times a select statement has been executed.
  Source:      SHOW GLOBAL STATUS LIKE "Com_select";
  ```


- ####  **mysql.global.insert**


  ```
  Type:        counter, integer
  Description: The number of times an insert statement has been executed.
  Source:      SHOW GLOBAL STATUS LIKE "Com_insert";
  ```


- ####  **mysql.global.update**


  ```
  Type:        counter, integer
  Description: The number of times an update statement has been executed.
  Source:      SHOW GLOBAL STATUS LIKE "Com_update";
  ```


- ####  **mysql.global.delete**


  ```
  Type:        counter, integer
  Description: The number of times a delete statement has been executed.
  Source:      SHOW GLOBAL STATUS LIKE "Com_delete";
  ```


- ####  **mysql.global.writes**


  ```
  Type:        counter, integer
  Description: Sum of insert, update, and delete counters above.
  ```


- ####  **mysql.global.commit**


  ```
  Type:        counter, integer
  Description: The number of times a commit statement has been executed.
  Source:      SHOW GLOBAL STATUS LIKE "Com_commit";
  ```


- ####  **mysql.global.slow_queries**


  ```
  Type:        counter, integer
  Description: The number of queries that have taken more than long_query_time seconds.
  Source:      SHOW GLOBAL STATUS LIKE "Slow_queries";
  ```


- ####  **mysql.global.uptime**


  ```
  Type:        counter, integer
  Description: The number of seconds that the server has been up.
  Source:      SHOW GLOBAL STATUS LIKE "Uptime";
  ```


- ####  **mysql.global.aborted_connects**


  ```
  Type:        counter, integer
  Description: The number of failed attempts to connect to the MySQL server.
  Source:      SHOW GLOBAL STATUS LIKE "Aborted_connects";
  ```


- ####  **mysql.global.innodb_buffer_pool_read_requests**


  ```
  Type:        counter, integer
  Description: The number of logical read requests.
  Source:      SHOW GLOBAL STATUS LIKE "Innodb_buffer_pool_read_requests";
  ```


- ####  **mysql.global.innodb_buffer_pool_reads**


  ```
  Type:        counter, integer
  Description: The number of logical reads that InnoDB could not satisfy from the buffer
               pool, and had to read directly from disk.
  Source:      SHOW GLOBAL STATUS LIKE "Innodb_buffer_pool_reads";
  ```


- ####  **mysql.global.innodb_buffer_pool.hit_ratio**


  ```
  Type:        gauge, percentage
  Description: Hit ratio reflecting the efficiency of the InnoDB buffer pool.
  ```


- ####  **mysql.global.innodb_buffer_pool_pages_total**


  ```
  Type:        gauge, integer
  Description: The total size of the InnoDB buffer pool, in pages.
  Source:      SHOW GLOBAL STATUS LIKE "Innodb_buffer_pool_pages_total";
  ```


- ####  **mysql.global.innodb_buffer_pool_pages_free**


  ```
  Type:        gauge, integer
  Description: The number of free pages in the InnoDB buffer pool.
  Source:      SHOW GLOBAL STATUS LIKE "Innodb_buffer_pool_pages_free";
  ```


- ####  **mysql.global.innodb_buffer_pool_util**


  ```
  Type:        gauge, percentage
  Description: InnoDB buffer pool utilization.
  ```


- ####  **mysql.global.threads_connected**


  ```
  Type:        gauge, integer
  Description: The number of currently open connections.
  Source:      SHOW GLOBAL STATUS LIKE "Threads_connected";
  ```


- ####  **mysql.global.threads_running**


  ```
  Type:        gauge, integer
  Description: The number of threads that are not sleeping.
  Source:      SHOW GLOBAL STATUS LIKE "Threads_running";
  ```
