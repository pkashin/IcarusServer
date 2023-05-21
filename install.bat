echo opens ports 17777/udp and 27015/udp
netsh advfirewall firewall add rule name="Icarus open PORT 17777/udp" protocol=UDP localport=17777 action=allow dir=IN
netsh advfirewall firewall add rule name="Icarus open PORT 27015/udp" protocol=UDP localport=27015 action=allow dir=IN

echo creating a directory to manage the server
cd "C:\"
mkdir "C:\Icarus\Control"
cd /d "%~dp0"
copy /y Settings.ini "C:\Icarus\Control\Settings.ini"

echo creating the start.bat file to start the server
cd "C:\Icarus\Control"
echo taskkill /pid IcarusServer-Win64-Shipping.exe > "C:\Icarus\Control\start.bat"
echo for /f "tokens=2 delims==" %%i in ('findstr ServerName Settings.ini') do set name=%%i >> "C:\Icarus\Control\start.bat"
echo for /f "tokens=2 delims==" %%i in ('findstr JoinPassword Settings.ini') do set joinpassword=%%i >> "C:\Icarus\Control\start.bat"
echo for /f "tokens=2 delims==" %%i in ('findstr AdminPassword Settings.ini') do set adminpassword=%%i >> "C:\Icarus\Control\start.bat"
echo if not exist "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" (echo [/Script/Icarus.DedicatedServerSettings] > "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo SessionName= >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo JoinPassword=%joinpassword% >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo MaxPlayers=8 >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo ShutdownIfNotJoinedFor=300.000000 >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo ShutdownIfEmptyFor=300.000000 >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo AdminPassword=%adminpassword% >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo LoadProspect= >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo CreateProspect= >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo ResumeProspect=True >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo LastProspectName= >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo AllowNonAdminsToLaunchProspects=True >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" & echo AllowNonAdminsToDeleteProspects=False >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini") >> "C:\Icarus\Control\start.bat"
::cd "C:\Icarus\Icarus\Saved\Config\WindowsServer"
::echo for /f "tokens=2 delims==" %%i in ('findstr JoinPassword ServerSettings.ini') do set joinpassword2=%%i >> "C:\Icarus\Control\start.bat"
::echo for /f "tokens=2 delims==" %%i in ('findstr AdminPassword ServerSettings.ini') do set adminpassword2=%%i >> "C:\Icarus\Control\start.bat"
::echo if not "%joinpassword%"=="%joinpassword2%" (echo JoinPassword=%joinpassword% >> "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini") >> "C:\Icarus\Control\start.bat"
:: изменить значение параметра JoinPassword в файле ServerSettings.ini


echo start C:\Icarus\IcarusServer.exe -SteamServerName="%name%" -Port=17777 -QueryPort=27015 -Log >> "C:\Icarus\Control\start.bat"

echo creating the update.bat file to update the server
echo taskkill /pid IcarusServer-Win64-Shipping.exe > "C:\Icarus\Control\update.bat"
echo cd "C:\steamcmd" >> "C:\Icarus\Control\update.bat"
echo steamcmd +login anonymous +force_install_dir "C:\Icarus" +app_update 2089300 validate +quit >> "C:\Icarus\Control\update.bat"
echo cd "C:\Icarus\Control" >> "C:\Icarus\Control\update.bat"
echo start.bat >> "C:\Icarus\Control\update.bat"

echo add autorun start.bat
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Icarus Server" /t REG_SZ /d "C:\Icarus\Control\start.bat" /f



:: additional software for Windows Server 2022
curl -o VC_redist.x64.exe https://download.visualstudio.microsoft.com/download/pr/eaab1f82-787d-4fd7-8c73-f782341a0c63/917C37D816488545B70AFFD77D6E486E4DD27E2ECE63F6BBAAF486B178B2B888/VC_redist.x64.exe
VC_redist.x64.exe /install /quiet /norestart
del VC_redist.x64.exe
curl -o directx_Jun2010_redist.exe https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe
mkdir "C:\dx"
directx_Jun2010_redist.exe /Q /T:"C:\dx"
del directx_Jun2010_redist.exe
cd "C:\dx"
DXSETUP.exe /silent
rmdir /s /q "C:\dx"

:: download and install steamcmd
cd /d "%~dp0"
curl -o steamcmd.zip https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
mkdir "C:\steamcmd"
tar -xf steamcmd.zip -C "C:\steamcmd"
del steamcmd.zip
cd "C:\steamcmd"
steamcmd +login anonymous +force_install_dir "C:\Icarus" +app_update 2089300 validate +quit

:: запуск сервера
cd "C:\Icarus\Control"
start.bat

:: install directx
::cd "C:\dx"
::DXSETUP.exe /silent

:: delete the folder with the directx installer
::cd ..
::rmdir /s /q "C:\dx"

::mkdir "C:\icarus\control"
::copy

:: create a batch file to start the server
::echo taskkill /pid IcarusServer-Win64-Shipping.exe > "C:\icarus\start.bat"

:: переход в папку с батником
::cd /d "%~dp0"
