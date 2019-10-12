#!/bin/bash

if [ "$#" -lt "1" ]
then
	echo "No executable file"
	exit 1
fi

for file in $(ls *.pastest)
do
	echo -e "\nFor tests in ${file}:"
	while read -r line
	do
		read -r result
		got=$(echo $line | ./$1 | tail -n 1)
		if [ "$got" == "$result" ]
		then
			printf "${GREEN}OK${NC}: \"${YELLOW}%s${NC}\"\t> \"${CYAN}%s${NC}\"\n" "${line}" "${got}"
		else
			printf "${RED}ERROR${NC}: \"${YELLOW}%s${NC}\"\t>\n\tExpected:\n\t\t\"${CYAN}%s${NC}\"\n\tGot:\n\t\t\"${RED}%s${NC}\"\n"  "${line}" "${result}" "${got}"
		fi
	done < "$file"
done
