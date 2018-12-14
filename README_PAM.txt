# By williamwlk
# December 14, 2018
# README_PAM.txt 
# Part of https://github.com/williamwlk/my-red-corner
# Providing a helping hand for https://github.com/boltgolt/howdy
# Especially on CentOS and RHEL

Linux Pluggable Authentication Modules (PAM)

> https://en.wikipedia.org/wiki/Linux_PAM

> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system-level_authentication_guide/pam_configuration_files

Under Ubuntu Distro, for howdy, we just have to deal with one file:
/etc/pam.d/common-auth

But under RHEL/CentOS, we have to deal with two:

/etc/pam.d/system-auth and /etc/pam.d/gdm-password

gdm-password governs the Gnome GUI login and stuff while system-auth helps with the remaining login stuff such as sudo, su, and ssh, and console.

And a little akward (a non issue) here is this:

We can't mannually edit the file /etc/pam.d/system-auth (which I did for howdy) and if we do, the command 'authconfig' reverts all changes made in /etc/pam.d/system-auth.

And you will see the comments below at the beginnig of the file /etc/pam.d/system-auth.

#%PAM-1.0
# This file is auto-generated.
# User changes will be destroyed the next time authconfig is run.

What do we do about it?

> Resolution 1 (Not really a resolution but more like an FYI)

Just be aware of this and whatever changes we have made against the file /etc/pam.d/system-auth manually will be gone whenever you happen to run 'authconfig'.

And you will have to re-populate this:

-
# Howdy IR face recognition
auth sufficient pam_python.so /usr/lib64/security/howdy/pam.py
-

> Resolution 2 (by Red Hat at https://access.redhat.com/solutions/34521)

/etc/pam.d/system-auth is a symlink to /etc/pam.d/system-auth-ac

To configure "system-auth" so that it won't be edited by authconfig command, create a symlink to any file other than /etc/pam.d/system-auth-ac as authconfig command make changes on /etc/pam.d/system-auth-ac


# unlink /etc/pam.d/system-auth
# cp /etc/pam.d/system-auth-ac /etc/pam.d/system-auth-permanent
# ln -s /etc/pam.d/system-auth-permanent /etc/pam.d/system-auth

> Conclusion 

I wish we could discuss more about PAM and I intend on doing so when the time is right for me. 
For now, I hope you get the idea
