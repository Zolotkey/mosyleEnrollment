#!/usr/local/munki/Python.framework/Versions/Current/bin/python3

import plistlib
import subprocess
import sys


DEP_PROFILE_DISPLAY_NAME = 'Mosyle Corporation MDM'
MANUAL_PROFILE_IDENT = 'com.mosyle.macos.config'

def main():
   (resultDEP, resultMDM) = get_dep_activation()

   if resultDEP == False:
       print('I am not DEP activated')
       if resultMDM == False:
           print('I am not in MDM')
           sys.exit(0)
       else:
           print('I am in MDM')
           sys.exit(1)
   else:
       print('I am DEP activated')
       if resultMDM == True:
           print('I am in MDM')
           sys.exit(1)
       else:
           print('I am not in MDM')
           sys.exit(0)


def get_dep_activation():
    resultDEP = False
    resultMDM = False

    cmd = ['profiles', '-e']
    output = subprocess.check_output(cmd, text=True)
    for line in output.splitlines():
        if 'ConfigurationURL' in line:
            resultDEP = True 
            break

    mdmcmd = ['profiles', 'list']
    mdmOutput = subprocess.check_output(mdmcmd, text=True)
    for line in mdmOutput.splitlines():
        if MANUAL_PROFILE_IDENT in line:
            resultMDM = True
            break

    return ( resultDEP, resultMDM )

if __name__ == "__main__":
    main()
