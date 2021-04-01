# miscellaneous-d

A collection of assorted scripts and such

# [ldap2human.sh](ldap2human.sh)
- takes date in stupid LDAP "100 nanoseconds since 1601 or whatever the fuck" format and converts it into something regular people can read.
 
# [ShowKeepalivedStatus.sh](ShowKeepalivedStatus.sh)
- a shell script that determines if an IP address defined as as VIP in keepalived is being used by this particular server, which you can use to identify if this server is PRIMARY or SECONDARY or whatever
- call this from .bashrc and print it right there on your stupid prompt.  (instructions are in the comments)
