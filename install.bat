echo opens ports 17777/udp and 27015/udp
netsh advfirewall firewall add rule name="Icarus open PORT 17777/udp" protocol=UDP localport=17777 action=allow dir=IN
netsh advfirewall firewall add rule name="Icarus open PORT 27015/udp" protocol=UDP localport=27015 action=allow dir=IN

echo creating a directory to manage the server
cd "C:\"
mkdir "C:\Icarus\Control"
cd /d "%~dp0"
copy /y Settings.ini "C:\Icarus\Control\Settings.ini"
xcopy /y control "C:\Icarus\Control"

echo add autorun start.bat
schtasks /create /tn "IcarusServer" /tr "C:\Icarus\Control\start.bat" /sc onstart /ru SYSTEM /f

echo download and install steamcmd
cd /d "%~dp0"
curl -o steamcmd.zip https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
mkdir "C:\steamcmd"
tar -xf steamcmd.zip -C "C:\steamcmd"
del steamcmd.zip
cd "C:\steamcmd"
steamcmd +login anonymous +force_install_dir "C:\Icarus" +app_update 2089300 validate +quit

echo install additional software for Windows Server 2022
cd /d "%~dp0"
curl -o VC_redist.x64.exe https://download.visualstudio.microsoft.com/download/pr/eaab1f82-787d-4fd7-8c73-f782341a0c63/917C37D816488545B70AFFD77D6E486E4DD27E2ECE63F6BBAAF486B178B2B888/VC_redist.x64.exe
VC_redist.x64.exe /install /quiet /norestart
del VC_redist.x64.exe
curl -o directx_Jun2010_redist.exe https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe
mkdir "C:\dx"
directx_Jun2010_redist.exe /Q /T:"C:\dx"
del directx_Jun2010_redist.exe
cd "C:\dx"
DXSETUP.exe /silent
cd "C:\"
rmdir /s /q "C:\dx"

echo start the server
cd "C:\Icarus\Control"
start.bat
