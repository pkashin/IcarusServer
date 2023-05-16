:: opens ports 17777/udp and 27015/udp
netsh advfirewall firewall add rule name="Icarus open PORT 17777/udp" protocol=UDP localport=17777 action=allow dir=IN
netsh advfirewall firewall add rule name="Icarus open PORT 27015/udp" protocol=UDP localport=27015 action=allow dir=IN

:: additional software for Windows Server 2022
curl -o vcredist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
curl -o directx_Jun2010_redist.exe https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe

:: download and install steamcmd
curl -o steamcmd.zip https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip
mkdir "C:\steamcmd"
tar -xf steamcmd.zip -C "C:\steamcmd"
cd "C:\steamcmd"
steamcmd +login anonymous +force_install_dir "C:\Icarus" +app_update 2089300 validate +quit
