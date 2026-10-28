# Space Chicken

A homemade 2D vertical shoot-'em-up in the style of Chicken Invaders, built in Godot 4 with GDScript. You fly a battlecruiser through 6 levels of chicken waves and hazard showers, and each level ends in a boss fight. Clearing a level unlocks new weapons for the next one.

- **Engine:** Godot 4 (`project.godot` declares 4.6), GDScript only
- **Resolution:** 1920×1080 fixed viewport, fullscreen
- **Entry scene:** `ui/main_menu/main_menu.tscn`
- **Status:** v1.01 (April 2024). Complete and playable. Being prepared for a gameplay/art revamp.

## Run

Open the folder in Godot 4 and press **F5**. Export presets are in `export_presets.cfg`.

## Documentation

Read top-down: each doc goes one level deeper than the one before it.

| # | Doc | What it covers |
|---|-----|----------------|
| 1 | [Game Overview](docs/1-game-overview.md) | Concept, controls, game loop, progression |
| 2 | [Content](docs/2-content.md) | Player kit, enemies, bosses, level-by-level waves |
| 3 | [Architecture](docs/3-architecture.md) | Scenes, scripts, class hierarchy, wave system, save data |
| 4 | [Assets](docs/4-assets.md) | Folder layout, art/audio inventory, provenance |
| 5 | [Known Issues](docs/5-known-issues.md) | Bugs and tech debt to fix during the revamp |
