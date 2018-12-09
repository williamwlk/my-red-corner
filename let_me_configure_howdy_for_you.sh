#!/usr/bin/env bash
# By williamwlk
# December 10, 2018
# set -o errexit
set -o pipefail
set -o nounset

pam_file1=/etc/pam.d/system-auth
pam_file2=/etc/pam.d/gdm-password
webcam_count=$(ls /dev/video? 2> /dev/null | wc -l)
howdy_config_file=$(rpm -qc howdy)

echo "1. WEBCAM - Let me find a webcam for howdy and configure it."

if [ ${webcam_count} = 0 ];then
	echo "   No webcam. No howdy. Go find one."
	exit 1
elif [ ${webcam_count} = 1 ];then
        echo "   Life is easy peasy. Really."
	webcam_device=$(ls /dev/video?)
        howdy_device_path=$(udevadm info --query=symlink --root --name ${webcam_device} | awk '{print $2}')
        sed -i "s|none|${howdy_device_path}|g" ${howdy_config_file}
        echo "   $(cat ${howdy_config_file} | grep device_path)"
elif [ ${webcam_count} -ge 2 ];then
        echo "   More than one webcam? Did it for you with the default /dev/video0."
        howdy_device_path=$(udevadm info --query=symlink --root --name /dev/video0 | awk '{print $2}')
        sed -i "s|none|${howdy_device_path}|g" ${howdy_config_file}
        echo "   $(cat ${howdy_config_file} | grep device_path)"
fi

echo "2. PAM : Now, the last step but the most crucial one: configuring PAM."

sed -i '4i\ ' ${pam_file1} 
sed -i '5i # Howdy IR face recognition' ${pam_file1}
sed -i '6i auth sufficient pam_python.so /usr/lib64/security/howdy/pam.py' ${pam_file1}
sed -i '7i\ ' ${pam_file1} 

sed -i '1i # Howdy IR face recognition' ${pam_file2} 
sed -i '2i auth sufficient pam_python.so /usr/lib64/security/howdy/pam.py' ${pam_file2} 
sed -i '3i\ ' ${pam_file2} 

echo "3. Enjoy your howdy. Don't forget to thank boltgolt, buy him a coffee or star the repo."
echo "   ¯\_(ツ)_/¯"
