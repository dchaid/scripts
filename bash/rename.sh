#!/bin/bash
#---rename functions
function machinename () {
    osascript <<EOT
        tell application "Finder"
            activate
            set nameentry to text returned of (display dialog "Please Input New Computer Name" default answer "" with icon 2)
            end tell
EOT
}

function renameComputer(){
    #Set New Computer Name
    echo "The New Computer name is: $ComputerName"
    sudo scutil --set HostName $ComputerName
    sudo scutil --set LocalHostName $ComputerName
    sudo scutil --set ComputerName $ComputerName
    echo Rename Successful
}

#---rename script
ComputerName=$(machinename)
renameComputer;
