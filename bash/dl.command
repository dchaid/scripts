#!/bin/bash

printf '\e[8;65;170t'

echo "PLEASE ENTER ADMIN PASSWORD TO INSTALL..."
sudo -v
echo "CREATING BASH DIRECTORY..."; sleep 1;
mkdir ~/Desktop/Install &&
cd ~/Desktop/Install &&
echo "DOWNLOADING INSTALL SCRIPTS..."; sleep 1;
curl -sS https://raw.githubusercontent.com/dchaid/scripts/master/bash/install.command > install.command &&
curl -sS https://raw.githubusercontent.com/dchaid/scripts/master/bash/dock.command > dock.command &&
chmod a+x install.command ; 
chmod a+x dock.command ;

echo "                                                                                                             ,,;;;;;;;;;;,"
echo "                                                                                                          ,,;;;;;;;;;;;;;;;"
echo "                                                                                                    ,,,;;;;;;;;,,;,,;;;;,,,,"
echo "                                                                                                 .''','',;;;;,,,,,;;;;,,,,'',;,"
echo "                                                                                                     '''.,lddddoolcc:::cc:;,,;;;;,"
echo "                           llooddxxxxxxxdoc'.                                                         '',lxxxkkkxxddoodxd:,,,;;;;;;,"
echo "oooooooool:.......:lc;..,ldxkkkkkkkkkkkkkkkxo:,;::::::::::::::::::::::::::::,,ccccc,.',,,,,,,,'...,,,'';oddxxxkkdooddddxkd;',;;;;;;;"
echo "oooooooooo:.......,;,..:dxxdxdddoddddxxkkkkkkxc,;:::::::::::::::::::::::::::,,ccccc,.',,,,,,,'...',,,';coxkxodxddxkkkxddxd:',;;;;;;'"
echo "ooooooolc:;.....';cc;.'cllllllllcllllllloodxkkx:,;;:::::::::::::::::::::::::,,ccccc,.',,,,,,,'...',,,';ldOkdoddoxdx000xoo:,,,,,;,..'"
echo "ooooolc;,,,,;;,';cc:::clloooooooooooooooolccoxkxo:,;::::::::::::::::::::::::,,ccccc,.',,,,,,,'....,,,'':ooloxxxddddxxxdo:,;,;ccll"
echo "llllc;,;;;;::::::;';loooooooooooooooooooooolclxkkd,,::::::::::::::::::::::::,,ccccc,.',,,,,,,'....,,,,'':loxxkkxdooodxxo;,,colldx"
echo "cccccc:;;::::::::,,cooooooooooooooooooooooooclxxdc,,::::::::::::::::::::::::,,ccccc,.,,,,,,,,'....,,,,'':oxxxkxxxxdddxxdl:cdxdoc"
echo "clcccccc::cccccc:,,coooooooooooooooooooooool:lxddl,';:::::::::::::::::::::::,,ccccc,.,,,,,,,,'...',,,',looodddodxxxkxxxkxkkkkkc"
echo "cc:;,;:::cccllllc;,looooooooooooooooooooooolclddxd,';:::::::::::::::::::::::,,ccccc,.,,,,,,,,'....,',:oxxxdddddxxxxxxxkkkkkxoc,"
echo "llcc:::::cllllll:,coooooooooooooooooooooooolccdddd:',;::::::::::::::::::::::,,ccccc,.',,,,,,,'....,';oxxxxxxxxxxxddooldxkkkx:"
echo "ccllcc:cclllllll;;looooooooooooooooooooooccooloxdddo:;,;::::::::::::::::::::,,ccccc,.',,,,,,,'....,,,,;:::lddddddooddooxxkkxl'......'''',,,,"
echo ",,,,,,,,,,,,,,,'.,looooooooooollllllllllccoxdodkkkkkxdc,;:::::::::::::::::::,,ccccc,.',,,,,,,'.'.',,,,,,'':dddddddddxxxkkkkkd;''..'''''''.''.'"
echo "................ .,clccccllloooooooooooodxkxookkkkkxooc;;:::::::::::::::::::,,ccccc,.',,,,,,,'''.',,,,''..,cdxxkxkkxxkkkkkkko,','..'',,,,,'...',"
echo "...................',:lodxxkkkkkkkkkkkkkkxddooxkkkkkl;,,;:::::::::::::::::::,,:cccc,.',,,,,,,'''.''''......',:oxxkxkkxkkkkxo:..,,,'.',,,,'.',,,,'',"
echo ":::::::::::::::::::;,lxkkkkkkkkkkkkkkkkkkkxddxkkkkkkkdl:;;::::::::::::::::::,,:cccc,.',,,,,,,'....''..''..','''cdxkkkkkxdl:;;'',,,,..',,'.',,,,,,,,''',"
echo ":::::::::::::::::::,;dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl;;::::::::;;;;;;::::,,:cccc,.',,,''''...'',,..,'..',,'.,:lloolc:;;;;;'.',,,'..','.,,,,,,,,,,,,''',"
echo ":::::::::::::::::::,cxkkkkkkkkkkkkkkkkkkkkkkkkkkkxxocc:;;:::::::::;;:c:;;:::,;ccccc,.''''..'',,,,,,,..'..''''.';;,,:cc:,,;;;;'.','.''','.',,,,,,,,,,,,,,,''',"
echo "::::::::::::::::::;,coolllllllooooddxxkkkkkkkkkkkdc;,;::::::::::::;;:odc,;::;;cccc:,..''',,,,,,,,,,,.'''''..'..,,,:llll:'',,,..'..',,,,'.',,,,,,,,,,,,,,,,,,''',"
echo "::::::::::::::::;,...................',:codxkkkkd:,;:::::::::::::::;:dxdc;::,;cc:;,''',,,,,,,,,,,,,,'.',,''...','';cllc;,,,,,'''..'',,,'.',,,,,,,,,,,,,,,,,,,,''',;"
echo ":::::::::::::::,.                        ..';ldd:,;::::::::::::::::;;lxxdc;;,,;,''',,,,,,,,,,,,,,,,,'.','..''.';;;,,;::,;;;;;'',,''..',,'.',,,,,,,,,,,,,,,,,,,,,,'',"
echo "::::::::::::;,'.                             ....';:::::::::::::::::;cooool;'.'',,,,,,,,,,,,,,,,,,,,,'.'..',,'.,;;,,:ll:;;;;;'',,,,'..',,'..',,,,,,,,,,,,,,,,,,,,,,',"
echo ":::::::;,'....                                    .',;:::::::::::::::lddol:,,,,,,',,,,,,,,,,,,,,,,,,,'.''.',,,'';;,,:lll:;;:;'',,,,'.',,,,,'..'',,,,,,,,,,,,,,,,,,,,',"
echo ":::::;'..   .  .                  ......   .        ...',;;::::::::;:ddl;,',,',,,,,,,,,,,,,,,,,,,,,,,,..''.',,,'',;,:llll:,;;'',,,'.',,,,,,,,'''''',,,,,,,,,,,,,,,,,,."
echo ";;::'.   .   .........................                   ...,;:::::;;:;,',,,,,,,,,,,,,,,,,',,,,'''.'.'..',''.',,'',,;cllllc:,'',,'..,,,,,,,,,,,,'''''',,,,,,,,,,,,,,,,."
echo " ...        ... ....................                        ..,::;,'''',,'',,,,,,,,,,,,,,,'''..,:;;c:,,,.',''..''''',:llllll:'',,..',,,,,,,,,,,,,,,,'...',,,,,,,,,,,,,'."
echo "        ............................   ...          .  .      .','.'',,',,,,,,,,,,,,,,,''.....'lxolxo;,,'.'',,'..'''.';lllll:,,,''',,,,,,,,,,,,,,,,,,.  .',,,,,,,,,,,,,."
echo "            ....  ..................  ....          . ...      ..',,,,,,,,,,,,,,,,,,,''''''''';oxdodd:,,,'.',,,,'''''.',;cll:,''.',,,,,,,,,,,,,,,,,,,'.  .',,,,,,,,,,,,'."
echo "  .......                             ....        ...  ...       .',,,,,,,,,,,,,,,''',;::,.',';dxdood:,,,,'.'',,,,,''''...,;;,'.',,,,,,,,,,,,,,,,,,,,,.   .,,,,,,,,,,,,,."
echo " .................................... .....      ..........      ..,,,,,,,,,,,,,''',;:cc;'..'';dxdlod:,,,,,'.',,,,,,,,''''.....',,,,,,,,,,,,,,,,,,,,,,'.  ..,,,,,,,,,,,,."
echo " .................................... .....      ...........      ..'',,,,,,,,'',;:cccc:,...'.,oxdodd:,,,,,,'.',,',,,,,,,,,,'..',,,,,,,,,,,,,,,,,,,,,,,.....,,,,',,,',,,'"
echo " .................................... .....      ...........       .',',,,,''',;:cccccc:,.'.'.'cdlldl;,,,,,,,'..',,,,,,,,,,,,'.''.'',,,,,,,,,,,,,,,,,,,'';,'',:clllll:;,,."
echo " ..........................................      ...........       ..',,,''',::cccccccc:,'''''.;c,;c;,,,,,,,,,'..,,,,,,,,,,,,'.....',,,,,,,,,,,,,,,,,,,'','.,loddxxkkxd:'."
echo "  .........................................       ..........        .''''',:ccccc::::::;'',,,'.','''',,,,,,,,,,'..',,,,,,,,'''...''',,,,,,,,,,,,,,,,,,''','':odxxkkkkxd:."
echo "     ......................................       .........          ..';:::cc:;;;::::::;,,''',;;;:::;;;,'''',;,,,,,,''''',;;;;;;;,,'',,,,,,,,,,,,,,,'''';loddddxxkxxkd,"
echo "     ..                 .............  ....       .....          .    .;;;:;,,,;cllcllcll:,,;cclccllcclc:,,;cclcccccc:,',:cllccllol:,'''',,''''''''''''',colll::coxxxko'"
echo "     ................   .............  ....       .....         ..     .';;,','.',,;;;:::;,,,;::cccccccc:,,:ccccclcccc;:clcccclccllcc:,',:::::::;,,;;::::::;:"
echo "     ...................       ......  ....        . ...                .',,,,,,'................................'......',,',;;,;;,,'.,;;,,clcc::::::"
echo "      ................         ......  ....           ..                 .';;,,,',,,,,,,,'',;;:;'..',,;;'''''',......',,...''......','',,,;:::ccc::::"
echo "      ................         ......   ...           .                   .,;;::;;;;,,,,,,,',,,,,;;;;;:;''''';:,'''''',;'',,,,,;;,,,;,,;,,;:::ccc:"
echo "      ...............            ....   ...                                .;ccllllc:;,,;:::;,,';:,,,,,,'''''',,'',:;,;::::;;;;,,,;:::cc:;;;:"
echo "      ................           ....   ...                                ':c:::::c:;;;cccccc::cc:;;;;::;;::;:c::;:lcllcccccc:;;:"
echo "      ......... ....            .....   ....      ..                      ."
echo "         ..........     ..... .......   ....      ..                      '"
echo; echo; echo;
echo "TIME TO STEAM SOME HAMS..."
echo; echo; echo; sleep 2;

osascript -e 'tell app "Terminal"
    do script "bash ~/Desktop/Install/install.command"
end tell'


exit 0