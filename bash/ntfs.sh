#!/bin/bash

#*****************************************************************************************************************************
#functions
#*****************************************************************************************************************************
#cursor spin
spin()
{
  spinner="/|\\—/|\\—"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep .06
    done
  done
}

sudo -v

#*****************************************************************************************************************************
#script
#*****************************************************************************************************************************

# Start the Spinner + Make a note of its Process ID (PID)
spin &
SPIN_PID=$!
trap "kill -9 $SPIN_PID" `seq 0 15`

echo "STARTING COPY - PRESS CTRL + C TO QUIT"; sleep 5;
rsync --update -rtzv --progress /Volumes/C /Volumes/tpupach/cdrive/ ;
date -u;
echo "C-DRIVE SEGMENT COMPLETE";

rsync --update -rtzv --progress /Volumes/D /Volumes/tpupach/ddrive/ ;

eval clear;

#kill spinner
kill -9 $SPIN_PID;

date -u;
echo "D-DRIVE SEGMENT COMPLETE";

echo "RSYNC COPY COMPLETED";

exit 0
