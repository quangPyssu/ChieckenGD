# 6. Genre Reference

This doc compiles the core design of other games in Space Chicken's genre, one game at a time. For each it covers the core loop, health and lives, offense and power, defense, scoring, structure, and enemies and bullet patterns. Space Chicken's current rules come first, as a baseline. Research as of Oct 2026.

## Space Chicken today (baseline)

Space Chicken currently gives the player 100 HP per level, and bullets deal 7 to 70 damage each. Weapons are chosen before the level and unlocked by clearing levels. Full details are in [Content](2-content.md).

| Area | How it works now |
| --- | --- |
| Health | 100 HP, no regen, resets each level; ~1 s invulnerability after a hit |
| Lose condition | 0 HP ends the level (Retry / Quit) |
| Weapons | 2 equipped (Blaster, Laser, Minigun), swap with Tab; each has a cooldown bar |
| Specials | 1 equipped (Spread Shot, Shield, Mega Beam); long cooldown, gives i-frames |
| Power growth | None during a run; new weapons unlock per level cleared |
| Score | Not tracked |
| Drops | None |
| Precise dodging | Slow move (Ctrl / Space), 250 px/s |

### Enemies and bullet patterns (today)

- **Chicken (100 HP):** Drifts and bounces off screen edges. Drops a falling egg every 3–8 s.
- **Chick (80 HP):** Moves like a Chicken. On death it releases a Blue Zig, a shot that drifts and then dashes at the player.
- **Formations:** Chickens or Chicks in a circle, square, horizontal line or vertical line that move as one unit.
- **Hazards:** Asteroid showers (destructible), vertical laser rain, UFO-bullet rain from side spawners.
- **Boss patterns:** Aimed egg streams, spinning egg rings and grids, radial spirals, ram charges from the screen edge, aimed fans, homing Blue Zig rings, a rotating giant beam, telegraphed angled beams, and a falling star aimed at the player's position.

## Reference: Chicken Invaders

The loop: shoot chickens, dodge falling eggs, pick up drops, and build firepower until you run out of lives. Rules differ between games in the series.

### Core loop

1. Shoot chickens and dodge their bullets (eggs).
2. Lives are finite; every hit takes one life.
3. Score earns extra lives. The owner's notes say every 10,000 points. The fan wiki lists 1,000,000 / 3,000,000 / 10,000,000 by difficulty in later games.
4. Power grows from items dropped by enemies and bosses.
5. Gifts dropped by enemies swap the shot type.

### Health and lives

- One hit = one life. No HP bar.
- The game ends at zero lives and is otherwise endless.
- Dying also costs firepower (CI4: −3 power levels). Lose too much and later waves become very hard.
- An Extra Life bonus also pays 50,000 points.

### Offense: weapons, gifts, power

- **Weapon types (CI2 on):** Several primary weapons, each with a different shape. Examples: Ion Blaster (spread that gains bullets each level, up to 13), Neutron Gun (slow, concentrated, high damage), Laser Cannon, Vulcan Chaingun, Lightning Fryer, Plasma Rifle, Utensil Poker, Boron Railgun, Photon Swarm, Positron Stream.
- **Gifts:** Each gift represents one weapon. Picking one up switches to that weapon. A gift of the weapon you already hold powers it up instead. Gifts also give points (1,000 to 2,000 in Universe).
- **Power-ups:** Each raises the current weapon one level, to a maximum of 11 (a secret 12th in CI3/CI4). Power never wears off.
- **Damage types (Universe):** Weapons belong to groups such as Fire or Nuclear and deal more or less damage to certain enemy types.
- **Satellites (CI4):** Dockable side weapons (Microgun, Barbequer, Bird-Flu Gun, ICBM) that add damage.

### Defense and panic button

- **Missiles:** Killed chickens drop food (drumsticks, roasts). Enough food grants a missile that clears the screen. CI4 adds Mines as a second superweapon.
- **Overheat (CI3 on):** Holding fire builds heat. A full meter locks fire for a moment. Autofire heats faster than tapping, and the Universe starter heat sink overheats in about 8 s.
- Fewer bullets than a bullet hell, with readable falling eggs, so dodging is forgiving.

### Scoring and economy

- Points from kills, food, gifts and bonuses.
- **Skip bonus (CI2):** Clearing a wave without using missiles can award a new weapon or extra firepower.
- **Keys (CI4):** Dropped by golden-halo enemies and spent on unlockable content.

### Structure

- 10 waves per chapter (system), ending with a boss, then a warp to the next system.
- Difficulty rises each chapter: enemies and asteroids move faster.
- CI2: 11 chapters (110 waves), ending with the Mother-Hen Ship. CI3/CI4: 120 waves.
- Movement: CI1 is horizontal only. CI2 and later allow free movement, and CI4 rotates the ship and zooms the camera on some levels.
- Up to 4-player co-op (CI3).

### Enemies and bullet patterns

Pressure comes from numbers and movement more than from bullet density. Most enemy fire is slow and falls straight down.

- **Regular enemies (CI4 list):** Ordinary Chicken, Metal-suit Chicken (armored), UFO Chicken, Chickenaut (absorbs heavy damage), Chick, UFO Chick (fires a small spread of green lasers), Alien, Alien Container, Retro Invader, Space Burger Droid.
- **Hazards:** Falling eggs, feathers, bombs, supernova debris, bubbles, barriers. CI3 has asteroids and Egg Ships / Egg Drones.
- **Wave shapes:** Formations that march in rows, circle the screen, swoop in on paths, or rain down as asteroid showers.
- **Attack style:** Eggs dropped straight down at random intervals, small aimed or spread shots from tougher enemies, and enemies ramming the player.
- **Bosses (CI4):** Super-Chick, Giant Robotic Space Crabs, Mother-Hen Ship, Infini-Chick, Planetary Egg City, Alien Mothership, Apple Core, Iron Chef, Chicken Multiplicity, The Egg Cannon. CI3 ends with the Yolk-Star.
- A fake-boss wave (CI4's Chickenaut) sets up the first real boss.

## Reference: Touhou Project

The loop: clear stages of enemy waves, then outlast a boss whose attacks come in timed phases. You die in one hit, but the hitbox is tiny, and bombs are the lifeline.

### Core loop

1. Fly through a stage, shooting waves of enemies and picking up power and point items.
2. Fight a boss in phases. Each phase ends when its health bar empties or its timer runs out.
3. Survive dense bullet patterns by moving precisely in focus mode, and bomb when cornered.

### Health and lives

- One hit = one life. The hitbox is a few pixels, much smaller than the character sprite.
- **Extends:** In most games, extra lives come from point-item counts (100, 250, 500, 800, 1,100). EoSD uses score thresholds instead. From Subterranean Animism on, life pieces combine into a full life.
- **Death penalty:** About 16 power lost (early games), with 13 of it scattered as items you can collect again.

### Offense: shot and power

- **Character and shot type** are chosen at the start and fixed for the run. There are no weapon swaps.
- **Focus (hold Shift):** Slows movement and tightens or changes the shot. From PCB on, it also shows the hitbox.
- **Power items:** Small items add 1, big items add 10. The shot gets stronger at set steps (15, 31, 47, 71, 95, 127/128 in early games). At MAX, some games turn all bullets on screen into point items.

### Defense: bombs and deathbomb

- **Bombs:** About 3 per life (max 8). A bomb clears bullets, deals heavy damage, collects items and makes you invincible for a short time.
- **Deathbomb:** Bombing within a short window after a hit (about 0.1–0.9 s, by game and character) cancels the death.
- Bomb items add stock. From Subterranean Animism on, bomb pieces combine into a full bomb.

### Scoring

- **Point items** add score, and some games make them worth more the higher on screen you collect them.
- **Graze:** Bullets that pass through the sprite without touching the hitbox add score and a graze count.
- **Star items:** Appear when bullets are cancelled (bomb, spell card defeat, MAX power).
- **Spell card bonus:** Clearing a boss spell card without dying or bombing pays a bonus.
- **Rank (Mystic Square):** Bullets get faster and more numerous as rank rises.

### Structure

- 6 stages (5 in Story of Eastern Wonderland), each with a midboss and a boss.
- 4 difficulties: Easy, Normal, Hard, Lunatic.
- An **Extra stage** unlocks after a clear without continues. It has an especially long boss fight.
- Boss fights alternate regular attacks and named **spell cards**, each a set pattern of movement and fire.

### Unique systems by game

- **Perfect Cherry Blossom:** Cherry points, used for scoring and for a brief invulnerable border.
- **Imperishable Night:** Time points, which decide progression and whether the boss's final spells appear.
- **Mountain of Faith:** Faith points, which boost the value of point items.

### Enemies and bullet patterns

Touhou is pattern-first: regular enemies feed items and simple fire, while bosses carry dense, named patterns built to be read and learned.

- **Stage enemies:** Fairies of several sizes (small ones die fast, big ones take longer and fire more), spirits, fuzzballs and yin-yang orbs. They enter in scripted waves and leave if you don't kill them.
- **Midboss and boss:** Every stage has both. Boss fights alternate regular attacks (nonspells) and **spell cards**, each a named pattern with its own timer and health bar.
- **Bullet shapes:** Small pellets, rice and kunai, amulets, stars, large orbs, bubbles and lasers. Shape and size tell the player the hitbox and speed at a glance.
- **Common patterns:**
  - **Aimed streams:** Fired at the player's position. You "stream" them by moving slowly sideways.
  - **Rings and spirals:** Bullets in a circle around the boss, often rotating, with gaps to slip through.
  - **Random sprays:** Spread across the screen, read moment to moment.
  - **Walls and curtains:** Dense rows that leave a gap, or that close in from the sides.
  - **Lasers:** Shown first as a thin warning line, then turned on.
  - **Layered patterns:** A slow background pattern with fast aimed shots on top.
- Patterns are mostly fixed or aimed, so players can learn and route them.

## Reference: DoDonPachi

The loop: destroy enemies in quick succession to keep a combo chain alive, laser bosses down, and survive dense patterns with a tiny hitbox. Death costs power but raises your bomb capacity.

### Core loop

1. Kill enemies back to back to build a hit chain before its meter drains.
2. Switch between a wide Shot (clearing small enemies) and a focused Laser (bosses, big targets).
3. Bomb when cornered; chase hidden bees and chains for score.

### Health and lives

- One hit = one life. The hitbox is 6×7 px and narrows to 4×7 when moving sideways.
- **Extends:** At 6,000,000 and 20,000,000 points, plus a hidden 1UP in stages 1-3 and 2-3.
- **Death penalty:** The weapon you powered drops 1 level, and the other resets to level 1. In loop 2, both drop 1 level.
- Death also resets the bee value and the MAXIMUM multiplier.

### Offense: ships, shot, laser, power

- **Ship choice:** Type A (fast, narrow shot), B (medium, options follow your movement), C (slow, widest shot).
- **Style choice:** Shot Type boosts the spread shot. Laser Type boosts the laser, which pierces small enemies.
- **Shot (tap):** Rapid, wide, doesn't pierce.
- **Laser (hold):** Narrow, strongest damage, slows movement for fine dodging. Its aura deals extra damage up close.
- **Power-ups:** 4 pickups reach full power.

### Defense: bombs

- Start with 3 bombs. Maximum stock rises by 1 per death, up to 6.
- You're invincible while a bomb detonates.
- **Spread bomb** (while shooting): moderate damage, turns bullets into small stars.
- **Laser bomb** (while lasering): a large forward blast with much higher damage.

### Scoring

- **Hit chain:** Each kill adds to a chain while the meter is alive. Order matters: killing high-value enemies early scores more. Full-stage chains pass 100 hits.
- **Boss chain:** Lasering the boss builds hits that drop fast when you stop.
- **Hidden bees:** 13 per stage, revealed by lasering hidden spots, worth 100 up to 100,000 points. Collect all 13 and the next stage's bees start at double value.
- **MAXIMUM mode:** Collecting a bomb at full stock starts a per-frame bonus whose multiplier rises with each extra bomb collected.
- **Clear bonuses:** Stars collected in the stage, a No Miss bonus (200,000 to 8,000,000), and 10,000,000 per remaining life after the final stage.
- **Bullet cancel:** Some enemies cancel all bullets on screen when killed, and the cancelled bullets pay points.

### Structure

- Two loops of stages. Loop 2 unlocks after a one-credit clear plus one condition (2 or fewer deaths, a high hit chain, 50,000,000 points by 1-6, or all bees in four stages).
- Loop 2 has more aggressive enemies and leads to an EX boss and the true last boss, Hibachi.
- Console versions let you set extend thresholds and starting lives (1, 2 or 5).

### Enemies and bullet patterns

DoDonPachi fills the screen with many small, readable bullets. Every bullet has the same hitbox whatever it looks like, so players can trust the visuals.

- **Zako (popcorn):** Swarms of weak fighters that die in one or two hits. They exist to be chained.
- **Ground enemies:** Tanks, turrets and trucks that fire missiles (stages 1-6 and 2-6). Turrets often fire aimed bursts.
- **Large enemies:** Green carrier ships drop more stars the lower on screen you kill them, which rewards the risk of letting them come close.
- **Honeycomb guardians:** Killing the enemy on top makes turrets spawn endlessly, which is useful for keeping a chain alive.
- **Bullet-cancelling enemies:** Some enemies in stages 1-3 and 2-3 erase every bullet on screen when killed.
- **Bosses:**
  - **1-1 boss:** Turrets rotate around it, firing blue needle shots.
  - **Big Bee (final):** Orbs on its wings cancel bullets when destroyed.
  - **Hibachi (true last boss):** A tiny sprite that leaves the whole screen free for bullets. It's a pure dodging test.
- **Common patterns:** Fast aimed needle streams, wide spreads, rings, and walls of slow bullets with fast shots mixed in.
- **Loop 2:** Enemies fire far more bullets, more often.

## Reference: Raiden

The loop: shoot through a scrolling stage, grab colored power-ups to choose and grow your main weapon, collect medals for the stage bonus, and bomb when cornered. It's the closest classic match to the gift-swaps-weapon idea.

### Core loop

1. Shoot enemies; carriers drop power-up items.
2. The item's color picks the weapon: red = Vulcan (wide spread), blue = Laser (narrow, strong). Grabbing the other color switches weapon.
3. Collect medals and save bombs to raise the end-of-stage bonus.

### Health and lives

- One hit = one life.
- **Extends:** At 150,000 and 400,000 points, plus a hidden extend and 1UP items.
- **Death penalty:** Power drops back, and the medal counter resets to 0. Some versions restart from a checkpoint, others respawn on the spot.
- **Fairies:** Hidden in stages; they release power-ups after you die, helping you recover.

### Offense: main weapon, missiles

- **Main weapon:** Vulcan widens with each red item and is strongest up close. Laser does more damage at range in a narrow line.
- **Sub-weapon missiles:** M = Nuclear (heavy, forward), H = Homing (multi-direction, tracks enemies). Each letter powers them up.
- **P item:** Maxes out the main weapon and missiles at once.
- Extra items at full power turn into points (5,000 each; P = 10,000).

### Defense: bombs

- Bomb stock caps at 7. Bombs explode in a circle in front of the ship.
- They're slow to detonate and don't give full invincibility, so they're weaker than Touhou or DoDonPachi bombs.

### Scoring

- Medals are 500 points each during a stage.
- **Stage bonus:** 1,000 × bombs in stock × medals collected this stage. This rewards keeping bombs instead of using them.

### Structure

- 8 stages, looping forever. Each loop pays 1,000,000+ points, and enemy bullets get much faster each loop.
- **Rank:** Rises when using Laser and Nuclear missiles and falls with Vulcan and Homing, so stronger weapon choices make the game harder.

### Enemies and bullet patterns

Raiden uses few bullets, but they're fast and aimed, so the danger is speed and surprise rather than density. This style is often called a "traditional" or "speed" shooter.

- **Ground enemies:** Tanks, turrets and boats that drive in from the screen edges and fire single fast shots aimed at the player.
- **Air enemies:** Small fighters in quick formations, plus large bombers and gunships that take many hits and fire spreads.
- **Item carriers:** Weak enemies that drop power-ups when destroyed.
- **Bosses:** Large tanks, battleships and spider walkers. They fire aimed spreads and rings, often with several turrets that can be destroyed one at a time.
- **Common patterns:** Single aimed shots from off-screen or just-arriving enemies, aimed fans, and slow rings from bosses.
- **Speed rises with loops and rank:** Bullets get much faster on higher loops, and stronger weapon choices raise the rank.

## Reference: Gradius

The loop: collect capsules to move a highlight along a power meter, then spend it on the upgrade you want. Building your ship is a choice, not a random drop.

### Core loop

1. Shoot enemies (often a full formation) to make them drop power capsules.
2. Each capsule moves the highlight one slot along the meter at the bottom of the screen.
3. Press the power-up button to buy the highlighted upgrade, or keep collecting to reach a later slot.

### Health and lives

- One hit = one life. Hitting walls and terrain also kills.
- **Death penalty:** Usually all upgrades are lost and you restart from a checkpoint. Recovering a fully powered ship mid-stage is very hard, so one death can snowball.
- The North American arcade version spawns orange enemies after a death that drop extra capsules, to help you recover.

### Offense: the power meter

- **Slots (commonly):** Speed Up → Missile → Double → Laser → Option → ? (shield). The source confirms Laser and Option.
- **Options:** Glowing drones that follow your path and copy your shot. Up to 4 in the arcade (2 on Famicom).
- Cheap upgrades sit early on the meter and strong ones late, so you trade waiting for power.

### Defense

- No bomb. The ? slot gives a shield that absorbs a few hits from the front.
- Speed Up is itself defensive: more speed means better dodging.

### Structure

- Side-scrolling stages with themed terrain (volcanoes, Moai heads), each ending in a boss.
- **Core bosses:** Shoot through small walls to hit a blue core that turns red as it nears destruction. Some regenerate their walls.

### Enemies and bullet patterns

In Gradius the stage itself is the enemy. Terrain, enemy formations and stage hazards threaten you more than bullet patterns do.

- **Formation fighters:** Small ships that fly in waves along curving paths. Destroying a whole wave drops a power capsule.
- **Ground enemies:** Walkers and turrets on floors and ceilings that fire aimed shots. Hatches open and release streams of small enemies.
- **Stage hazards:** Volcanoes spray falling rocks. Moai heads fire rings of small bubble shots. Walls and narrow passages kill on contact.
- **Bosses:** The core-ship boss fires straight lasers in fixed lanes. You dodge by finding the gap between the beams, then shoot through the shield walls to reach the core.
- **Common patterns:** Single aimed shots, rings (Moai), falling debris and fixed lane lasers. Patterns stay sparse, because the terrain already limits where you can move.

## Reference: Ikaruga

The loop: flip your ship between black and white to absorb same-color bullets and deal double damage to the opposite color. Defense and offense are the same button, and there are no power-ups.

### Core loop

1. Switch polarity at any time to match the incoming bullets and absorb them.
2. Switch to the opposite color of an enemy to deal 2× damage.
3. Spend absorbed energy on homing lasers, and kill enemies in color groups of 3 for chains.

### Health and lives

- A bullet of the opposite color kills in one hit; bullets of your own color are harmless.
- Same-color enemies release energy when they die. Switching polarity at the wrong moment while it's on screen can kill you.

### Offense

- **No power-ups.** The standard shot never changes.
- **Homing laser:** Every 10 absorbed bullets stores one laser, up to 12. Each is 10× a standard shot.
- Polarity is the damage multiplier: opposite color = 2×.

### Defense

- Absorbing is the defense, so there's no bomb. Dense same-color patterns are safe if you're in the right color.

### Scoring

- **Chain:** Kill 3 enemies of the same color in a row. The bonus starts at 100 and doubles each chain, up to 25,600. Killing out of order breaks it.

### Structure

- 5 stages, 3 difficulties, 1–2 players.
- Extra modes: practice, challenge leaderboards, and Bullet Eater, which you clear without firing a single shot.

### Enemies and bullet patterns

Every Ikaruga enemy and bullet is black or white, so each pattern is really a question: which color should you be right now?

- **Waves by color:** Enemies arrive in groups of one color, often in threes, which sets up the chain system.
- **Mixed waves:** Black and white enemies together, so you have to switch color mid-wave or dodge the bullets you can't absorb.
- **Same-color revenge:** Enemies of your own color release a burst of energy when they die. It's harmless while you stay that color, but deadly if you switch.
- **Terrain:** Walls, moving blocks and narrow passages in some stages.
- **Bosses:** Large ships that alternate one-color barrages (safe to absorb, and a way to fill lasers) with two-color patterns you must dodge. Each boss has a time limit.
- **Common patterns:** Dense streams and curtains of one color (meant to be absorbed), aimed shots of the opposite color, and interleaved two-color spirals that force you to read the color, not just the shape.

## Reference: Galaga

The loop: clear a formation of aliens that fly in and dive at you, from a ship that only moves left and right. Galaga is the ancestor of the chicken-formation wave, and its one power-up is a risk you choose to take.

### Core loop

1. Aliens fly in from the top and sides and settle into a formation.
2. They break off to dive at the player while firing. Destroy the whole formation to clear the stage.
3. Optionally let a Boss Galaga capture your ship, then rescue it for double firepower.

### Health and lives

- One hit from a shot or a collision costs a life.
- Extra lives come from score thresholds (set by arcade switches).

### Offense: the capture risk

- **Tractor beam:** Boss Galaga (2 hits to kill) can capture your ship, which costs a life.
- **Rescue:** Shoot that Boss while it dives and the ship returns. The two join as a **dual fighter**: double shots, but a hitbox twice as wide.
- Kill the Boss while it's still in formation and the captured ship turns against you.

### Scoring

- Enemies are worth more when shot mid-dive than in formation.
- **Challenging stages:** Stage 3 and every 4th stage after it. Aliens fly a set pattern without firing; shooting them all pays a bonus.

### Structure

- Endless stages. Enemies get more aggressive, fire more and dive faster as you go.
- Some enemies transform into new types with different attack patterns.

### Enemies and attack patterns

In Galaga the enemies themselves are the bullets. Most of the danger is aliens diving into you, with a few shots fired along the way.

- **Bee-type and butterfly-type aliens:** The rank and file of the formation. They enter in snaking lines, settle into place, then peel off to dive.
- **Boss Galaga:** Sits at the top of the formation and takes 2 hits. It dives with escorts, or hovers and fires a tractor beam to capture your ship.
- **Transforming enemies:** Some aliens split into a new type with a different dive pattern.
- **Dive attacks:** Aliens swoop down in loops and arcs toward the player's position, then return to formation or fly off the bottom and wrap back to the top.
- **Enemy fire:** A few shots dropped during dives, roughly aimed at the player. Fire grows heavier and dives get faster as stages go on.
- **Challenging stages:** Aliens fly set patterns and don't shoot. It's a pure aiming test.

## Bullet pattern glossary

Most patterns in the genre are built from three kinds of aim: **fixed** (the same every time), **aimed** (at the player's current position) and **random**. Aimed patterns force you to move, while fixed ones can be learned. The shapes below are combinations of those.

| Pattern | What it is | How the player beats it | Used in |
| --- | --- | --- | --- |
| Falling drop | Single shots that fall straight down | Step aside | Chicken Invaders, Space Chicken (eggs) |
| Aimed shot | One fast shot at the player's position | Keep moving; don't stop in place | Raiden, Gradius, DoDonPachi, Galaga |
| Aimed stream | A line of aimed shots in a row | Move slowly sideways ("streaming") | Touhou, DoDonPachi, Space Chicken (Boss Chicken eggs) |
| Fan / spread | Several shots in an arc | Slip between two shots, or go wide | All, Space Chicken (Mother Hen, Space Ship) |
| Ring | Bullets in a full circle around the shooter | Find the gap, or get close where gaps are widest | Touhou, Gradius (Moai), Raiden, Space Chicken |
| Spiral | A ring that rotates as it fires | Circle with the rotation | Touhou, DoDonPachi, Space Chicken (UFO) |
| Wall / curtain | Dense rows with a gap | Read early, move into the gap | Touhou, DoDonPachi, Ikaruga |
| Random spray | Bullets spread in a rough direction | Read and react as it comes | Touhou, Space Chicken (UFO-bullet rain) |
| Homing shot | Bullets that track or dash at the player | Bait it, then sidestep late | Space Chicken (Blue Zig) |
| Telegraphed laser | A warning line, then a beam | Leave the line before it fires | Touhou, Gradius, Space Chicken (Henterprise) |
| Rotating beam | A long beam sweeping around the shooter | Circle ahead of the sweep | Space Chicken (Mother Hen) |
| Position strike | An attack aimed at where you are, landing after a delay | Move after the warning | Space Chicken (Sky Descend, UFO laser) |
| Ram / dive | The enemy itself charges at the player | Dodge the body, punish on return | Galaga, Chicken Invaders, Space Chicken (Space Ship) |
| Layered | A slow pattern with a fast aimed pattern on top | Dodge the fast layer, drift through the slow one | Touhou, DoDonPachi |
| Two-color | Interleaved patterns of two colors | Switch to absorb one color, dodge the other | Ikaruga |
| Death burst | Bullets released when an enemy dies | Don't kill it close up, or be ready to dodge | Ikaruga, Space Chicken (Chick) |

**Design rules seen across these games**

1. Every dense pattern leaves a readable safe path, such as a gap, a rotation to follow or a color to absorb.
2. A bullet's size and shape tell the player its hitbox and speed. DoDonPachi keeps one hitbox size for all bullets so the visuals stay honest.
3. Lasers and strikes are telegraphed before they hit.
4. Patterns get denser or faster with difficulty, loops or rank, not with new rules.

## Comparison

Every reference uses one-hit lives. They differ in how power grows, what softens a death, and what earns lives back.

| Mechanic | Space Chicken (today) | Chicken Invaders | Touhou | DoDonPachi | Raiden | Gradius | Ikaruga | Galaga |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Health | 100 HP per level | 1 hit = 1 life | 1 hit, tiny hitbox | 1 hit, 6×7 px hitbox | 1 hit | 1 hit, terrain kills | Opposite-color hit only | 1 hit or capture |
| Extra lives | — | Score thresholds | Point items / life pieces | 6M, 20M, hidden 1UP | 150K, 400K, 1UP items | — | — | Score thresholds |
| Power growth | Unlocks between levels | Power-ups, 11 levels | Power items, 0–128 | 4 power-ups | Colored items + M/H missiles | Meter you spend | None | Dual fighter by rescue |
| Weapon type | Loadout, Tab swap | Gift swaps type | Fixed per character | Fixed per ship | Item color swaps type | Chosen on meter | Fixed | Fixed |
| Precision mode | Slow move | — | Focus | Laser slows ship | — | Speed Up choice | — | — |
| Death penalty | Level restart at 0 HP | Lose power (CI4: −3) | −16 power, recoverable | Main −1, other to 1 | Power + medals reset | All upgrades, checkpoint | — | Lose dual fighter |
| Panic button | Specials on cooldown | Food → missile | Bombs, deathbomb | Bombs, cap 3→6 | Bombs, cap 7 | ? shield | Absorb by color | — |
| Fire limit | Per-weapon cooldown | Overheat (CI3 on) | None | None | None | None | Laser needs absorbed energy | 2 shots on screen |
| Risk reward | — | Skip-missile bonus | Graze, item height | Hit chain, bees | Bomb × medal bonus | Wait for better slot | Color chains | Capture for dual fighter |
| Structure | 6 levels, waves + boss | 10 waves + boss, endless | 6 stages + Extra | 2 loops | 8 stages, endless loops | Stages + core bosses | 5 stages | Endless, challenge stages |

**Patterns most share**

1. Death is one hit, but the hitbox is small, so bullets look more dangerous than they are.
2. A panic button (bomb, missile, shield or absorb) trades a resource or skill for survival.
3. Power builds during a run, and death takes back part or all of it. The harsher the loss, the more the game offers a way to recover (fairies, scattered power, orange capsule enemies).
4. Extra lives reward playing well, so good players last longer.
5. A risk-for-reward system (graze, chains, capture, skipping missiles) pays players who play close to danger.
6. Weapon choice is either mid-run by pickup (Chicken Invaders, Raiden, Gradius) or fixed at the start (Touhou, DoDonPachi, Ikaruga).

## Gaps to verify

- [ ] Chicken Invaders: starting lives, food needed per missile, and power lost on death in each game.
- [ ] Chicken Invaders: the 10,000-point extra-life step (owner's notes) vs the wiki's 1M+ thresholds. Which game uses which?
- [ ] Touhou: starting lives and bombs per game, and the point-of-collection line (item auto-collect).
- [ ] DoDonPachi: rank system, if any, and continue rules.
- [ ] Gradius: full power meter slots, extends and checkpoints per version.
- [ ] Galaga: exact extend thresholds and per-enemy points.
- [ ] Enemy and pattern descriptions for Touhou, Raiden, Gradius, Ikaruga and Galaga are mostly from general genre knowledge, not checked against a source.

## Sources

Most reference numbers come from fan wikis and guides, and they vary between games in each series.

- [Chicken Invaders – Wikipedia](https://en.wikipedia.org/wiki/Chicken_Invaders)
- [Bonuses – Chicken Invaders Wiki](https://chickeninvaders.fandom.com/wiki/Bonuses)
- [Chicken Invaders Wiki – Ion Blaster](https://chickeninvaders.fandom.com/wiki/Ion_Blaster)
- [Chicken Invaders Wiki – Ultimate Omelette waves](https://chickeninvaders.fandom.com/wiki/Chicken_Invaders:_Ultimate_Omelette/Waves)
- [Chicken Invaders Wiki – The Yolk-Star](https://chickeninvaders.fandom.com/wiki/The_Yolk-Star%E2%84%A2)
- [StrategyWiki – CI4 Bonuses and Weapons](https://strategywiki.org/wiki/Chicken_Invaders_4:_Ultimate_Omelette/Bonuses_and_Weapons)
- [StrategyWiki – CI4 Enemies](https://strategywiki.org/wiki/Chicken_Invaders_4:_Ultimate_Omelette/Enemies)
- [Steam guide: Chicken Invaders 4](https://steamcommunity.com/sharedfiles/filedetails/?id=2435069993)
- [TV Tropes – YMMV / Chicken Invaders](https://tvtropes.org/pmwiki/pmwiki.php/YMMV/ChickenInvaders)
- [Touhou Project – Wikipedia](https://en.wikipedia.org/wiki/Touhou_Project)
- [Embodiment of Scarlet Devil – Wikipedia](https://en.wikipedia.org/wiki/Embodiment_of_Scarlet_Devil)
- [Touhou Wiki – Imperishable Night gameplay](https://touhou.fandom.com/wiki/Imperishable_Night/Gameplay)
- [Touhou Wiki – Mystic Square gameplay](https://touhou.fandom.com/wiki/Mystic_Square:_Gameplay)
- [DoDonPachi – Wikipedia](https://en.wikipedia.org/wiki/DoDonPachi)
- [DoDonPachi – shmups.wiki](https://shmups.wiki/library/DoDonPachi)
- [DoDonPachi DaiOuJou – shmups.wiki](https://shmups.wiki/library/DoDonPachi_3)
- [Raiden – shmups.wiki](https://shmups.wiki/library/Raiden)
- [Gradius – Wikipedia](https://en.wikipedia.org/wiki/Gradius_(video_game))
- [Ikaruga – Wikipedia](https://en.wikipedia.org/wiki/Ikaruga)
- [Galaga – Wikipedia](https://en.wikipedia.org/wiki/Galaga)
- [Warning Forever / danmaku archetypes – First Person Scholar](https://www.firstpersonscholar.com/tag/danmaku/)
- [Bullet hell tips – itch.io jam forum](https://itch.io/jam/bullet-hell-v/topic/3751351/bullet-hell-tips)
- Space Chicken: [Game Overview](1-game-overview.md), [Content](2-content.md)
