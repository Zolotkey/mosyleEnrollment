#!/usr/bin/env zsh

inDEP=$(/usr/bin/profiles -e | awk '/Configuration/')

if [[ -z "${inDEP}" ]]; then
    /usr/bin/profiles renew -type enrollment
    echo "not in DEP"
fi

##Admin Supplied Variables
# Enrollment Code to Device/User Group
mosyleEnrollCode="CHANGE"

#Non User Configurable Variables
trueEnrollURL=$(/usr/bin/curl -sI https://join.mosyle.com/${mosyleEnrollCode} | /usr/bin/awk 'match($2, /^https:\/\/[^[:space:]]*\.mosyle\.com\/mdm\/enrollment\/\?c=[a-zA-Z0-9]*/) {print substr($2,RSTART,RLENGTH)}')
mosyleProfile="/tmp/mosyleEnroll.mobileconfig"

/usr/bin/curl -s ${trueEnrollURL}'&self' -o ${mosyleProfile}

/usr/bin/profiles install -path=${mosyleProfile}
