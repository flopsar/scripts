Flopsar Database Startup Scripts
================================
Scripts for starting and stopping Flopsar Proxy or Flopsar DBASE on Linux.
Scripts are intended to be used on RedHat/Centos distros, however they can be easily adopted on other Linux flavours.

##Assumptions
1. Flopsar Proxy/DBASE is installed in /opt/flopsar (DBASE_DIR)
2. Flopsar Proxy/DBASE will be running under non-privileged account named "flopsar"

##Script Installation
1. As root create dedicated user account:
```bash
[root@host ~]# useradd flopsar
```
2. Set adequate permissions, for example:
```bash
[root@host ~]# chown -R flopsar:flopsar /opt/flopsar
```
3. Copy .sh scripts to /opt/flopsar and set permissions for root, ie.
```bash
[root@host ~]# chown -R root:root /opt/flopsar/flopsar-*.sh
[root@host ~]# chmod 750 /opt/flopsar/flopsar-*.sh

```

## Service installation
1. As root link scripts:
```bash
[root@host ~]# ln -s /opt/flopsar/flopsar-dbase.sh /etc/init.d/flopsar-dbase
[root@host ~]# ln -s /opt/flopsar/flopsar-proxy.sh /etc/init.d/flopsar-proxy
```
2. As root install services:
```bash
[root@host ~]# chkconfig --add flopsar-dbase
[root@host ~]# chkconfig --add flopsar-proxy
[root@host ~]# chkconfig flopsar-dbase on
[root@host ~]# chkconfig flopsar-proxy on
```

## Service start/stopping
Services are started automatically at system boot.
You can manually start/stop Flopsar either from root or dedicated user account.
* As root
```bash
[root@host ~]# service flopsar-dbase {start|stop|status}
[root@host ~]# service flopsar-proxy {start|stop|status}
```
* As dedicated user
```bash
[flopsar@host ~]$ /opt/flopsar/flopsar-dbase.sh {start|stop|status}
[flopsar@host ~]$ /opt/flopsar/flopsar-proxy.sh {start|stop|status}
```