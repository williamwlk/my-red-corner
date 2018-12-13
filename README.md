# my-red-corner
# Providing a helping hand for https://github.com/boltgolt/howdy 
# Especially on CentOS and RHEL

1. CentOS Linux or RHEL release 7.x (Server with GUI)
- CentOS Linux release 7.5 
- RHEL 7.5

2. howdy_install_centos7_rhel7.sh

3. let_me_configure_howdy_for_you.sh (This step is part of howdy_install_centos7_rhel7.sh)

4. SELinux: We probably need to make the version of Python that you just installed (i.e python3.6) work with the webcam. Execute, either as root or using sudo:

ausearch -c 'python3' --raw | audit2allow -M my-python3
semodule -i my-python3.pp

5. HOWDY :)

Please configure SELinux as Permissive for now. I need to make python3.6 (not default) work with the webcam. Trivial. But later. 

# Pleaes refer to selinux-troubleshoot.txt for more information about SELinux.
