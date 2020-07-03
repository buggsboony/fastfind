#!/bin/bash



datetimestamp(){
    date +%Y-%m-%dT%Hh%mm%Ss
}


cachefile=fastfile_cache

#-r or --purge to remove cachefile 
#-o to overwrite cache, -s to silence output (increase speed)
#fastfind "paTTern" -os 
#fastfind "paTTern"

pattern=$1
args=$2
 

if [ -z "$1" ] || [[ $args == *"h"* ]]  || [ $1 == "-h" ] && [ -z "$args" ];
then
echo "fastfind pattern_ignore_case -[s][o][h]"
echo "-h show HELP, then exits"
echo "-s => No output browsering (save time), default choice"
echo "-o => Force overwrite cache file"
echo "-r  or --purge => remove cache file"
exit
fi;

if [ $pattern == "-r" ] || [ $pattern == "--purge" ];
then
    if [ -f $cachefile ];
    then    
        echo "rm \"$cachefile\""
        rm "$cachefile";        
    else
        echo "No cachefile found";
    fi
    exit;
fi

echo "-----------  search: \"$pattern\"";
overwrite="0"
silent="1"

if [[ $args == *"o"* ]]
then
overwrite=1
fi

if [[ $args == *"s"* ]]
then
silent=1
fi


#create cache fonction
createcache(){
    echo "Creating cache... \"$cachefile\"";    
    if [ $silent == "1" ]; then
       time find . > $cachefile
    else
       time find . | tee $cachefile
    fi    
}

#readcache and show searched pattern
readcache(){
   cat $cachefile | grep -i $pattern --color=always $@
}



#afficher la date de création du cache utilisé
#check file existence
if [ -f $cachefile ]; 
then        
    if [ $overwrite == "1" ]; then  
        createcache
    fi;       
else
    echo "no cachefile found";
    createcache
fi

readcache



