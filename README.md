# miscellaneous-d

A collection of assorted scripts and such

# [ldap2human.sh](ldap2human.sh)
- takes date in stupid LDAP "100 nanoseconds since 1601 or whatever the fuck" format and converts it into something regular people can read.
 
# [ShowKeepalivedStatus.sh](ShowKeepalivedStatus.sh)
- a shell script that determines if an IP address defined as as VIP in keepalived is being used by this particular server, which you can use to identify if this server is PRIMARY or SECONDARY or whatever
- call this from .bashrc and print it right there on your stupid prompt.  (instructions are in the comments)
  -  be advised - this will make it get run every time you hit enter or whatever.    Which is neat if you want to see the status change in realtime from "Primary" to "Standby".  It's probably less neat if you have 100 VIPs and only the 98th one is actually up and it's looping through `ip addr` a bunch of times or some nonsense like that.
