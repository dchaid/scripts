#!/bin/bash
###################################################################################################
#---Created by: David Chaid - KDInfotech
#---Created from: https://pingforinfo.com/cronjob-poweron-vm/
#---Creation date: August 29, 2019
#---Last Modified: August 29, 2019
#---Modified by: David Chaid
#---Modified for: VMWare Auto-Power-On
#---Description: Creates cronjob to restart VM after power off. Adds cron to /rc file
###################################################################################################

# Having enabled ssh access to your ESXi server, ssh in as root
# ~ #vi /vmfs/volumes/datastore1/auto-poweron.sh
# Replace ‘testvm’ with the appropriate vmName

vmname="testvm"
vmid=$(vim-cmd vmsvc/getallvms | grep "$vmname" | awk '{print $1}')
stat1=$(vim-cmd vmsvc/power.getstate "$vmid" | grep "off")
if [ "$stat1" == "Powered off" ]
then
vim-cmd vmsvc/power.on "$vmid"
fi

# Change the file permission to executable

# chmod 755 /vmfs/volumes/datastore1/auto-poweron.sh

# Create a cron job to execute this script every one hour

# Edit /var/spool/cron/crontabs/root using VI.
# Add the line (all on one line) at the bottom and save (:wq!).
# 0    */5    *    *    *     /vmfs/volumes/datastore1/auto-poweron.sh
# Run the command “cat /var/run/crond.pid”
# That will print the process number of the running crond, such as 12345
# Run the command “kill 12345”
# Where “12345” should be replaced with the number output by the previous command

# The above changes on ESXi do not persist across reboots. To make sure the cron job is consistant across reboot follow these steps:
# Add commands to /etc/rc.local.d/local.sh to re-generate the cron job when ESX/ESXi reboots
# 1. Edit /etc/rc.local.d/local.sh, using a command such as “vi /etc/rc.local.d/local.sh“.
# 2. At the end of the file just above ‘exit 0’, add following 3 lines. The first kills crond, the second adds the new cron job to the root crontab file, \n
# and the third restarts crond:

#---
# /bin/kill $(cat /var/run/crond.pid)
# /bin/echo '0    */5    *    *    *    /vmfs/volumes/datastore1/auto-poweron.sh' >> /var/spool/cron/crontabs/root
# crond
#---

# 3. Save and exit the editor (Press the “Esc” key then “:wq” then press “Return” in vi)
# 4. Run the command “auto-backup.sh” so that the change to /etc/rc.local.d/local.sh survives a reboot.
