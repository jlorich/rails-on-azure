#!/bin/bash

sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/opt/microsoft/omsagent/sysconf/omsagent.d/container.conf
sed -i -e 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/opt/microsoft/omsagent/sysconf/omsagent.d/syslog.conf
sed -i -e 's/^exit 101$/exit 0/g' /usr/sbin/policy-rc.d

#Using the get_hostname for hostname instead of the host field in syslog messages
sed -i.bak "s/record\[\"Host\"\] = hostname/record\[\"Host\"\] = OMS::Common.get_hostname/" /opt/microsoft/omsagent/plugin/filter_syslog.rb

#Disable dsc
/opt/microsoft/omsconfig/Scripts/OMS_MetaConfigHelper.py --disable
rm -f /etc/opt/microsoft/omsagent/conf/omsagent.d/omsconfig.consistencyinvoker.conf

# Start OMI Server
service omid start
/opt/omi/bin/omiserver -s
/opt/omi/bin/omiserver --configfile=/etc/opt/omi/conf/omiserver.conf -d

# Start OMS Agent
/opt/microsoft/omsagent/bin/omsadmin.sh -w $WSID -s $KEY -d $DOMAIN

#Hack for omi upgrade
 
/opt/omi/bin/omicli id
/opt/omi/bin/omicli ei root/cimv2 Container_HostInventory

#start cron daemon for logrotate
service cron start

#check if agent onboarded successfully
/opt/microsoft/omsagent/bin/omsadmin.sh -l

#get omsagent and docker-provider versions
# dpkg -l | grep omi | awk '{print $2 " " $3}'
dpkg -l | grep omsagent | awk '{print $2 " " $3}'
# dpkg -l | grep docker-cimprov | awk '{print $2 " " $3}' 


shutdown() {
#	/opt/omi/bin/service_control stop
	/opt/microsoft/omsagent/bin/service_control stop
}

trap "shutdown" SIGTERM

tail -n50 -f /var/opt/microsoft/omsagent/f808f30a-8bcd-4ab0-87c4-221b7a98f05e/log/omsagent.log
# sleep inf & wait