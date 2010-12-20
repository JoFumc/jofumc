#!/bin/bash

sudo sshfs -o allow_other,uid=`id -u akephart` u38465639@akephart.org: /export/webspace/
sudo sshfs -o allow_other,uid=`id -u akephart` akephart@beta.jofumc.net: /export/dreamhost/

