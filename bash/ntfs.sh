#!/bin/bash

sudo -v

echo "STARTING COPY - PRESS CTRL + C TO QUIT"; sleep 5;
rsync --update -rtzv --progress /Volumes/C /Volumes/tpupach/cdrive/ ;
date -u;
echo "C-DRIVE SEGMENT COMPLETE";

rsync --update -rtzv --progress /Volumes/D /Volumes/tpupach/ddrive/ ;
date -u;
echo "D-DRIVE SEGMENT COMPLETE";

echo "RSYNC COPY COMPLETED";

exit 0
