# 2. Content

All numbers come from the scripts and scenes as they are now. Bosses change behavior at **75% / 50% / 25% HP**, using the phase hooks in `core/entity.gd`.

## Player Kit

**Ship:** 100 HP. Hitbox is the ship body. Gets about 1 s of invulnerability after a hit.

### Weapons (2 equipped, swap with Tab)

| ID | Name | Cooldown | Damage | Behavior |
|---|---|---|---|---|
| 0 | Blaster | 0.5 s | 34 | Single shot straight up, accelerating (1000 px/s and up) |
| 1 | Laser | 2.0 s | 150 /s | Short beam attached to the ship. Also wears down destructible bullets |
| 2 | Minigun | 0.1 s | 12 | 1400 px/s, ±6° spread. 55-round magazine, regains 1 round per 0.4 s |

### Specials (1 equipped)

| ID | Name | Cooldown | I-frames | Behavior |
|---|---|---|---|---|
| 0 | Spread Shot | 8 s | 0.7 s | 5 Blaster shots in a 40° fan |
| 1 | Shield | 16 s | 4.0 s | Shield animation; full invulnerability |
| 2 | Mega Beam | 30 s | 4.5 s | Large beam, 300 dmg/s, deletes enemy bullets, screen shake |
| 3 | *(none)* | — | — | Default before anything is unlocked |

## Regular Enemies

| Enemy | HP | Behavior |
|---|---|---|
| **Chicken** | 100 | Drifts and bounces off the screen edges. Drops an egg every 3–8 s (random). Its eyes follow the player when the player is close. Bursts into feathers on death |
| **Chick** | 80 | Moves like a Chicken. **When killed** it implodes and releases a Blue Zig (homing shot), so killing one is risky |
| **Formation** | — | A group of N Chickens or Chicks in a **Circle, Square, Horizontal line or Vertical line**. The group moves as one unit and is gone once every member is dead |

## Projectiles & Hazards

| Projectile | Dmg | Notes |
|---|---|---|
| Egg | 10 | Falls straight down, 300 px/s |
| UFO bullet | 10 | Falls and accelerates |
| Mini bullet | 7 | Fast (1400 px/s), fired by the Space Ship |
| Blue Zig | 9 | Drifts, then dashes once at the player at 2.5× speed |
| Asteroid | 40 | Falls slowly at a random size and speed. Can be destroyed |
| Small laser | 20 /s | Vertical beam, short lifetime |
| Egg swarm | 10 each | A ring or grid of eggs that spins and travels as one group, then expires |

## Bosses

### Boss Chicken (Level 0, 2000 HP)
- **Base:** Bounces around the arena. Every 8 s it fires a stream of 10 aimed eggs.
- **≤75%:** Adds attacks that throw 2 spinning **egg rings** at the player.
- **≤50% / ≤25%:** Its sprite looks more damaged at each step.
- **≤25%:** Fires once: 4 **egg grids** in a cross pattern.

### UFO (Level 1 at 2500 HP; Level 5 at 3000 HP)
- **Base:** Drops accelerating UFO bullets.
- **≤75%:** A **vertical laser** strikes at the player's x position every 3.5 s, and the UFO speeds up.
- **≤50%:** Lasers every 3 s, faster attacks, damaged sprite.
- **≤25%:** Parks at top-center and switches to **radial spirals** (2 × 12 bullets). Lasers every 2.5 s.

### Space Ship (Level 2 at 3000 HP; also in Level 5)
- **Base:** Follows the player's x position along the top of the screen and fires spreads of mini bullets.
- **75% / 50% / 25%:** Starts a **ram phase**: it charges at the player 6, 8 or 10 times, entering each time from a random point on the screen border. Contact deals 40 damage. After each ram phase it fires faster (every 1.2 s, then 1.0 s, then 0.7 s).

### Mother Hen (Level 3, 4000 HP)
- **Base:** Wanders the screen and turns away from the edges. Its eye (the weak point) tracks the player. Fires **aimed fans** (8 shots × 2).
- **≤75%:** Switches to **Blue Zig rings** (5 homing shots).
- **≤50%:** Fires fans and Blue Zigs together.
- **≤25%:** Moves to the center, charges, then fires a **rotating giant beam** that reverses direction every 20 s. It keeps firing fans and Zigs during the beam.
- Shell pieces are separate destructible parts. When destroyed they break off and float away.

### The Henterprise (Level 4, 12000 HP, boss-only level)
- **Entry:** A battleship at the top of the screen. It fires a charged **Electro Beam** 5 s after appearing. Contact deals 30 damage.
- **Base:** Fires straight lasers from its gun ports. Every 2 s, UFO bullets rain from side zones.
- **At each 75% / 50% / 25% step:** It becomes invulnerable, retreats off screen, then flies back in from the **left / bottom-right / bottom**. Each pass fires a bigger Electro Beam (2× / 3× / 5× duration), and it then returns to the top.
- **Phase 1–2:** **Taper beams**, which show a warning strip before firing angled beams.
- **Phase 3:** Taper beams plus slow aimed **Sun Balls** (30 damage).

### The Henporer (Level 5, 7000 HP, final boss)
- **Base:** Every 10 s it throws an **Egg Flower** (a spinning ring of 10 eggs). A spawner on its head drops hazards.
- **≤75%:** Fires two Egg Flowers per attack, and the head spawner switches to lasers.
- **≤50%:** Starts **The Sky Descend**: a falling star that strikes the player's current position for 70 damage. Side spawners activate.
- **≤25%:** Fires Egg Flowers and Sky Descend together, twice per cycle.
- **Death:** One last Sky Descend.

## Levels

| Level | Wave sequence (summary) | Boss | Boss music |
|---|---|---|---|
| 0 | Chicken formations → asteroid shower → formations → pause | Boss Chicken | Be of Good Cheer |
| 1 | 16-chicken formation → laser rain → formation → pause | UFO | Magic Jinzo Straw |
| 2 | Vertical-line formations (Chickens + Chicks) → asteroid shower → lines → timed waves | Space Ship | Love-Colored Master Spark |
| 3 | Chick formations → UFO-bullet rains → more formations → pause | Mother Hen | Helian Alien |
| 4 | — (boss only) | The Henterprise | Necrofantasia |
| 5 | Gauntlet: formation → asteroid + laser shower → **UFO** → formation → timed waves → **Space Ship** → pause | The Henporer | Pure Furries |

The boss music starts when only the last wave before the boss and the boss itself are left (usually the pause wave). The background also stops scrolling at that point.
