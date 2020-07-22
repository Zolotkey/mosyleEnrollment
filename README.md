# mosyleEnrollment
Scripts for Mosyle MDM/DEP Enrollment

## Background

I needed a way to push out Mosyle via Munki to enroll certian devices into Mosyle Device Groups. At this time you have to open safari to enroll these devices via Safari at a web page. I needed a way to script this. So I came up with these scripts. You can deploy via DEP or have the script download and install the Mosyle Profile.

## setupDEP.sh

This is what enrolls your Mac into Mosyle. You will need to edit the script with the Group Code you are trying to enroll in. 

## setupDEP_check.py

Currently it is calling the Munki Embedded Python 3 to handle its checks. You can change the shebang to your own python3 or look into the MunkiAdmins Relocatable Python 3. Here: [MacAdmins/Python](https://github.com/macadmins/python)
