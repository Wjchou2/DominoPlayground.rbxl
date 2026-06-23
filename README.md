# Domino Playground

Domino Playground is a Roblox experience built with Rojo and Luau. Players can spawn, push, and reset large domino layouts, collect Dots, buy more dominoes, open crates, equip skins, and interact with tutorial, leaderboard, feedback, teleport, and shop UI.

## Project Overview

- Procedural domino layouts are created by server scripts and placed into `workspace`.
- Touch/click interactions trigger domino fall animations and local sound feedback.
- Player progress is stored with Roblox DataStores through shared leaderstat helpers.
- Crates roll cosmetic domino skins by rarity, with duplicate rewards and skin multipliers defined in shared data modules.
- Shop systems support Dot purchases and Roblox developer-product purchases for crates and domino packs.
- StarterGui and StarterPlayer scripts handle the player-facing UI, messages, music, tutorial prompts, mobile controls, group prompts, and inventory interactions.

## Repository Layout

```text
src/
  ReplicatedStorage/        Shared modules, remote events, crate/skin/domino data, UI packages
  ServerScriptService/      Gameplay, persistence, purchases, spawning, crates, feedback, teleporting
  ServerStorage/            Server-only helper scripts and reusable model assets
  StarterGui/               Roblox UI assets
  StarterPlayer/            Client scripts that run for each player
  client/ and server/       Rojo template entry points
default.project.json        Rojo DataModel mapping
```

## Key Files

- `src/ServerScriptService/spawnDominos.server.luau` creates the domino courses and image-grid domino layout.
- `src/ServerScriptService/CrateHandler.server.luau` handles crate purchases, crate rolls, skin rewards, and developer-product receipts.
- `src/ReplicatedStorage/CrateHandler.luau` defines crate prices, images, colors, and rarity odds.
- `src/ReplicatedStorage/SkinData.luau` defines skin rarities, visual settings, duplicate rewards, and multipliers.
- `src/ReplicatedStorage/DominoData.luau` defines purchasable domino packs.
- `src/ServerScriptService/DatastoreControl.luau` wraps DataStore and ordered leaderboard access.
- `src/ServerScriptService/Teleport.server.luau` moves players to named workspace objects through a remote event.

## Development

Install Rojo, then build the place file:

```bash
rojo build -o "Domino.rbxlx"
```

Open `Domino.rbxlx` in Roblox Studio, then start the Rojo server:

```bash
rojo serve
```

In Roblox Studio, connect the Rojo plugin to the local server. The mapping in `default.project.json` syncs this repository into Roblox services such as `ReplicatedStorage`, `ServerScriptService`, `ServerStorage`, `StarterGui`, and `StarterPlayerScripts`.

## Notes

- DataStores and developer products only behave fully in a published Roblox experience with the correct universe/product configuration.
- Several systems expect named instances in `workspace`, including domino buttons, teleport targets, and leaderboard displays.
- The project includes third-party Roblox packages such as TopbarPlus-style `Icon` modules and ZonePlus-style `Zone` modules under `ReplicatedStorage`.
