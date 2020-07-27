#!/bin/bash

YLW='\033[1;33m'
NC='\033[0m'

if [ -z $1 ]
then
    echo "Please provide github organization"
    echo ""
    echo "$ ./cloneall.sh <ORG to clone>"
    exit 1
fi

ORG=$1

HTTP_RESPONSE=`curl -s -o /dev/null -I -w "%{http_code}" https://github.com/$ORG`

if [ $HTTP_RESPONSE -ne 200 ]
then
	echo "GitHub organization doesn't exist - https://github.com/$ORG - HTTP status code $HTTP_RESPONSE"
	exit 1
fi

declare -a repositories=( $(curl -s https://api.github.com/orgs/${ORG}/repos | jq -r '.[].name') )

if [ ${#repositories[@]} -eq 0 ]
then
    echo "No GitHub repositories found in ${ORG}"
    exit 1
fi

mkdir $1
cd $1

for repo in "${repositories[@]}"
do
	echo -e "${YLW}Cloning https://github.com/$ORG/$repo ${NC}"
	git clone -q "https://github.com/$ORG/$repo"
	echo -e "${YLW}Done. ${NC}"
done

echo ""
echo "The repositories have been cloned to: ${PWD}"
echo ""
cd ..