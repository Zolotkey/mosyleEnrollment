#!/usr/bin/env zsh

inDEP=$(/usr/bin/profiles -e | awk '/Configuration/')

if [[ -z "${inDEP}" ]]; then
    /usr/bin/profiles renew -type enrollment
    echo "not in DEP"
fi

##Admin Supplied Variables
# Enrollment Code to Device/User Group
mosyleEnrollCode=""
# Server URL to Your Business Assigned to you
# From Mosyle
mosyleServer="biz-####"

#Non User Configurable Variables
hash=$(/usr/bin/curl -sI https://join.mosyle.com/${mosyleEnrollCode} | /usr/bin/awk '/Location/ {print substr($2,47,20)}')
mosyleProfile="/tmp/mosyleEnroll.mobileconfig"

/usr/bin/curl -s 'https://'${mosyleServer}'.mosyle.com/mdm/enrollment/?c='${hash}'&self' -o ${mosyleProfile}

/usr/bin/profiles install -path=${mosyleProfile}
