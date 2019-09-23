#!/bin/bash

printf '\e[8;65;179t'

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
echo "                                                                                                  ''','',;;;;,,,,,;;;;,,,,'',;,"
echo "                                                                                                     '''.,lddddoolcc:::cc:;,,;;;;,"
echo "                           llooddxxxxxxxdoc'.                                                         '',lxxxkkkxxddoodxd:,,,;;;;;;,"
echo "                         ldxkkkkkkkkkkkkkkkxo:,                                                      '';oddxxxkkdooddddxkd;',;;;;;;;"
echo "                        dxxdxdddoddddxxkkkkkkxc,;                                                    ';coxkxodxddxkkkxddxd:',;;;;;;'"
echo "                      'cllllllllcllllllloodxkkx:,;                                                   ';ldOkdoddoxdx000xoo:,,,,,;,..'"
echo "                     :clloooooooooooooooolccoxkxo:,;                                                 '':ooloxxxddddxxxdo:,;,;ccll"
echo "                   ;loooooooooooooooooooooolclxkkd,,                                                  '':loxxkkxdooodxxo;,,colldx"
echo "                  ,cooooooooooooooooooooooooclxxdc,,                                                 '':oxxxkxxxxdddxxdl:cdxdoc"
echo "                 ,,coooooooooooooooooooooool:lxddl,';                                               ,',looodddodxxxkxxxkxkkkkkc"
echo "                  ,looooooooooooooooooooooolclddxd,';                                             ,',:oxxxdddddxxxxxxxkkkkkxoc,"
echo "                 ,coooooooooooooooooooooooolccdddd:',                                             ,';oxxxxxxxxxxxddooldxkkkx:"
echo "                ;;looooooooooooooooooooooccooloxdddo:;                                                ;:::lddddddooddooxxkkxl'......'''',,,,"
echo "               '.,looooooooooollllllllllccoxdodkkkkkxdc,;                                               '':dddddddddxxxkkkkkd;''..'''''''.''.'"
echo "                 .,clccccllloooooooooooodxkxookkkkkxooc;;                                               ..,cdxxkxkkxxkkkkkkko,','..'',,,,,'...',"
echo "                   ',:lodxxkkkkkkkkkkkkkkxddooxkkkkkl;,,;                                            ......',:oxxkxkkxkkkkxo:..,,,'.',,,,'.',,,,'',"
echo "                    ,lxkkkkkkkkkkkkkkkkkkkxddxkkkkkkkdl:;;                                     ...''..''..','''cdxkkkkkxdl:;;'',,,,..',,'.',,,,,,,,''',"
echo "                   ,;dkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkxl;;                                  ...'',,..,'..',,'.,:lloolc:;;;;;'.',,,'..','.,,,,,,,,,,,,''',"
echo "                   ,cxkkkkkkkkkkkkkkkkkkkkkkkkkkkxxocc:;;                               ..'',,,,,,,..'..''''.';;,,:cc:,,;;;;'.','.''','.',,,,,,,,,,,,,,,''',"
echo "                  ;,coolllllllooooddxxkkkkkkkkkkkdc;,;                              ..''',,,,,,,,,,,.'''''..'..,,,:llll:'',,,..'..',,,,'.',,,,,,,,,,,,,,,,,,''',"
echo "                ;,...................',:codxkkkkd:,;                              ,''',,,,,,,,,,,,,,'.',,''...','';cllc;,,,,,'''..'',,,'.',,,,,,,,,,,,,,,,,,,,''',;"
echo "               ,.                        ..';ldd:,                              ',,,,,,,,,,,,,,,,,,,,,'.'..',,'.,;;,,:ll:;;;;;'',,,,'..',,'..',,,,,,,,,,,,,,,,,,,,,,',"
echo "        ,'....                                    .',                      ,,,,,',,,,,,,,,,,,,,,,,,,'.''.',,,'';;,,:lll:;;:;'',,,,'.',,,,,'..'',,,,,,,,,,,,,,,,,,,,',"
echo "      '..   .  .                  ......   .        ...',                ,',,',,,,,,,,,,,,,,,,,,,,,,,,..''.',,,'',;,:llll:,;;'',,,'.',,,,,,,,'''''',,,,,,,,,,,,,,,,,,."
echo "    '.   .   .........................                   ...           ,',,,,,,,,,,,,,,,,,',,, ''' ' ' .',''.',,'',,;cllllc:,'',,'..,,,,,,,,,,,,'''''',,,,,,,,,,,,,,,,."
echo " ...        ... ....................                        ..,   ,'''',,'',,,,,,,,,,,,,,,''            .',''..''''',:llllll:'',,..',,,,,,,,,,,,,,,,'...',,,,,,,,,,,,,'."
echo "        ............................   ...          .  .      .','.'',,',,,,,,,,,,,,,,,''               '.'',,'..'''.';lllll:,,,''',,,,,,,,,,,,,,,,,,.  .',,,,,,,,,,,,,."
echo "            ....  ..................  ....          . ...      ..',,,,,,,,,,,,,,,,,,,'                   '.',,,,'''''.',;cll:,''.',,,,,,,,,,,,,,,,,,,'.  .',,,,,,,,,,,,'."
echo "  .......                             ....        ...  ...       .',,,,,,,,,,,,,,,''                      '.'',,,,,''''...,;;,'.',,,,,,,,,,,,,,,,,,,,,.   .,,,,,,,,,,,,,."
echo " .................................... .....      ..........      ..,,,,,,,,,,,,,'                         '.',,,,,,,,''''.....',,,,,,,,,,,,,,,,,,,,,,'.  ..,,,,,,,,,,,,."
echo " .................................... .....      ...........      ..'',,,,,,,,'                            '.',,',,,,,,,,,,'..',,,,,,,,,,,,,,,,,,,,,,,.....,,,,',,,',,,'"
echo " .................................... .....      ...........       .',',,,,''                                '..',,,,,,,,,,,,'.''.'',,,,,,,,,,,,,,,,,,,'';,'',:clllll:;,,."
echo " ..........................................      ...........       ..',,,''                                   '..,,,,,,,,,,,,'.....',,,,,,,,,,,,,,,,,,,'','.,loddxxkkxd:'."
echo "  .........................................       ..........        .'''''                                     ,,'..',,,,,,,,'''...''',,,,,,,,,,,,,,,,,,''','':odxxkkkkxd:."
echo "     ......................................       .........          ..'         ;::::::;,    ,;;;:::;;;,    ,;,,,,,,''''',;;;;;;;,,'',,,,,,,,,,,,,,,'''';loddddxxkxxkd,"
echo "     ..                 .............  ....       .....          .    .;;;:;,,,;cllcllcll:,,;cclccllcclc:,,;cclcccccc:,',:cllccllol:,'''',,''''''''''''',colll::coxxxko'"
echo "     ................   .............  ....       .....         ..     .';;,','.',,;;;:::;,,,;::cccccccc:,,:ccccclcccc;:clcccclccllcc:,',:::::::;,,;;::::::;:"
echo "     ...................       ......  ....        . ...                .',,,,,,'................................'......',,',;;,;;,,'.,;;,,clcc::::::"
echo "      ................         ......  ....           ..                 .';;,,,',,,,,,,,'',;;:;'..',,;;'''''',......',,...''......','',,,;:::ccc::::"
echo "      ................         ......   ...           .                   .,;;::;;;;,,,,,,,',,,,,;;;;;:;''''';:,'''''',;'',,,,,;;,,,;,,;,,;:::ccc:"
echo "      ...............            ....   ...                                .;       :;,,;:::;,,';:,,,,,,'''''',,'',:;,;::::;;;;,,,;:::cc:;;;:"
echo "      ................           ....   ...                                ':"
echo "      ......... ....            .....   ....      ..                      ."
echo "         ..........     ..... .......   ....      ..                      '"
echo; echo; echo;
echo "                                                                           TIME TO STEAM SOME HAMS..."
echo; echo; echo; sleep 2;

osascript -e 'tell app "Terminal"
    do script "bash ~/Desktop/Install/install.command"
end tell'


exit 0
