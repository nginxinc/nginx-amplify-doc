---
title: Install Amplify Agent
description: Learn how to install the NGINX Amplify Agent.
weight: 100
toc: true
tags: ["docs"]
docs: "DOCS-968"
---

To use NGINX Amplify to monitor your infrastructure, you need to install NGINX Amplify Agent on each system you wish to monitor.

{{< note >}} NGINX Amplify Agent will drop *root* privileges on startup. It will then use the user ID of the user `nginx` to set its effective user ID. The package install procedure will add the `nginx` user automatically unless it's already found in the system. If the [user](http://nginx.org/en/docs/ngx_core_module.html#user) directive appears in the NGINX configuration, NGINX Amplify Agent will pick up the user specified in the NGINX config for its effective user ID (e.g. `www-data`). {{< /note >}} 

## Using the Install Script

Take the following steps to install NGINX Amplify Agent:

1. Download and run the install script.

   ```bash
   curl -sS -L -O \
   https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh && \
   API_KEY='YOUR_API_KEY' sh ./install.sh
   ```

   Where YOUR_API_KEY is a unique API key assigned to your Amplify account. You will see the API key when adding a new system in the Amplify web interface. You can also find it in the **Account** menu.

2. Verify that NGINX Amplify Agent has started.

   ```bash
   ps ax | grep -i 'amplify\-'
   2552 ?        S      0:00 amplify-agent
   ```

## Installing NGINX Amplify Agent Manually

### Installing on Ubuntu or Debian

1. Add the NGINX public key.

   ```bash
   curl -fs http://nginx.org/keys/nginx_signing.key | apt-key add -
   ```

   or

   ```bash
   wget -q -O - \
   http://nginx.org/keys/nginx_signing.key | apt-key add -
   ```

2. Configure the repository as follows.

    ```bash
    codename=`lsb_release -cs` && \
    os=`lsb_release -is | tr '[:upper:]' '[:lower:]'` && \
    echo "deb http://packages.amplify.nginx.com/${os}/ ${codename} amplify-agent" > \
    /etc/apt/sources.list.d/nginx-amplify.list
    ```

3. Verify the repository config file (Ubuntu 14.04 example follows).

    ```bash
    cat /etc/apt/sources.list.d/nginx-amplify.list
    deb http://packages.amplify.nginx.com/ubuntu/ trusty amplify-agent
    ```

4. Update the package index files.

    ```bash
    apt-get update
    ```

5. Install and run NGINX Amplify Agent.

    ```bash
    apt-get install nginx-amplify-agent
    ```

### Installing on CentOS, Red Hat Linux, or Amazon Linux

1. Add the NGINX public key.

    ```bash
    curl -sS -L -O http://nginx.org/keys/nginx_signing.key && \
    rpm --import nginx_signing.key
    ```

   or

    ```bash
    wget -q -O nginx_signing.key http://nginx.org/keys/nginx_signing.key && \
    rpm --import nginx_signing.key
    ```

2. Create the repository config as follows (mind the correct release number).

   Use the first snippet below for CentOS and Red Hat Linux. The second one applies to Amazon Linux.

    ```bash
    release="7" && \
    printf "[nginx-amplify]\nname=nginx amplify repo\nbaseurl=http://packages.amplify.nginx.com/centos/${release}/\$basearch\ngpgcheck=1\nenabled=1\n" > \
    /etc/yum.repos.d/nginx-amplify.repo
    ```

    ```bash
    release="latest" && \
    printf "[nginx-amplify]\nname=nginx amplify repo\nbaseurl=http://packages.amplify.nginx.com/amzn/${release}/\$basearch\ngpgcheck=1\nenabled=1\n" > \
    /etc/yum.repos.d/nginx-amplify.repo
    ```

3. Verify the repository config file (RHEL 7.1 example follows).

    ```bash
    cat /etc/yum.repos.d/nginx-amplify.repo
    [nginx-amplify]
    name=nginx repo
    baseurl=http://packages.amplify.nginx.com/centos/7/$basearch
    gpgcheck=1
    enabled=1
    ```

4. Update the package metadata.

    ```bash
    yum makecache
    ```

5. Install and run NGINX Amplify Agent.

    ```bash
    yum install nginx-amplify-agent
    ```

## Creating the Config File from a Template

```bash
api_key="YOUR_API_KEY" && \
sed "s/api_key.*$/api_key = ${api_key}/" \
/etc/amplify-agent/agent.conf.default > \
/etc/amplify-agent/agent.conf
```

API_KEY is a unique API key assigned to your Amplify account. You will see your API key when adding a new system using the Amplify web interface. You can also find the API key in the *Account* menu.

## Starting and Stopping NGINX Amplify Agent

```bash
service amplify-agent start
```

```bash
service amplify-agent stop
```

```bash
service amplify-agent restart
```

## Verifying that NGINX Amplify Agent Has Started

```bash
ps ax | grep -i 'amplify\-'
2552 ?        S      0:00 amplify-agent
```
