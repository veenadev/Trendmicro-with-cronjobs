#!/bin/bash
echo 'Cleanup bash history'
unset HISTFILE
[ -f /root/.bash_history ] && rm /root/.bash_history
[ -f /home/vagrant/.bash_history ] && rm /home/vagrant/.bash_history
echo 'Cleanup log files'
find /var/log -type f | while read f; do echo -ne '' > $f; done;
apt-get clean
rm -Rf /tmp/*
rm -Rf /var/tmp/*
