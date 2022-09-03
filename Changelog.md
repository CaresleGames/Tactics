# Changelog

This project uses Semantic versioning.

## v0.2 - 02-09-2022 

### Added

- Load the battle data after the battle
- Disable all the previous battles triggered
- Some sprites for making the prototype a little nice to see
- Scenes:
  - WorldMap, created from the `TileMap` Node in WorldeTest

- Nodes:
  - TileMap node in WorldTest (`TileMap2`)

- Sprites:
  - Player idle sprite
  - Enemy idle sprite
  - Tilemap for the world map
  - Tilemap for the battle zone

### Changed
- Sprites:
  - Tilemap of the `Map` Node in BattleZone
  - Tilemap of the `TileMap` Node in WorldTest

## [v0.1] - 21-08-2022

### Added

- Player basic movement in the world map
- PlayerBattle
  - Movement in a 3x3 grid
  - Attack command
  - Defense command
  - Take damage command
- Enemy
  - Random movement
  - Take damage from the player
- Tileset
  - Placeholder for the battlezone
  - Placeholder for the worldmap

### Known Issues

Issues that can't be fixed before the release

- The battle data ignores de data saved like `player position` or battle trigger
