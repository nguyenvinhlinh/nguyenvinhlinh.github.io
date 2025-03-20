---
layout: post
title: "How to create .rpm package for elixir project?"
date: 2025-03-21 01:00:00
update:
location: Saigon
tags:
- elixir
- rpm
categories: Elixir
seo_description: A simple solution to create .rpm package for Elixir project
seo_image:
comments: true
---

## Step 1. Prepare source code tarball
In this step, I would like to use my repo named [ASIC Sentry](https://github.com/nguyenvinhlinh/ASIC-Sentry/) for example

```shell
$ git clone https://github.com/nguyenvinhlinh/ASIC-Sentry/ asic-sentry
$ cd asic-sentry
$ git checkout v1.0.0
$ cd ..
$ mv asic-sentry asic-sentry-1.0.0
$ tar -cJvf asic-sentry-1.0.0.tar.xz asic-sentry-1.0.0
```

Now your source code tarball is ready for next step!

## Step 2. Setup `$HOME/rpmbuild` directory
Use this command to create a directory structure for `rpmbuild`
```shell
$ rpmdev-setuptree
$ tree $HOME/rpmbuild

$ tree $HOME/rpmbuild
/home/nguyenvinhlinh/rpmbuild
├── BUILD
├── RPMS
├── SOURCES
├── SPECS
└── SRPMS
```

## Step 3. Copy source code tarball to `SOURCES`.

```sh
$ tree $HOME/rpmbuild
/home/nguyenvinhlinh/rpmbuild
├── BUILD
├── BUILDROOT
├── readme.md
├── RPMS
├── SOURCES
│   └── asic-sentry-1.0.0.tar.xz <----- your tarball here!
├── SPECS
│   ├── asic-sentry-1.0.0.spec
└── SRPMS
```
## Step 3. Create new `SPECS/.spec` file
Ignore this step if you modify existing one!

```bash
$ cd SPECS;
$ rpmdev-newspec;
```

Update:

- Version
- Release
- Source0

This is an example of mine `asic-sentry-1.0.0.spec`
```yaml
Name: asic-sentry
Version: 1.0.0
Release:        1%{?dist}
Summary: ASIC Sentry is a monitoring software designed to collect and send operational logs from ASIC Miners to a Mining Rig Monitor

License: GNU General Public License v3.0
URL: https://github.com/nguyenvinhlinh/ASIC-Sentry
Source0: asic-sentry-1.0.0.tar.xz

%description
ASIC Sentry is a monitoring software designed to collect and send operational logs from ASIC Miners to a Mining Rig Monitor

%global debug_package %{nil}

%prep
%autosetup

%build
cd assets;
npm install;
cd ..;
mix deps.get --only prod
MIX_ENV=prod mix compile
MIX_ENV=prod mix assets.deploy
MIX_ENV=prod mix release


%install
mkdir -p %{buildroot}/opt/asic_sentry
cp -r _build/prod/rel/asic_sentry/* %{buildroot}/opt/asic_sentry


%files
...
... A long list of installed files.
...

%changelog
* Tue Feb 04 2025 Nguyen Vinh Linh <nguyenvinhlinh93@gmail.com>
- Support KS5L asic
```

## Step 3. Run `rpmbuild`
```bash
$ cd SPECS;
$ rpmbuild -bb asic-sentry-1.0.0.spec
```

Gonna see error:
```
ERROR   0002: file '/opt/asic_sentry/lib/crypto-5.5/priv/lib/crypto.so' contains an invalid runpath '/usr/local/lib64'
```

`crypto` is an erlang module. I dont know how to modify it. this is a work around!
```
$ cd SPECS;
$ export QA_RPATHS=$(( 0x0001|0x0002 ))
$ rpmbuild -bb asic-sentry-1.0.0.spec
```

## Step 4. Provide `%files`
Those file would be listed after running `rpmbuild -bb asic-sentry-1.0.0.spec`.

Append it and re-run `rpmbuild -bb asic-sentry-1.0.0.spec` to make rpm.
```
RPM build errors:
    Installed (but unpackaged) file(s) found:
   /opt/asic_sentry/bin/migrate
   /opt/asic_sentry/bin/migrate.bat
   /opt/asic_sentry/bin/asic_sentry
   /opt/asic_sentry/bin/asic_sentry.bat
   /opt/asic_sentry/bin/server

```

Check out `RPMS` directory! RPM should be there!

```
➜ rpmbuild (master) ✗ tree -L 3
.
├── BUILD
├── BUILDROOT
├── readme.md
├── RPMS
│   └── x86_64
│       ├── asic-sentry-1.0.0-1.fc40.x86_64.rpm <----------- your file here!
│       ├── asic-sentry-debuginfo-1.0.0-1.fc40.x86_64.rpm
│       └── asic-sentry-debugsource-1.0.0-1.fc40.x86_64.rpm
├── SOURCES
│   └── asic-sentry-1.0.0.tar.xz
├── SPECS
│   ├── asic-sentry-1.0.0.spec
└── SRPMS
```
