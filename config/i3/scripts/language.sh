#!/bin/bash                                                           
            
CURR_LANG="$(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}')"
US="us"    
DK="dk"                                
                
if [ $# -gt  1 ]; then
    if [ "$CURR_LANG" == $DK ]; then
        setxkbmap "$US"
    elif [ "$CURR_LANG" == $US ]; then 
        setxkbmap "$DK"
    else     
        setxkbmap "$US"
    fi                             
fi 

CURR_LANG="$(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}')"
echo "⌨ [$CURR_LANG]"
