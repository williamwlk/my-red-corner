# my-red-corner

> Providing a helping hand for https://github.com/boltgolt/howdy

> Especially on CentOS and RHEL

## Installation {1..5}

1. CentOS Linux or RHEL release 7.x (Server with GUI)
- CentOS Linux release 7.5 
- RHEL 7.5

2. howdy_install_centos7_rhel7.sh

3. let_me_configure_howdy_for_you.sh (This step is part of howdy_install_centos7_rhel7.sh)

4. SELinux: if selinux is in 'Enforcing' mode, we probably need to make the version of Python that you just installed (i.e python3.6) work with the webcam. 

Execute, either as root or using sudo:

```sh
ausearch -c 'python3' --raw | audit2allow -M my-python3
semodule -i my-python3.pp
```

5. HOWDY :)


## Notes

> Please refer to [selinux-troubleshoot.txt](https://github.com/williamwlk/my-red-corner/blob/master/selinux-troubleshoot.txt) for more information about SELinux.

> Please refer to [README_PAM.txt](https://github.com/williamwlk/my-red-corner/blob/master/README_PAM.txt) for more information about PAM.
