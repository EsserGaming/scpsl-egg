> [!Note]
> **This is a fork of [Parkeymon's Repository](https://github.com/Parkeymon/EXILED-SCP-SL-egg)**
# scpsl-egg
**A Pterodactyl egg for SCP: Secret Laboratory that supports EXILED, SCPDiscord and extras.**

## Features:
- Game beta tag support (e.g for public betas)
- Options to choose the release, pre-release or a specific version of [EXILED](https://github.com/ExSLMod-Team/EXILED)
- Support to run the [SCPDiscord](https://github.com/KarlOfDuty/SCPDiscord/) Bot alongside the plugin
- Automiatically checks if the egg is up to date and notifies you when there is an update
- FFmpeg support (for use with audio player plugins)


## Using the SCPDiscord bot
1. Go to the startup tab in your server, then set `INSTALL SCP DISCORD?` to `true`.
2. Under the settings tab, press "Reinstall Server" and wait until the server has finished the process. **Re-installing will *not* delete your important files.**
1. Go to the files tab, and go to `/.egg/SCPDBot` and open `config.yml` to configure the bot.
> [!TIP]
> **To configure the bot and plugin, read the [installation guide](https://github.com/KarlOfDuty/SCPDiscord/blob/main/docs/Installation.md).**


## Custom Docker Images
### Server Image
https://github.com/EsserGaming/docker-scpsl
### Script Container
https://github.com/EsserGaming/scpsl-install-docker
