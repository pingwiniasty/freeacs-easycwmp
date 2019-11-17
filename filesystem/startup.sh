#!/bin/bash
UCISET="uci set"

/usr/sbin/ubusd -s /var/run/ubus.sock &


sed -i "s|%ACS_URL%|${ACS_URL}|g" /opt/dev/easycwmp/ext/openwrt/config/easycwmp
$UCISET easycwmp.@local[0]=local
$UCISET easycwmp.@local[0].interface='eth0'
$UCISET easycwmp.@local[0].port='7547'
$UCISET easycwmp.@local[0].ubus_socket='/var/run/ubus.sock'
$UCISET easycwmp.@local[0].date_format='%FT%T%z'
$UCISET easycwmp.@local[0].username='admin'
$UCISET easycwmp.@local[0].password='admin'
$UCISET easycwmp.@local[0].logging_level='3'
$UCISET easycwmp.@acs[0]=acs
$UCISET easycwmp.@acs[0].url=${ACS_URL:-'http://172.20.0.1:8085/acs'}
$UCISET easycwmp.@acs[0].username=${ACS_USERNAME:-'easycwmp'}
$UCISET easycwmp.@acs[0].password=${ACS_PASSWORD:-'easycwmp'}
$UCISET easycwmp.@acs[0].periodic_enable='1'
$UCISET easycwmp.@acs[0].periodic_interval=${ACS_PERIODIC_INTERVAL:-'100'}
$UCISET easycwmp.@acs[0].periodic_time='0001-01-01T00:00:00Z'
$UCISET easycwmp.@device[0]=device
$UCISET easycwmp.@device[0].manufacturer='easycwmp'
$UCISET easycwmp.@device[0].oui='FFFFFF'
$UCISET easycwmp.@device[0].product_class='easycwmp'
$UCISET easycwmp.@device[0].serial_number=${DEVICE_SERIAL:-'FFFFFF123456'}
$UCISET easycwmp.@device[0].hardware_version=${DEVICE_HW_VERSION:-'1.0'}
$UCISET easycwmp.@device[0].software_version=${DEVICE_FW_VERSION:-'1.0.1'}
uci commit easycwmp
uci show

/usr/sbin/easycwmpd -f -b
