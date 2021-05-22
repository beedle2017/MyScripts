#!/bin/bash

out=$1
escape=''
prev="<--- Back"

#dmenu -i -p "$out" -l 50 -nb "#4b5ba9" -sb "#8a5189"

for (( i=0 ; i<=15 ; i++))
do
options=(
 "$(ls "$out")"
 "<--- Back"
)
next="$(printf '%s\n' "${options[@]}" | dmenu -i -p "$out" -l 50 -nb "#4b5ba9" -sb "#8a5189" )" #default sb = #8a5189
if [[ $next = $escape ]]
then
exit 0
fi
if [[ $next = $prev ]]
then
out="$(sed -e "s/\\/[a-zA-Z0-9._+t ]*$//g " <<< $out)"
else 
out="$(realpath "${out}/${next}")"
fi
if [[ $next == *"."* ]]
then
xdg-open "$out" && exit 0
fi
done
