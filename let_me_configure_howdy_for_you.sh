#!/usr/bin/env bash
# By williamwlk
# December 10, 2018
# set -o errexit
set -o pipefail
set -o nounset

# May I ..
echo -en "\ec"
echo "May I?"
echo "1. configure webcam for howdy"
echo "2. configure PAM for howdy"
echo "3. remind you to thank boltgolt"
while true; do
    read -p "[y/n] " yn_read 
    case ${yn_read} in
        [Yy]* ) echo "Movig on..." ; break;;
        [Nn]* ) echo "I may not. Got it. Peace Out."; exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Moving on...
# WEBCAM Stuff
pam_file1=/etc/pam.d/system-auth
pam_file2=/etc/pam.d/gdm-password
webcam_count=$(ls /dev/video? 2> /dev/null | wc -l)
howdy_config_file=$(rpm -qc howdy)
echo "1. WEBCAM - Let me find a webcam for howdy and configure it."
if [ ${webcam_count} = 0 ];then
	# For some reason, I can't seem to find a webcam. I could be wrong.
	echo "   No webcam. No howdy. Go find one."
	exit 1
elif [ ${webcam_count} = 1 ];then
	# Found one webcam.
        echo "   Life is easy peasy. Really."
	webcam_device=$(ls /dev/video?)
        howdy_device_path=$(udevadm info --query=symlink --root --name ${webcam_device} | awk '{print $2}')
        sed -i "s|none|${howdy_device_path}|g" ${howdy_config_file}
        echo "   $(cat ${howdy_config_file} | grep device_path)"
elif [ ${webcam_count} -ge 2 ];then
	# Found more than one webcam.
        echo "   More than one webcam? Did it for you with the default /dev/video0."
        howdy_device_path=$(udevadm info --query=symlink --root --name /dev/video0 | awk '{print $2}')
        sed -i "s|none|${howdy_device_path}|g" ${howdy_config_file}
        echo "   $(cat ${howdy_config_file} | grep device_path)"
fi

# I want to make sure that configuraing PAM is done just once.
# Please refer to README.md for more information about PAM.
if grep -qE "pam_python.so|howdy/pam.py" ${pam_file1} ||  grep -qE "pam_python.so|howdy/pam.py" ${pam_file2} ; then 
	echo 
	echo "2. KNOWN howdy PAM Config Items are found. Skipping the step ..."
	echo "   Please take a look at #head /etc/pam.d/${pam_file1} and #head /etc/pam.d/${pam_file2} "
	# Just love doing this.
	echo "   ¯\_(ツ)_/¯"
	exit 2 
fi

# OK, We need to configure PAM. 
# PAM (A very invasive action indeed)
# Please refer to README.md for more information about PAM.
echo "2. PAM : Now, the last step but the most crucial one: configuring PAM."
sed -i '4i\ ' ${pam_file1} 
sed -i '5i # Howdy IR face recognition' ${pam_file1}
sed -i '6i auth sufficient pam_python.so /usr/lib64/security/howdy/pam.py' ${pam_file1}
sed -i '7i\ ' ${pam_file1} 
sed -i '1i # Howdy IR face recognition' ${pam_file2} 
sed -i '2i auth sufficient pam_python.so /usr/lib64/security/howdy/pam.py' ${pam_file2} 
sed -i '3i\ ' ${pam_file2} 
echo "3. Enjoy your howdy. Don't forget to thank boltgolt, buy him a coffee or star the repo."
# Doing this again.
echo "   ¯\_(ツ)_/¯"
