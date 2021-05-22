#!/bin/bash
declare -A list

#list of shortcuts of names and associated email addresses. Example: list=(["Self"]="myname@yahoo.com" ["Mom"]="mom@yahoo.com")
#Fill out the list to get access to frequent contacts in the dmenu list
list=( 
)


escape=''
noatt='No attachment'
att=''
sub=''
rec=''
body=''
bemail=''
cemail=''
wt=$((0))

send_mail () {
    if [[ $att = $noatt ]]
    then
    if [[ $wt -eq "0" ]]
    then
    echo "$body" | mutt -s "$sub" "$rec" -c "$cemail" -b "$bemail"
    fi
    if [[ $wt -eq "2" ]]
    then
    echo "$body" | mutt -s "$sub" "$rec" -c "${list[$cemail]}" -b "$bemail"
    fi
    if [[ $wt -eq "1" ]]
    then
    echo "$body" | mutt -s "$sub" "$rec" -c "$cemail" -b "${list[$bemail]}"
    fi
    if [[ $wt -eq "3" ]]
    then
    echo "$body" | mutt -s "$sub" "$rec" -c "${list[$cemail]}" -b "${list[$bemail]}"
    fi
    if [[ $wt -eq "4" ]]
    then
    echo "$body" | mutt -s "$sub" "${list[$rec]}" -c "$cemail" -b "$bemail"
    fi
    if [[ $wt -eq "6" ]]
    then
    echo "$body" | mutt -s "$sub" "${list[$rec]}" -c "${list[$cemail]}" -b "$bemail"
    fi
    if [[ $wt -eq "5" ]]
    then
    echo "$body" | mutt -s "$sub" "${list[$rec]}" -c "$cemail" -b "${list[$bemail]}"
    fi
    if [[ $wt -eq "7" ]]
    then
    echo "$body" | mutt -s "$sub" "${list[$rec]}" -c "${list[$cemail]}" -b "${list[$bemail]}"
    fi
    else                ##From here attachment
    if [[ $wt -eq "0" ]]
    then
    echo "$body" | mutt -s "$sub" -c "$cemail" -b "$bemail" -a "$att" -- " $rec" 
    fi
    if [[ $wt -eq "2" ]]
    then
    echo "$body" | mutt -s "$sub" -c "${list[$cemail]}" -b "$bemail" -a "$att" -- "$rec" 
    fi
    if [[ $wt -eq "1" ]]
    then
    echo "$body" | mutt -s "$sub" -c "$cemail" -b "${list[$bemail]}"  -a "$att" -- "$rec"
    fi
    if [[ $wt -eq "3" ]]
    then
    echo "$body" | mutt -s "$sub" -c "${list[$cemail]}" -b "${list[$bemail]}" -a "$att" -- "$rec"
    fi
    if [[ $wt -eq "4" ]]
    then
    echo "$body" | mutt -s "$sub" -c "$cemail" -b "$bemail"  -a "$att" -- "${list[$rec]}" 
    fi
    if [[ $wt -eq "6" ]]
    then
    echo "$body" | mutt -s "$sub" -c "${list[$cemail]}" -b "$bemail" -a "$att" -- "${list[$rec]}" 
    fi
    if [[ $wt -eq "5" ]]
    then
    echo "$body" | mutt -s "$sub" -c "$cemail" -b "${list[$bemail]}"  -a "$att" -- "${list[$rec]}" 
    fi
    if [[ $wt -eq "7" ]]
    then
    echo "$body" | mutt -s "$sub" -c "${list[$cemail]}" -b "${list[$bemail]}" -a "$att" -- "${list[$rec]}" 
    fi
    fi
}

cc="Add Cc"
bcc="Add Bcc"
send="Send Dmail"

declare -a options=(
    "$cc"
    "$bcc"
    "$send"
)

body=$(echo "Press Esc any time to exit" | dmenu -i -p "Dmail: Body" -l 50 -nb "#4b5ba9" -sb "#8a5189")
if [[ $body = $escape ]]
then
exit 0
fi
sub=$(echo "" | dmenu -i -p "Dmail: Subject" -l 50 -nb "#4b5ba9" -sb "#8a5189")
if [[ $sub = $escape ]]
then
exit 0
fi
att=$(echo $noatt | dmenu -i -p "Dmail: Attachment" -l 50 -nb "#4b5ba9" -sb "#8a5189")
if [[ $body = $escape ]]
then
exit 0
fi
rec=$(for ml in "${!list[@]}"; do echo "$ml"; done | dmenu -i -p "Dmail: Recepeint" -l 50 -nb "#4b5ba9" -sb "#8a5189")
if [[ $rec = $escape ]]
then
exit 0
fi
for ml in "${!list[@]}"
do
if [[ $ml = $rec ]]
then
wt=$(( $wt + 4 ))
fi
done

bwt=$((0))
cwt=$((0))

for (( i=0; i<15 ; i++ ))
do
opt=$(for choice in "${options[@]}"; do echo "$choice"; done | dmenu -i -p "Options:" -l 50 -nb "#4b5ba9" -sb "#8a5189")
if [[ $opt = $escape ]]
then
exit 0
fi
if [[ $opt = $send ]]
then
send_mail
exit 0
fi
if [[ $opt = $bcc ]]
then
bemail=$(for ml in "${!list[@]}"; do echo "$ml"; done | dmenu -i -p "Bcc:" -l 50 -nb "#4b5ba9" -sb "#8a5189")
fi
if [[ $opt = $cc ]]
then
cemail=$(for ml in "${!list[@]}"; do echo "$ml"; done | dmenu -i -p "Bcc:" -l 50 -nb "#4b5ba9" -sb "#8a5189")
fi

for ml in "${!list[@]}"
do
if [[ $ml = $bemail ]]
then
bwt=$((1))
fi
if [[ $ml = $cemail ]]
then
cwt=$((2))
fi
done

wt=$(( $wt + $cwt + $bwt ))

done