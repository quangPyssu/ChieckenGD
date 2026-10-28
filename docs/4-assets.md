# 4. Assets

Assets live beside the feature that uses them (see the File Map in [Architecture](3-architecture.md)). This page lists what each folder holds.

## Inventory

| Folder | Contents |
|---|---|
| `player/sprites/` | Battlecruiser base, engine, destruction, shield, Dreadnought shield, ammo counter, fire jet |
| `player/weapons/*/` | Blaster bullet frames and shot sound, minigun spent shell, mega beam sound |
| `enemies/chicken/` | Body, face sheet (15×5 eye directions), shirt, feather particle, death sound |
| `enemies/projectiles/*/` | Egg, asteroid (+ rock sound), UFO bullet, Blue Zig sprites |
| `bosses/boss_chicken/` | Body in 3 damage stages, death sound |
| `bosses/ufo/` | UFO in 2 damage stages, engine sounds, glass and debris particles |
| `bosses/space_ship/` | Body sheet (33 frames for turning toward the player), exhaust, ram sound |
| `bosses/mother_hen/` | Layered parts (structure, yolk, egg white + shader, shell pieces), beam and shell sounds |
| `bosses/henterprise/` | Ship front/back, electro/taper beams + shaders, sun ball, warning strip, charge particle |
| `bosses/henporer/` | Body, limbs, cape + shader, Sky Descend star and sounds, flares |
| `shared/effects/` | Explosion, white/circle textures, beam materials, big/small beam textures, flares, mini bullet |
| `shared/audio/` | Explosion, small laser, mini bullet, bugle zap, boss cry |
| `shared/music/` | 12 tracks (level and boss music) |
| `game/backgrounds/` | Blue, orange, purple and color backgrounds |
| `ui/shared/` | Buttons, HUD/loadout icons, `neuro.ttf`, UI sounds, star-surface menu background |
| `ui/level_select/` | Galaxy background, planet sprites, info table |
| `ui/level_end/` | Win/lose headers, background |
| `_unused/` | Assets nothing references (alternate death sounds, extra icons, a spare rock sound and other spares). Godot ignores this folder. Move a file out to use it |

## Notes

- `hud.gd` loads weapon icons by ID (`ui/shared/icons/weapon_<id>.jpg`), so keep that filename pattern.
- Special icons are named after their ID: `special_0_spread_shot`, `special_1_shield`, `special_2_mega_beam`.

## Provenance

The original source of most art and audio is **not recorded**. Before any public release, check these:

- **Music:** The track names (*Necrofantasia*, *Love-Colored Master Spark*, *Retribution Night*, etc.) match Touhou Project songs or arrangements.
- **Boss names and SFX:** "Henterprise", "Henperor" and several boss sounds closely resemble Chicken Invaders content.

For a revamp meant for release, plan to **replace or license** these. Swap files in place under the same name, or move them in the Godot editor, which updates references automatically.
