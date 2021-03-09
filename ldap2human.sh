#!/bin/bash

# takes date in stupid LDAP "100 nanoseconds since 1601 or whatever the fuck" format 
# and converts it into something regular people can read.

 
case $1 in
    "") echo "usage: $0 LDAP_Date" ; exit 2 ;;
    *) LDAPDate=$1 ;;
esac

if ! [ "$LDAPDate" -eq "$LDAPDate" ] 2> /dev/null ; then
    echo "$LDAPDate doesn't appear to be an integer."
    exit 2
fi

if [ $LDAPDate -lt 116444736000000000 ] ; then 
    echo "$LDAPDate doesn't seem to be a date in stupid ldap date format"
    exit 2
fi


EPOCH=`echo "( $LDAPDate - 116444736000000000) / 10000000 "  | bc`

case $OSTYPE in
    linux-gnu)  /bin/date -d "@$EPOCH" ;;
    darwin*) /bin/date -r $EPOCH ;;
    *) echo " 🤷‍♂ " ;;
esac

