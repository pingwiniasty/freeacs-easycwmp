#!/bin/bash
sed -i "s|%ACS_URL%|${ACS_URL}|g" /opt/dev/easycwmp/ext/openwrt/config/easycwmp
/usr/sbin/ubusd -s /var/run/ubus.sock &
/usr/sbin/easycwmpd -f -b
