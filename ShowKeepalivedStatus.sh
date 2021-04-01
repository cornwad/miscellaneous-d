#!/bin/bash

# Tells you if this node is the primary or secondary in keepalived
# Looks at config file, identifies a VIP, checks if this computer is listening on that IP

# Assuming you saved this to ~/bin/ShowKeepalivedStatus.sh
# and made it executable 
# then add the following line to your .bashrc
#    export PS1="[\u@\h \W] [\$(~/bin/ShowKeepalivedStatus.sh)] \$ "
# and you'll get a handy-dandy thing in your prompt showing you 
# whether or not this is primary or secondary.
# like so
#     cornwad:~ creamcorn$ ssh haproxy1
#     Last login: Thu Apr  1 14:07:14 2021 from 11.232.18.221
#     [creamcorn@haproxy1 ~] [Primary] $ 
# Assuming you saved this to somewhere else
# then add a different line, which references a somewhere else.



 
# The config file for keepalived that lists the shared address(es)
# If this is different for you, then you're mistaken if you use this value

ConfigFile="/etc/keepalived/keepalived.conf"

if [ ! -r $ConfigFile ] ; then
    echo "configfile not readable"
   # exit 1
fi

# grab the IPs out of the lines in the conf file in this section:
#   virtual_ipaddress {
#     10.10.10.100 # virtual ip address
#     10.10.10.101 # virtual ip address
#     # 10.10.10.101 # virtual ip address

#   }
# I guess I should look for and exclude commented lines.. too

VIPs=`cat $ConfigFile |sed -ne '/virtual_ipaddress/,/}/p' |grep -vxE '[[:blank:]]*([#].*)?' | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*'`



if [ "$VIPs" == "" ] ; then
    echo "No VIPs"
    exit 1
fi

# I suppose some dingus could have IPs configured on networks that don't exist
# But stuff that is supposed to be working could still be working and being served
# by IPs that are configured correctly.
# So.. I guess just look to see if one or more of the IPs are up?
# ¯\_(ツ)_/¯ 🤷 


for VIP in `echo $VIPs` ; do 
    if ip addr | grep -q "$VIP" #if the VIP shows up in the list of `ip addr`
        then echo "Primary" ; exit 0
    fi
done

#I guess none of them did...
echo "Secondary" ; exit 1
    


