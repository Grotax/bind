#!/bin/bash
# Simple script to update the dns (db.tc.ja) files from git

# CONFIGURE THIS TO YOUR GIT DIRECTORY
GIT_REPO=/home/dnsbind/bind

# CONFIGURE THIS TO THE USER TO RUN THE GIT COMMANDS AS
USER=dnsbind

cd $GIT_REPO

# Nur, wenn nicht weitere Zonen verwendet werden: su -c "git pull -q" $USER

if ! cmp $GIT_REPO/db.tc.ja /etc/bind/db.tc.ja >/dev/null 2>&1 ;
then
    cp $GIT_REPO/db.tc.ja /etc/bind/db.tc.ja
    chown -R bind:bind /etc/bind/db.* 2>&1> /dev/null

    /usr/sbin/service bind9 status 2>&1> /dev/null
    if [[ $? -eq 0 ]]
    then
        /usr/sbin/service bind9 restart
    fi
fi
