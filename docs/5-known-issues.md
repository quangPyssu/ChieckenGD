# 5. Known Issues & Tech Debt

These were found by reading the code. Fix them before building new content on top.

## Gameplay-affecting

| Issue | Where | Effect |
|---|---|---|
| **Frame-rate-dependent movement** | `core/entity.gd` `_set_velocity` | `velocity = direction * speed * delta` is set before `move_and_slide()`, which already accounts for delta. Speeds are tuned for 60 FPS, so at 144 FPS everything moves at about 40% speed |
| **Per-frame beam damage** | `mother_beam`, `electro_beam`, `taper_beam` | Damage is applied every frame with no `* delta`, so the damage depends on the frame rate. A beam at 50 per frame does 3000 dmg/s at 60 FPS |
| Special shows full but can't be used | `player/player.gd` | `SP` starts full, but `SpecialLoaded` waits for `SpecialTimer` to finish first |
| Possible repeated level-end calls | `game/game.gd` `_process` | `await` is called every frame while `LevelEnd` is true, so `$Paused` may be used after it has been freed |

## Save System

| Issue | Where |
|---|---|
| The save path `res://` is read-only in exported builds. It should be `user://` | `Global.save_game_path` |
| Equipped weapons are never restored, because the loop assigns to a copy (`for i in …: i = get_var()`) | `save/save_data.gd` `load_Data` |

## Code Structure

- The hard-coded path `/root/Game/Projectiles` appears 21 times across 12 scripts. A signal or a group lookup would remove this dependency.
- The level list is copied in 3 scripts (`game.gd`, `main_menu.gd`, `level_select.gd`).
- Magic child indices are used throughout (`get_child(2)`, the last child as `BulletSound`, and `$Marker.get_child(randi()%3)`).
- Boss attack sequences are chains of `await create_timer()` calls, so they cannot be cancelled cleanly when the boss dies or changes phase.

## Leftovers

- Debug keys are still active: **Numpad +/-** fires the Henterprise beam or kills the boss. **Delete** quits the game.
- `Global.Swap()` does nothing.
- Class names still follow the old naming (`entity`, `bullet`, `B_Anchor`), as do node names inside scenes. Only the files were renamed.
- `.uid` files created by the Godot 4.4+ upgrade are not committed yet (see `git status`).

## Resolved by the reorganization (2026-10-29)

- Scenes are out of the project root and grouped by feature, with snake_case names throughout.
- Editor `*.tmp` files and the duplicate `neuro.ttf` were deleted.
- Unused files (`static_entity`, `GameBorder`, `MotherShell.gd`, `Dat.gd`, spare sounds and icons) were moved to `_unused/`.
- Level files now use consistent case (`level_0` … `level_5`).
- Special icon names now match their IDs.
