#!/bin/bash

# Variables
CURRENT_DIR=`pwd`
VM_URL="devvm.jitsi.meet"
VM_IP="192.168.88.88"
SUCCESS="Your Dev VM is now accessible from https://devvm.jitsi.meet!"
ALIAS="$VM_IP  $VM_URL"

printf "=============== Cloning Git repos ===============\n"
cd ../

echo "Cloning lib-jitsi-meet"
git clone git@github.com:jitsi/lib-jitsi-meet.git
echo "Cloning jitsi-meet"
git clone git@github.com:jitsi/jitsi-meet.git

printf "\n\n=============== Set up Dev VM ===============\n\n"
cd $CURRENT_DIR
vagrant up

printf "\n=============== Making alias for Dev VM ===============\n"
echo "Check if the alias exist"

CONDITION=`grep $VM_URL /etc/hosts`
if [ $? -eq 1 ]
then
  echo "Creating the alias"
  echo $ALIAS >> /etc/hosts && echo $SUCCESS
else
  echo "Alias exist"
fi

echo "Link lib-jitsi-meet dependency to local copy"
cd ../lib-jitsi-meet
npm link
cd ../jitsi-meet
npm link lib-jitsi-meet

echo "build application"
make

printf "\n=============== Done ===============\n"
