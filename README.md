# IcarusServer
🕹️ Icarus Dedicated Server on VDS | Windows Server 2022 |

Translated into English - Copilot

> Having tested various options for the Icarus server on Ubuntu and Windows, I came to the conclusion: at the moment, the most stable and less buggy build for me is the following configuration.
> VDS • 8 x 3.3 GHz processor • 16 GB of RAM • 160 GB NVMe • Windows Server 2022.

## Contents

1. [Installation](#Installation)
2. [Launch](#Launch)
3. [Setting](#Setting)
4. [Update](#Update)

## Installation

1. Download and unpack the archive [release](https://github.com/pkashin/IcarusServer/releases/latest) on the target server.
2. Run the batch file `install.bat` as administrator, which in turn will open the ports `17777/udp` and `27015/udp` in the firewall. Next, it will install `SteamCMD` and download the game to the `C:\Icarus` folder. It will also download `Visual C++ Redistributable` and `DirectX`, which must be installed manually.

## Launch

1. Use notepad to edit the `start.bat` file by changing the `SERVER_NAME` value at your discretion.
2. Run the batch file `start.bat` as administrator, which in turn will start the server.
3. Log in to the game on the gaming PC, select a character and connect (click on the `dedicated servers` on the top right) and search for the server by the name that was specified in the `start.bat` file in the `SERVER_NAME` value. Next, connect to the server, launch a new survey (land on the planet and return to orbit), which initiates saving configuration files on the server.

## Setting

1. Then on the server in the directory `C:\icarus\Icarus\Saved\Config\WindowsServer` edit the `ServerSettings.ini` file to set the `JoinPassword` login password and the `AdminPassword` administrator password.
```ini
[/Script/Icarus.DedicatedServerSettings]
SessionName=
JoinPassword=
MaxPlayers=8
ShutdownIfNotJoinedFor=300.000000
ShutdownIfEmptyFor=300.000000
AdminPassword=
LoadProspect=
CreateProspect=
ResumeProspect=True
LastProspectName=
AllowNonAdminsToLaunchProspects=True
AllowNonAdminsToDeleteProspects=False
```
2. When you are in `lobby` mode or searching for a server on a gaming PC, you can confirm the administrator status by pressing `enter` and entering the command `/AdminLogin [Password]` in the chat. After that, you can enter the command `/ReturnToLobby` to switch the server to the `lobby` mode.
3. The full list of administrator commands and server settings can be viewed [here](https://github.com/RocketWerkz/IcarusDedicatedServer/wiki).
4. The server's saves and backups are located in the directory `C:\icarus\Icarus\Saved\PlayerData\DedicatedServer\Prospects`. If necessary, you can place saves from the gaming PC to the server and vice versa.

## Update

1. After the game update is released (usually once a week), you need to update the server using the file `update.bat` on behalf of the administrator, who in turn will launch `SteamCMD` and update the game on the server.
