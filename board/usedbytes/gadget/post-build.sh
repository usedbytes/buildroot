#!/bin/bash
# Post-build script for Gadget

TARGETDIR=$1
BOARDDIR=./board/usedbytes/gadget

# Replace pager with "less" (more is terrible :-)
sed -i "s;PAGER='/bin/more ';PAGER='/usr/bin/less ';g" $TARGETDIR/etc/profile

# FIXME
sed -i "s;#PermitRootLogin prohibit-password;PermitRootLogin yes;g" $TARGETDIR/etc/ssh/sshd_config
sed -i "s;#Storage=auto;Storage=volatile;g" $TARGETDIR/etc/systemd/journald.conf
