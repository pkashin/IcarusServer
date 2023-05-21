taskkill /pid IcarusServer-Win64-Shipping.exe
cd "C:\Icarus\Control"
for /f "tokens=2 delims==" %%i in ('findstr ServerName Settings.ini') do set ServerName=%%i
for /f "tokens=2 delims==" %%i in ('findstr JoinPassword Settings.ini') do set JoinPassword2=%%i
for /f "tokens=2 delims==" %%i in ('findstr AdminPassword Settings.ini') do set AdminPassword2=%%i

if not exist "C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini" (
    mkdir "C:\Icarus\Icarus\Saved\Config\WindowsServer"
    cd "C:\Icarus\Icarus\Saved\Config\WindowsServer"
    echo [/Script/Icarus.DedicatedServerSettings] > ServerSettings.ini
    echo SessionName= >> ServerSettings.ini
    echo JoinPassword=%JoinPassword2% >> ServerSettings.ini
    echo MaxPlayers=8 >> ServerSettings.ini
    echo ShutdownIfNotJoinedFor=300.000000 >> ServerSettings.ini
    echo ShutdownIfEmptyFor=300.000000 >> ServerSettings.ini
    echo AdminPassword=%AdminPassword2% >> ServerSettings.ini
    echo LoadProspect= >> ServerSettings.ini
    echo CreateProspect= >> ServerSettings.ini
    echo ResumeProspect=True >> ServerSettings.ini
    echo LastProspectName= >> ServerSettings.ini
    echo AllowNonAdminsToLaunchProspects=True >> ServerSettings.ini
    echo AllowNonAdminsToDeleteProspects=False >> ServerSettings.ini
)

cd "C:\Icarus\Icarus\Saved\Config\WindowsServer"
for /f "tokens=2 delims==" %%i in ('findstr SessionName ServerSettings.ini') do set SessionName=%%i
for /f "tokens=2 delims==" %%i in ('findstr JoinPassword ServerSettings.ini') do set JoinPassword=%%i
for /f "tokens=2 delims==" %%i in ('findstr MaxPlayers ServerSettings.ini') do set MaxPlayers=%%i
for /f "tokens=2 delims==" %%i in ('findstr ShutdownIfNotJoinedFor ServerSettings.ini') do set ShutdownIfNotJoinedFor=%%i
for /f "tokens=2 delims==" %%i in ('findstr ShutdownIfEmptyFor ServerSettings.ini') do set ShutdownIfEmptyFor=%%i
for /f "tokens=2 delims==" %%i in ('findstr AdminPassword ServerSettings.ini') do set AdminPassword=%%i
for /f "tokens=2 delims==" %%i in ('findstr LoadProspect ServerSettings.ini') do set LoadProspect=%%i
for /f "tokens=2 delims==" %%i in ('findstr CreateProspect ServerSettings.ini') do set CreateProspect=%%i
for /f "tokens=2 delims==" %%i in ('findstr ResumeProspect ServerSettings.ini') do set ResumeProspect=%%i
for /f "tokens=2 delims==" %%i in ('findstr LastProspectName ServerSettings.ini') do set LastProspectName=%%i
for /f "tokens=2 delims==" %%i in ('findstr AllowNonAdminsToLaunchProspects ServerSettings.ini') do set AllowNonAdminsToLaunchProspects=%%i
for /f "tokens=2 delims==" %%i in ('findstr AllowNonAdminsToDeleteProspects ServerSettings.ini') do set AllowNonAdminsToDeleteProspects=%%i

if not %JoinPassword%==%JoinPassword2% set res=true
if not %AdminPassword%==%AdminPassword2% set res=true
if %res%==true (
    del ServerSettings.ini
    echo [/Script/Icarus.DedicatedServerSettings] > ServerSettings.ini
    echo SessionName=%SessionName% >> ServerSettings.ini
    echo JoinPassword=%JoinPassword2% >> ServerSettings.ini
    echo MaxPlayers=%MaxPlayers% >> ServerSettings.ini
    echo ShutdownIfNotJoinedFor=%ShutdownIfNotJoinedFor% >> ServerSettings.ini
    echo ShutdownIfEmptyFor=%ShutdownIfEmptyFor% >> ServerSettings.ini
    echo AdminPassword=%AdminPassword2% >> ServerSettings.ini
    echo LoadProspect=%LoadProspect% >> ServerSettings.ini
    echo CreateProspect=%CreateProspect% >> ServerSettings.ini
    echo ResumeProspect=%ResumeProspect% >> ServerSettings.ini
    echo LastProspectName=%LastProspectName% >> ServerSettings.ini
    echo AllowNonAdminsToLaunchProspects=%AllowNonAdminsToLaunchProspects% >> ServerSettings.ini
    echo AllowNonAdminsToDeleteProspects=%AllowNonAdminsToDeleteProspects% >> ServerSettings.ini
)

start C:\Icarus\IcarusServer.exe -SteamServerName=%ServerName% -Port=1777 -QueryPort=27015 -Log
