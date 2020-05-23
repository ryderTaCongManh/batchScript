ECHO off
ECHO ******************************* NFC POLLING APP ****************************************
Rem arg[1]  CARDTYPE 
Rem             {ISO14443A: 0}
Rem             {ISO14443B: 1}
Rem             {Felica   : 2}
Rem             {ISO156693: 3}
Rem **********************************************************************************
Rem arg[2]  NUMPOLL
Rem             Integer: number of time for polling
Rem **********************************************************************************
Rem arg[3]  CONSECUTIVE_DUR(milisecond)
Rem             Integer: duration in between two consecutive polling
Rem **********************************************************************************

Rem Create the file /data/log.txt 
ECHO Create the file /data/log.txt
adb.exe shell touch /data/log.txt

Rem CARDTYPE = Felica; NUMPOLL = 100; CONSECUTIVE_DUR = 50 
ECHO CARDTYPE = Felica; NUMPOLL = 100; CONSECUTIVE_DUR = 50 
 
adb.exe shell am start -n "com.styl.pollingSupportCertification/com.styl.example049.modules.yf2.view.Yf2Actitity" -e CARDTYPE "2" -e NUMPOLL "100" -e CONSECUTIVE_DUR "50" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER

:Loop 
SET /A PID = 0  
for /f %%i in ('.\adb.exe shell pidof com.styl.pollingSupportCertification') do set PID=%%i
echo "PID: " + %PID%
IF %PID% == 0 (goto CorrectIf) ELSE (goto WrongIf)

:CorrectIf
echo "PID is zero "
goto Complete
:WrongIf
echo "Still working in progress"
timeout 1
goto Loop
 
:Complete
adb.exe pull /data/log.txt
echo please check file log.txt in the same path.
pause