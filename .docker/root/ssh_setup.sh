#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
magenta=`tput setaf 5`
bold=`tput bold`
reset=`tput sgr0`

ssh_keys=( $(find  /root/.ssh/ -maxdepth 1 -type f ! -name '.*' -printf '%f\n') )

/bin/chmod 0700 ~/.ssh

echo "${bold}${green} Below is the list of SSH Private Keys found on your system ${reset}";
echo "${bold}${yellow} Please select one to add it to the agent: ${reset}";

select ssh_key in "${ssh_keys[@]}" ; do
    eval "$(ssh-agent -s)" && /bin/chmod 0600 ~/.ssh/$ssh_key && /usr/bin/ssh-add -k ~/.ssh/$ssh_key
    exit;
done