# IcarusServer
🕹️ Icarus Dedicated Server on VDS | Windows Server 2022 |

Translated into English - [Yandex Translate](https://translate.yandex.com/).

> The repository was created for rapid deployment of a dedicated Icarus server on VDS [ Windows Server 2022 ].
> After testing various versions of the Icarus server on Ubuntu and Windows, I came to the conclusion: at the moment, the most stable build is the following configuration.\
> VDS • 8 x 3.3GHz processor • 16 GB RAM • 160 GB NVMe (minimum 30 GB) • Windows Server 2022.\
> The performance of servers with similar characteristics, but located in different data centers, can differ significantly even from one service provider.

## Contents

1. [Installation](#Installation)
2. [Changing parameters and restarting](#Changing-parameters-and-restarting)
3. [Update](#Update)

## Installation

1. Download and unpack the archive of the latest [release](https://github.com/pkashin/IcarusServer/releases/latest ) on the target server.
2. Edit the `Settings.ini` file:
   - change the value of `SERVER_NAME` at your discretion for a quick search among dedicated servers.
   - if you plan to use a closed server, then you need to assign the appropriate password values to the `JoinPassword` and `AdminPassword` parameters.
   - save changes to a file.
```ini
; Example of a modified Settings.ini file
; change the value of SERVER_NAME at your discretion
ServerName=ICARUS_SERVER

; to start a closed server, change the values of the JoinPassword and AdminPassword parameters
JoinPassword=password1
AdminPassword=password2 
```
3. Run the batch file `install.bat` on behalf of the administrator, who will perform the following actions:
   - will open ports `17777/udp` and `27015/udp` in the firewall.
   - creates a directory `C:\Icarus\Control ` and copies the server management files (`Settings.ini`, `start.bat`, `update.bat`).
   - creates an `IcarusServer` scheduler task to automatically start the server when the system boots.
   - install `SteamCMD` and download the game to the folder `C:\Icarus `.
   - will install `Visual C++ Redistributable` and `DirectX`, which are required to run the game.
   - it will launch the `Icarus` game server with the parameters specified in the `Settings.ini` file.
4. After the server is successfully started, you can connect to it from a gaming PC by searching for the server by the name that was specified in the `Settings.ini` file in the `ServerName` parameter.
5. In order to switch the server from the search mode to the `lobby` mode, you must first confirm the administrator rights. Press `enter` and enter `/AdminLogin [Password2]` in the chat, where `[Password2]` is the administrator password specified in the `Settings.ini` file in the `AdminPassword` parameter. Next, enter `/ReturnToLobby` to switch the server to `lobby` mode. The full list of administrator commands and server settings can be viewed [here](https://github.com/RocketWerkz/IcarusDedicatedServer/wiki).
6. Server saves and backups are located in the directory `C:\Icarus\Icarus\Saved\PlayerData\DedicatedServer\Prospects`. If necessary, you can place saves from the gaming PC to the server and vice versa.

## Changing parameters and restarting

1. If you need to change the server settings, you need to edit the file `Settings.ini` or `C:\Icarus\Icarus\Saved\Config\WindowsServer\ServerSettings.ini` (the entire list of parameters) and restart the server by running the batch file `C:\Icarus\Control\start.bat` on behalf of the administrator.

## Update

1. After the game update is released (usually once a week), you need to update the server using a batch file `C:\Icarus\Control\update.bat` running as an administrator, which will perform the following actions:
   - will shut down the game server if it is running.
   - will update the game on the server using `SteamCMD`.
   - will launch the `Icarus` game server.
