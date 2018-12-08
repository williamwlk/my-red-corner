%global         debug_package %{nil}

Name:           howdy
Version:        2.4.0
Release:	2%{?dist}
Summary:        Windows Hello™ style authentication for Linux

Group:		System/Libraries
License:        MIT
URL:            https://github.com/boltgolt/%{name}
Source0:	https://github.com/boltgolt/howdy/archive/v2.4.0/howdy-2.4.0.tar.gz

Requires:       python36 
Requires:       python36-devel 
Requires:	pam
Requires:	pam-devel

%description
Windows Hello™ style authentication for Linux. Use your built-in IR emitters and camera in combination with face recognition to prove who you are.

%prep
%autosetup

%build
## nothing to build

%install
mkdir -p %{buildroot}%{_libdir}/security/%{name}
cp -pr src/* %{buildroot}%{_libdir}/security/%{name}

#Add bash completion
mkdir -p %{buildroot}%{_datadir}/bash-completion/completions
install -Dm 644 autocomplete/%{name} %{buildroot}%{_datadir}/bash-completion/completions

# Create an executable
mkdir -p %{buildroot}%{_bindir}
chmod +x %{buildroot}%{_libdir}/security/%{name}/cli.py
ln -s %{_libdir}/security/%{name}/cli.py %{buildroot}%{_bindir}/%{name}

%files
%license LICENSE
%doc README.md
%{_bindir}/%{name}
%{_datadir}/bash-completion/completions/%{name}
%{_libdir}/security/%{name}
%config(noreplace) %{_libdir}/security/%{name}/config.ini

%changelog
* Sat Dec 08 2018 William W.L.K <w@linuxlab.pro> - 2.4.0-2
- Signed with GPG
- Added Group Development/Libraries

* Sat Dec 08 2018 William W.L.K <w@linuxlab.pro> - 2.4.0-1
- Disabled brp-python-bytecompile
- Added %config
- Removed dependecies
- Original Spec by Luya Tshimbalanga <luya@fedoraproject.org> - 2.4.0-3
