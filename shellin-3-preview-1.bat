@echo off
title Shell~In 3 preview
setlocal EnableDelayedExpansion

if exist customcmds.log (
    for /f "tokens=1,* delims=:" %%A in (customcmds.log) do (
        set "custom_%%A=%%B"
    )
)

echo [35m {Shell~In}~{3.0/preview}
echo {Prod; MeeCarl}
echo {creds; assist.list}
powershell -Command "Write-Warning 'Shell~In is in preview mode, that means after full release, you must install Shell~In 3 manually.'"
:mainclass
set /p comd=[34m {shellIn}:~$ [32m
if /i "%comd%"=="quit" exit
if /i "%comd%"=="clear" goto :clear
if /i "%comd%"=="ping.website" goto :ping.website
if /i "%comd%"=="assist.list" goto :assist.list
if /i "%comd%"=="define.custom" goto :define.custom
if /i "%comd%"=="perf.mon" goto :perf.monitor
if /i "%comd%"=="control.panel" goto :control.panel
if /i "%comd%"=="res.mon" goto :res.monitor
if /i "%comd%"=="shutdown.interface" goto :shutdown.interface
if /i "%comd%"=="volume.mixer" goto :volume.mixer
if /i "%comd%"=="print.file" goto :print.file
if /i "%comd%"=="local.weather.cli" goto :local.weather.cli
if /i "%comd%"=="define.notify" goto :define.notify
if /i "%comd%"=="ps" goto ps1
if /i "%comd%"=="pseditor" goto pseditor
if /i "%comd%"=="firefox" goto firefox
if /i "%comd%"=="brave" goto brave
if /i "%comd%"=="qr.gen" goto qrgen

for /f "tokens=1,* delims==" %%a in ('set custom_ 2^>nul') do (
    set "cmdname=%%a"
    set "cmdbody=%%b"
    if /i "!comd!"=="!cmdname:custom_=!" (
        call !cmdbody!
        goto :mainclass
    )
)

echo [0m ' %comd% '[31m command / existence = false
goto :mainclass

:define.custom
pause >nul
set /p definecustomcomdname= {define.custom / command.name}:~$ 
set /p definecustomcomdfunc= {define.custom / command.func}:~$ 
echo custom_%definecustomcomdname%=%definecustomcomdfunc% >> customcmds.log
set "custom_%definecustomcomdname%=%definecustomcomdfunc%"
echo [32m Command '%definecustomcomdname%' has been defined.
goto :mainclass

:assist.list
echo.
echo [33m assist.list function;
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo quit ~ closes current session
echo clear ~ clears the screen
echo assist.list ~ shows the user this page
echo define.custom ~ allows you to create your own commands
echo ping.website ~ pings a website you enter
echo perf.mon ~ starts Perfomance Monitor
echo control.panel ~ starts Control Panel
echo res.mon ~ starts Resource Monitor
echo shutdown.interface ~ starts Remote Shutdown Dialog
echo volume.mixer ~ starts Volume Mixer
echo print.file ~ allows you to create your own file
echo local.weather.cli ~ enters Local Weather CLI mode
echo define.notify ~ allows you to create a notification
echo ps ~ starts powershell
echo pseditor ~ starts powershell ise
echo firefox ~ starts firefox
echo brave ~ starts brave
echo qr.gen ~ enters QRCODE Generator mode
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo  local.weather.cli
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo  - enter a city.
echo  - it will display the current weather and upcoming days for 
echo  morning, noon, evening, and midnight.
echo  - press any key to be able to enter another city.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo.
echo  qr.gen
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo  - enter a URL linking to a website of choice.
echo  - it will generate a QR Code to that website that you can 
echo  picture and it will lead you to that website.
echo  - press any key to be able to enter another URL.
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
goto :mainclass

:clear
cls
goto :mainclass

:ping.website
set /p pingwebsitename= {ping / [exa; www.google.com] / name}:~$ 
ping %pingwebsitename%
goto :mainclass

:perf.monitor
perfmon
goto :mainclass

:control.panel
control
goto :mainclass

:res.monitor
resmon
goto :mainclass

:shutdown.interface
shutdown /i
goto :mainclass

:volume.mixer
sndvol
goto :mainclass

:print.file
set /p printfiledetails={print.file / filedetails}:~$ 
set /p printfiletitle={print.file / filetitle}:~$ 
set /p printfileextension={print.file / fileextension}:~$ 
echo %printfiledetails% > %printfiletitle%.%printfileextension%
echo %printfiletitle%.%printfileextension% is printed!
goto :mainclass

:define.notify
set /p definenotificationtype={define.notify / notificationtype / alltypes; Error, Information, Question, Warning}:~$ 
set /p definenotificationtitle={define.notify / notificationtitle}:~$ 
set /p definenotificationdesc={define.notify / notificationdesc}:~$ 
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::%definenotificationtype%; $notify.Visible = $true; $notify.ShowBalloonTip(0, '%definenotificationtitle%', '%definenotificationdesc%', [System.Windows.Forms.ToolTipIcon]::None)}"
goto :mainclass

:ps1
start powershell
goto :mainclass

:pseditor
start powershell ise
goto :mainclass

:firefox
start firefox
goto :mainclass

:brave
start brave
goto :mainclass

:: ----------------------- local weather command -------------------------

:local.weather.cli
cls
title Local Weather CLI
goto :LW.CM

:LW.CM
set /p LW=[33m {shell.In} ~~~ 
curl wttr.in/%LW%
echo.
echo Retry another city?
pause >nul
cls
goto :LW.CM

:: ------------------------- qr generator command -----------------------

:qrgen
cls
title QRCODE Generator
goto QR.gene

:QR.gene
set /p qr=[33m {shell.In / exa; https://google.com} ~~~ [0m
curl qrenco.de/%qr%
echo.
echo [33m Retry?
pause >nul
cls
goto :QR.gene