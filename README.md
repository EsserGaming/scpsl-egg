> [!Note]
> **This is a fork of [Parkeymon's Repository](https://github.com/Parkeymon/EXILED-SCP-SL-egg)**
# EXILED-SCP-SL-egg
**A Pterodactyl egg for SCP: Secret Laboratory that supports EXILED and extras.**

> [!WARNING]
> The official EXILED repository has been taken down again. The developers haven't announced a new repo for the project, I will update the egg when that happens.

## Features:
- Game beta tag support. (e.g for public betas)
- Options to choose the release, pre-release or a specific version of ~~[EXILED](https://github.com/ExMod-Team/EXILED)~~ (Currently unavailable, the egg won't be able to install).
- Support to run the [SCPDiscord](https://github.com/KarlOfDuty/SCPDiscord/) Bot alongside the plugin.
- Automiatically checks if the egg is up to date and notifies you when there is an update.
- FFmpeg support (for use with audio player plugins).


## Using the SCPDiscord bot.
1. Go to the startup tab in your server, then set `INSTALL SCP DISCORD?` to `true`.
2. Under the settings tab, press "Reinstall Server" and wait until the server has finished the process.
> [!Note] 
**Re-installing will *not* delete your important files.**
3. Go to the files tab, and go to `/.egg/SCPDBot` and open `config.yml` to configure the bot.
> [!TIP]
> **To configure the bot and plugin, read the [installation guide](https://github.com/KarlOfDuty/SCPDiscord/blob/main/docs/Installation.md).**


## Custom Docker Images
### Server Image
https://github.com/EsserGaming/docker-scpsl
### Script Container
https://github.com/EsserGaming/scpsl-install-docker
