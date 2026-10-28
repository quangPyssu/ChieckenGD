# 1. Game Overview

## Concept

This is a single-screen vertical shooter. The player ship moves freely around a 1920×1080 arena, the background scrolls downward, and enemies come in from the top. Each level is a fixed sequence of **waves**: chicken formations, hazard showers and short pauses, with a **boss** at the end. Most of the danger comes from bullets ("eggs", lasers, asteroids), so the game plays like a light bullet-hell.

## Controls

| Action | Keyboard / Mouse | Gamepad |
|---|---|---|
| Move | WASD / Arrow keys | D-pad |
| Slow move (precise dodging) | Ctrl / Space | A (button 0) |
| Fast move | Shift | X (button 2) |
| Fire weapon (hold) | Left mouse | RB (button 10) |
| Special attack | Right mouse | Right trigger |
| Swap primary/secondary weapon | Tab / Middle mouse | — |
| Pause | Esc | — |
| Toggle FPS counter | Ctrl+F | Start (button 6) |
| Quit immediately | Delete | — |

Movement speed is 500 px/s at base, 250 px/s when slowed and 750 px/s when fast. These values assume 60 FPS; see [Known Issues](5-known-issues.md).

## Core Loop

```
Main Menu ──Start──► current level ─┐
    │                               │
    └──Map──► Level Select ─────────┤
              (pick level + loadout)│
                                    ▼
                    Waves 1..N ► Boss ► End screen
                                           │
                    Win:  Next ► Level Select (after Level 5: Credits)
                    Lose: Retry / Quit to menu
```

- **Health:** 100 HP. It does not regenerate and resets at the start of each level. After a hit you get ~1 s of invulnerability, shown by the ship flickering.
- **Weapons:** You equip 2 weapons (primary and secondary) and swap between them during play. Each weapon has a cooldown, shown as a recharge bar.
- **Special:** One special attack with a long cooldown, shown on the SP bar. Using it also gives a few seconds of invulnerability.
- **Win / lose:** You win when every wave and the boss are cleared. You lose at 0 HP.

## Progression

Levels unlock one at a time. Clearing level *N* unlocks level *N+1* and one new item:

| Clear | Unlocks |
|---|---|
| Level 0 | Level 1 + **Spread Shot** (special) |
| Level 1 | Level 2 + **Laser** (weapon) |
| Level 2 | Level 3 + **Minigun** (weapon) |
| Level 3 | Level 4 + **Shield** (special) |
| Level 4 | Level 5 + **Mega Beam** (special) |
| Level 5 | Credits |

You start with only the **Blaster** and no special. Loadout is chosen on the Level Select ("Map") screen.

## Menus

- **Main Menu:** Start (loads the current level), Map (Level Select), Exit, and a settings widget (volume for Master/Music/SFX/GameSFX, fullscreen toggle, credits/info).
- **Level Select:** A galaxy map where each planet is a level, with a slide-up loadout panel and a slide-out "How to Play" panel.
- **Pause (Esc):** Resume or quit to the main menu.
- **End screen:** Win or lose header, with Next, Retry and Quit buttons.
