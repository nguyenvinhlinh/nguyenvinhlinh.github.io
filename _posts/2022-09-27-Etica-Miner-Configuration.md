---
layout: post
title: "Etica Miner Configuration"
date: 2022-09-27 21:03:32 +0700
update:
location: Saigon
tags:
- Etica
- Mining Rig
categories:
- Mining Rig
seo_description:
seo_image:
comments: false
---
## Step 1: Download miner & extract - [lwYeo/SoliditySHA3Miner](https://github.com/lwYeo/SoliditySHA3Miner/releases)
In addition, install the following dependencies if need.
- [.NET Core 2.2 Runtime (v2.2.1)](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-2.2.1-windows-x64-installer)
- [Microsoft Visual C++ Redistributable (v15)](https://aka.ms/vs/15/release/vc_redist.x64.exe)

## Step 2: Make a file name `01-mine-etica.bat`

{% highlight bat %}
@echo off
pushd %~dp0

for %%X in (dotnet.exe) do (set FOUND=%%~$PATH:X)
if defined FOUND (goto dotNetFound) else (goto dotNetNotFound)

:dotNetNotFound
echo .NET Core is not found or not installed,
echo download and install from https://www.microsoft.com/net/download/windows/run
goto end

:dotNetFound
:startMiner
DEL /F /Q SoliditySHA3Miner.conf

SoliditySHA3Miner.exe ^
allowCPU=false ^
allowIntel=false ^
allowAMD=false ^
allowCUDA=true ^
abiFile=0xBTC.abi ^
contract=0xB6eD7644C69416d67B522e20bC294A9a9B405B31 ^
overrideMaxTarget=26959946667150639794667015087019630673637144422540572481103610249216 ^
pool=http://eticapool.com:8081 ^
address=0xE58796150958032349A32f20031645a3850Fe92C

if %errorlevel% EQU 22 (
  goto startMiner
)
:end
pause
{% endhighlight %}

## Step 3: Make a file name `02-oc-etica.bat`
{% highlight bat %}
nvidia-smi -lgc 1850
nvidia-smi -lmc 810
nvidia-smi -pl 220
pause
{% endhighlight %}

## Step 4: Execute `01-mine-etica.bat` & `02-oc-etica.bat`.
