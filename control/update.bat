taskkill /pid IcarusServer-Win64-Shipping.exe
cd "C:\steamcmd"
steamcmd +login anonymous +force_install_dir "C:\Icarus" +app_update 2089300 validate +quit
cd "C:\Icarus\Control"
start.bat
