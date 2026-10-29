# 5. Known Issues & Tech Debt

These were found by reading the code. Fix them before building new content on top.

## Gameplay-affecting

None open.

> **Not a bug: boss beam damage.** `mother_beam`, `electro_beam` and `taper_beam` call `take_damage(damage)` every frame on purpose. The player becomes invincible while flickering after a hit, so a beam deals its `damage` once per flicker window (about 1 s), not once per frame.

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
