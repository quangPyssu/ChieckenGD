# 3. Architecture

## Scene Flow

```
ui/main_menu ──► ui/level_select (level + loadout)
      │                    │
      └────────┬───────────┘   threaded load of Levels[Global.CurrentLevel]
               ▼
     levels/level_N.tscn  (inherits game/game.tscn)
               │  all waves cleared or player dead
               ▼
     ui/level_end (added as overlay) ──► level_select / main_menu / ui/credits
```

The level list (`res://levels/level_0.tscn` … `level_5.tscn`) is copied into three scripts: `game/game.gd`, `ui/main_menu/main_menu.gd` and `ui/level_select/level_select.gd`.

## game/game.tscn (base of every level)

| Node | Role |
|---|---|
| `Player` | Player ship (`player/player.tscn`) |
| `Enemies` | **Wave container.** Each child node is one wave |
| `Projectiles` | Parent for all bullets and particles. Scripts reach it through the hard-coded path `/root/Game/Projectiles` |
| `Camera` | Screen shake, driven by `Global.shakeStrength` |
| `BlueBlankBackground` | Scrolling background (stops scrolling during the final wave) |
| `Music`, `Paused`, `UI` | Background music, pause menu, HUD |

Each level scene inherits `game.tscn` and only fills in `Enemies`.

## Wave System (`game/game.gd`)

1. On start, every wave is disabled and hidden except the first child of `Enemies`.
2. Each frame: if the active wave has **no children left**, it is freed and the next wave is enabled.
3. When 2 waves remain, the boss music starts and the background stops scrolling.
4. When `Enemies` is empty, `Global.LevelEnd = true`. After 2 s the end menu appears.

**"Timer chicken" trick:** Waves that should last a set time (hazard showers, pauses) contain an **invincible, off-screen Enemy_Chicken** with `timerEnd = N`. That chicken frees itself after N seconds, which ends the wave. Spawners are made children of the timer chicken, so they stop when it disappears.

## Class Hierarchy

```
entity  (CharacterBody2D, core/entity.gd)
├── Player
├── Enemy_Chicken, Chick
├── Boss_Chicken, UFO, SpaceShip, MotherHen,
│   the_henterprise, the_henporer
├── entity_anchor   – formation: generates N enemies in a pattern
└── B_Anchor        – bullet swarm (bullet_anchor.gd): ring/grid of eggs

bullet  (Area2D, core/bullet.gd)
├── Egg, UFOBullet, Astroid, BlueZig, miniBullet_enemy, SunBall
├── bullet_player_normal, miniBullet_Player
└── beams: SmallBeam_Player/Enemy, BigBeam_Player, BigBeam_Mother,
           ElectroBeam, TaperBeam, the_Sky_Descend

spawner (Area2D)   – every BetweenSpawn s, spawns SpawnCnt bullets at random
                     points in its rect, all moving in a fixed direction
eggShell (Node2D)  – Mother Hen's destructible shell pieces
```

### `entity` provides
- `HP`, `take_damage()`, `kill()`. Damage is ignored while `isInvincible` is set.
- **Phase hooks:** `atThreeQuarterHealth()`, `atHalfHealth()` and `atQuarterHealth()`, which fire once each as HP crosses the threshold. Bosses override these.
- Movement: `direction * speed`, `gotoPosition(pos, speed)`, clamping to the screen and bouncing off the edges.
- `timerEnd`: when set, the entity is used as a lifetime timer and frees itself after that many seconds.
- `flicker()`: the hit flash. For the Player it also gives invulnerability frames.

### `bullet` provides
- `speed`, `accelaration` and `direction` movement. Bullets are freed once they are 300 px off screen.
- On `area_entered`, calls `take_damage(damage)` on the parent of the area it hit.
- Destructible bullets: `canBreak` and `HP`.
- Beams don't use `area_entered`. They poll `get_overlapping_areas()` every frame and apply damage over time.

### Node conventions
- **Entities:** `HitBox` (Area2D), `PhysicBox` (CollisionShape2D), `AnimationCenter` (root of all visuals), `Audio`, `Explosion`, `Marker`*.
- **Bullets:** `HitBox`, `AnimationCenter`, and `BulletSound` as the **last child**. Spawners lower its volume through `get_child(get_child_count()-1)`.

## Global State (`core/global.gd`, autoload `Global`)

| Group | Fields |
|---|---|
| Live HUD values | `HP/maxHP`, `SP/maxSP` (special charge), `AP/maxAP` (weapon charge) |
| Shared runtime | `PlayerPos`, `shakeStrength`, `LevelEnd`, `defeated`, `CurrentWeapon` |
| Tuning tables | `WeaponTime = [0.5, 2.0, 0.1]`, `SpecialTime = [8, 16, 30, ∞]` |
| Loadout / progress | `EquippedWeapon[2]`, `SpecialType`, `UnlockedWeapon[3]`, `UnlockedSpecial[3]`, `CurrentLevel`, `UnlockedLevel` |
| Enums | `patternType` (Circle, Square, HLine, VLine) and `SpawnType` (Egg, EnemyChicken, Astroid, SmallLaser, UFOBullet, Chick) |

Enemies read `Global.PlayerPos` to aim. The HUD (`ui/hud/hud.gd`) only reads from `Global`.

## Save Data (`save/save_data.gd`)

- File: `res://save/data.save`, written as sequential `store_var` values in this order: `CurrentLevel`, `UnlockedLevel`, 4 volume values, 2 equipped weapons, `SpecialType`.
- **Saved** when the main menu exits and when Start is pressed on Level Select.
- **Loaded** once, by the settings widget (`ui/settings/settings.gd`) the first time it is created.
- Unlocked weapons and specials are not saved. `level_select.gd` works them out from `UnlockedLevel` each time it opens.
- `_unused/Data/Dat.gd` is an unused alternate version that also saves the unlock arrays.

## Collision Layers

| # | Name | # | Name |
|---|---|---|---|
| 1 | Player | 7 | EnemiesBulletHARD |
| 2 | Enemy | 8 | EntityAnchor |
| 3 | PlayerBullet_Destrucable | 9 | PlayerHitBox |
| 4 | PlayerBullet_Destroyer | 10 | EnemyHitBox |
| 5 | EnemiesBulletDestructable | 13 | BulletSwarm |
| 6 | EnemyBullet_vulnerable | | |

## Audio Buses

`Master`, `Music`, `SFX` (UI) and `GameSFX`. Each has a volume slider in Settings.

## File Map

Files are grouped **by feature**. Each folder holds a feature's scene, script, sprites, sounds and shaders together.

```
core/          global.gd (autoload), entity.*, bullet.*   – base classes
game/          game.* (level base), spawner.*, formation.*, bullet_swarm.*, backgrounds/
levels/        level_0.tscn … level_5.tscn
player/        player.*, fire_jet.tres, sprites/
  weapons/     blaster/, laser/, minigun/, mega_beam/, shot_particle.tscn
enemies/       chicken/, chick/
  projectiles/ egg/, asteroid/, ufo_bullet/, small_laser/, mini_bullet/, blue_zig/
bosses/        boss_chicken/, ufo/, space_ship/, mother_hen/, henterprise/, henporer/
ui/            hud/, main_menu/, level_select/, level_end/, pause_menu/, settings/, credits/
  shared/      buttons/, icons/, fonts/, sfx/, star_surface/, window.png, space_sea.png
shared/        effects/ (explosion, beams, flares), audio/ (sfx used by several features), music/
save/          save_data.gd, save_node.tscn, data.save
_unused/       unreferenced old assets; Godot ignores this folder (.gdignore)
```

**Placement rules**
- A file used by one feature goes in that feature's folder.
- A file used by several features goes in `shared/`, or in `ui/shared/` for UI files.
- Reusable enemy bullets and hazards go in `enemies/projectiles/`, since spawners in any level can use them.
- The Spread Shot special has no files of its own. It fires `player/weapons/blaster/blaster.tscn`.

**Naming rules:** Use `snake_case` for every file and folder, with no spaces or parentheses. A scene and its script share a name (`ufo.tscn` + `ufo.gd`). Numbered variants use `_N` (`body_1.png`, `level_0.tscn`). Special icons include the special's ID (`special_1_shield.jpg`).

**Editor:** `.vscode/settings.json` hides `*.import`, `*.uid`, `.godot/` and `_unused/`. These files stay on disk and in git because Godot needs them.
