# You know the drill. Be root or a sudo user.
# This Documentation has been tested successfully on both CentOS7.x and RHEL7.x.
# In particulary, they are as follows.
# CentOS Linux release 7.5.1804 (Core)
# CentOS Linux release 7.6.1810 (Server with GUI)
# Red Hat Enterprise Linux Server release 7.5 (Maipo)
# Red Hat Enterprise Linux Server release 7.6 (Maipo)

# We will need this.
yum groups install "Development Tools"

# We will need this. 
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# We need both python2(default) and python3(adding now).
yum install python36 python36-devel python36-setuptools

# Let pip do the walking. Security a concern? 
easy_install-3.6 pip
pip3 install cmake
# opencv-python (numpy)
pip3 install opencv-python 
# face_recognition (face-recognition-models, dlib)
pip3 install face_recognition

# A good webcam utility for fun (jkd) for later use or for testing purposes
# A selfie by #fswebcam smile.jpeg
yum install http://rpms.remirepo.net/enterprise/7/remi/x86_64//gd-last-2.2.5-5.el7.remi.x86_64.rpm
yum install https://rpmfind.net/linux/fedora/linux/development/rawhide/Everything/x86_64/os/Packages/f/fswebcam-20140113-10.fc29.x86_64.rpm

# pam_python
yum install http://widehat.opensuse.org/opensuse/repositories/home:/zhonghuaren/Fedora_28/x86_64/pam_python-1.0.6-2.1.x86_64.rpm

# This is it.
yum install https://github.com/williamwlk/my-red-corner/raw/master/howdy-2.4.0-2.el7.x86_64.rpm

# Sigh
ln -s /usr/bin/python3.6 /usr/bin/python3

# Sigh
echo "/usr/local/lib/python3.6/site-packages" > /usr/lib/python3.6/site-packages/usrlocal.pth
echo "/usr/local/lib64/python3.6/site-packages" > /usr/lib64/python3.6/site-packages/usrlocal.pth

# Let me configure howdy for you.
wget https://raw.githubusercontent.com/williamwlk/my-red-corner/master/let_me_configure_howdy_for_you.sh && chmod +x let_me_configure_howdy_for_you.sh
./let_me_configure_howdy_for_you.sh

# That's it. I guess.
# ¯\_(ツ)_/¯"
