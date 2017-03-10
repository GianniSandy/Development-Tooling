@echo off
rem.
rem. Improved startup for Uniface project setup application
rem.

if "%1"=="/?" goto SYNTAX
if "%1"=="-?" goto SYNTAX
if "%1"=="?" goto SYNTAX

if "%USYS97%"=="" goto ERROR_UNSET

if not "%1"=="" goto PROCEED1
echo No parameters passed! Assume FULL desktop project setup in current directory...
set PARAM1=
set PARAM2=
:PROCEED1

if not "%1"=="DUPL" if not "%1"=="dupl" if not "%1"=="Dupl" goto PROCEED2
if "%2"=="" goto SYNTAX
echo Duplicating project template type %2 in current directory...
set PARAM1=INIT
set PARAM2=%2
:PROCEED2

if not "%1"=="CREATE" if not "%1"=="create" if not "%1"=="Create" goto PROCEED3
set PARAM1=CREATE
set PARAM2=%2
if "%2"=="" set PARAM1=NEW
:PROCEED3

set CURRENTDIR=%cd%
set PACKAGESDIR=%~dp0
for %%A in ("%CURRENTDIR%") do (set CURRENTDISK=%%~dA)
for %%A in ("%PACKAGESDIR%") do (set PACKAGESDISK=%%~dA)

if not "%CURRENTDISK%"=="%PACKAGESDISK%" if not "%PACKAGESDISK%"=="" %PACKAGESDISK%
cd %PACKAGESDIR%

cd ProjectSetup97
set PROJSETUPDIR=%cd%

if not "%PARAM1%"=="NEW" goto PROCEED8
"%USYS97%\common\bin\uniface.exe" /adm="%USYS97%\uniface\adm\" /asn=.\asn\runtime.asn SETUP
goto PROCEED9

:PROCEED8
"%USYS97%\common\bin\uniface.exe" /adm="%USYS97%\uniface\adm\" /asn=.\asn\runtime.asn SETUP "%CURRENTDIR%" "%PACKAGESDIR%" %PARAM1% %PARAM2%

:PROCEED9
if not "%CURRENTDISK%"=="%PACKAGESDISK%" if not "%CURRENTDISK%"=="" %CURRENTDISK%
cd %CURRENTDIR%

set PROJSETUPDIR=
set PACKAGESDISK=
set CURRENTDISK=
set PACKAGESDIR=
set CURRENTDIR=
goto end

:ERROR_UNSET
echo Environment variable USYS97 is not set!
goto END

:SYNTAX
echo SYNTAX:
echo [DISK:][PATH]%~nx0 (NO parameters!)    = (default) FULL project desktop setup on current directory
echo                                                          based on .\project.xml template already customized
echo                                                          otherwise switching to CREATE mode (see next options)
echo [DISK:][PATH]%~nx0 CREATE              = FULL project setup on current directory
echo                                                          interactively choosing project template and directories
echo [DISK:][PATH]%~nx0 CREATE projectType  = FULL project "projectType" setup on current directory
echo [DISK:][PATH]%~nx0 DUPL projectType    = Duplicate project template "projectType" on current directory
echo.
echo In the original configuration projectType could be either "desktop" or "web"

:END
