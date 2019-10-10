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
			echo -e "${GREEN}OK${NC}: \"${YELLOW}${line}${NC}\"\t> \"${CYAN}${got}${NC}\""
		else
			echo -e "${RED}ERROR${NC}: \"${YELLOW}${line}${NC}\"\t>\n\tExpected:\n\t\t\"${CYAN}${result}${NC}\"\n\tGot:\n\t\t\"${RED}${got}${NC}\""
		fi
	done < "$file"
done
