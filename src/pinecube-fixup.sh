#!/bin/bash

# This change allows systemd to reload properly
FSTAB=$(grep 'tmpfs defaults,size=20M' /etc/fstab);
if [ $? == 1 ]; then
  sed -i 's/none \/run tmpfs defaults,size=12M/none \/run tmpfs defaults,size=20M/g' /etc/fstab;
  mount -o remount /run;
fi
