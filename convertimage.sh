#!/bin/bash

spinlong ()
{
    bar=" +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
    barlength=${#bar}
    i=0
    while ((i < 100)); do
        n=$((i*barlength / 100))
        printf "\e[00;32m\r[%-${barlength}s]\e[00m" "${bar:0:n}"
        ((i += RANDOM%5+2))
        sleep 0.02
    done
    echo -e "[${green}OK${tp}]"
}

trap ctrl_c INT
ctrl_c() {
echo -e "\n"
zenity --question --text "Are you sure you want to quit?" --no-wrap --ok-label "Yes" --cancel-label "No"
if [ $? = 0 ] ; then
echo "Thank you use Convert Image"
exit 
fi
}

if [[ $(command -v dwebp) != "" ]] ; then 
echo "Starting Convert Image"
sleep 1
clear 
else 
echo "Downloading Convert Image"
sudo apt install webp &> /dev/null 
sudo pacman -S webp &> /dev/null
sudo dnf install webp &> /dev/null
spinlong
fi

ask=$(zenity --list --title="Convert Image" --text "Select action" --radiolist --column "Choice" --column "Action" FALSE "jpg convert to webp" FALSE "png convert to webp" FALSE "webp convert to jpg" FALSE "webp convert to png" FALSE "jpg convert to png" FALSE "png convert to jpg" --width=320 --height=320)

if [[ $ask = "jpg convert to webp" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [JPG]")
cwebp -q 60 $sec -o output.webp &> /dev/null  
spinlong
echo "Saved On $PWD"
fi

if [[ $ask = "png convert to webp" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [PNG]")
cwebp -q 60 $sec -o output.webp &> /dev/null 
spinlong
echo "Saved On $PWD" 
fi

if [[ $ask = "webp convert to jpg" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [WEBP]")
cwebp -q 60 $sec -o output.jpg &> /dev/null
spinlong 
echo "Saved On $PWD" 
fi

if [[ $ask = "webp convert to png" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [WEB]")
cwebp -q 60 $sec -o output.png &> /dev/null 
spinlong 
echo "Saved On $PWD"
fi

if [[ $ask = "jpg convert to png" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [JPG]")
cwebp -q 60 $sec -o output.png &> /dev/null 
spinlong
echo "Saved On $PWD"
fi

if [[ $ask = "png convert to jpg" ]] ; then 
sec=$(zenity --file-selection --title "Select your File [PNG]")
cwebp -q 60 $sec -o output.jpg &> /dev/null 
spinlong
echo "Saved On $PWD"
fi

if [[ $ask = "" ]] ; then 
        zenity --warning \
        --text="No choice was made"
        echo "Exiting"
        exit 1
    fi
