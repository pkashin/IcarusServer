:: opens ports 17777/udp and 27015/udp
netsh advfirewall firewall add rule name="Icarus open PORT 17777/udp" protocol=UDP localport=17777 action=allow dir=IN
netsh advfirewall firewall add rule name="Icarus open PORT 27015/udp" protocol=UDP localport=27015 action=allow dir=IN

:: additional software for Windows Server 2022
curl -o VC_redist.x64.exe https://download.visualstudio.microsoft.com/download/pr/eaab1f82-787d-4fd7-8c73-f782341a0c63/917C37D816488545B70AFFD77D6E486E4DD27E2ECE63F6BBAAF486B178B2B888/VC_redist.x64.exe
VC_redist.x64.exe /install /quiet /norestart
del VC_redist.x64.exe
curl -o directx_Jun2010_redist.exe https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe
mkdir "C:\dx"
directx_Jun2010_redist.exe /Q /T:"C:\dx"
del directx_Jun2010_redist.exe

:: download and install steamcmd
curl -o steamcmd.zip https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
mkdir "C:\steamcmd"
tar -xf steamcmd.zip -C "C:\steamcmd"
del steamcmd.zip
cd "C:\steamcmd"
steamcmd +login anonymous +force_install_dir "C:\icarus" +app_update 2089300 validate +quit

:: install directx
cd "C:\dx"
DXSETUP.exe /silent

:: delete the folder with the directx installer
cd ..
rmdir /s /q "C:\dx"
