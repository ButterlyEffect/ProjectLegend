# ProjectLegend — Aesthetic Brief

**Author:** Nova (Art Director)
**For:** Simon
**Date:** 2026-04-19
**Status:** Living document — anchor for all visual + audio-visual decisions
**Aesthetic target:** *Mini elf + DNB future punk*

---

## 0. Why this brief exists

You're not classically trained in art, you're solo, and the codebase has surged ahead of the visuals — the elf is still a green ColorRect, the blade is grey, the BeetleSoldier is brown. That's fine for prototyping feel, but every week you don't anchor a visual direction the engineering decisions accrete around placeholder logic ("the blade is grey, just tint it on parry") instead of around a real aesthetic. This brief locks the direction so when you finally open Aseprite you're executing, not deciding.

The target — *mini elf + DNB future punk* — is unusual and that's the moat. Tiny, tactile, organic forest world (Minish Cap / Garden Story DNA) overlaid with neon, electricity, beat-driven energy (Katana Zero / Hyper Light Drifter / your DNB tracks). The visual job is to keep both halves legible at all times: the world must read as *small and alive*, the combat must read as *electric and synced to the bass*. Everything below serves that tension.

This is not a style guide for a studio. This is your personal compass. Be opinionated about every choice in here; reject anything that doesn't move both halves of the equation forward.

---

## 1. Palette candidates (Lospec-curated)

Six palettes below. Each is sized for a real production constraint (you can't paint with 64 colors as a solo dev — ramps will fragment). My strong recommendation is to anchor on a **20–30 color master palette** and let zones tint within it. The candidates progress from "safer / more achievable" to "boldest / hardest to execute well."

### 1.1 Forest-16 — *Natural forest baseline*

**Mood:** Grounded, earthy, naturalistic. The "before" world before the neon hits.
**Use case:** Default world tile palette. Foliage, bark, dirt, mushrooms.
**Hex:**
`#64988e #3d7085 #0f2c2e #345644 #6b7f5c #b0b17c #e1c584 #c89660 #ad5f52 #913636 #692f11 #89542f #796e63 #a17d5e #b4a18f #ecddba`

```
■ #0f2c2e  ■ #3d7085  ■ #64988e  ■ #345644  ■ #6b7f5c  ■ #b0b17c
■ #e1c584  ■ #c89660  ■ #ad5f52  ■ #913636  ■ #692f11  ■ #89542f
■ #796e63  ■ #a17d5e  ■ #b4a18f  ■ #ecddba
```

**Why it's a candidate:** 16 colors is solo-dev sustainable. It carries the Garden Story / Minish Cap forest baseline. It's also the *correct* foundation for "post-human miniature forest" because the colors all read as *organic matter*, not signage or screens. The neon palette will pop violently against this base, which is exactly what you want.
**Risk:** Without a partner palette layered on top, this looks generic. Don't ship this alone.
[Lospec page →](https://lospec.com/palette-list/forest-16)

### 1.2 Forest Glow — *Forest at dusk with bioluminescence*

**Mood:** Dark, mysterious, lit by amber. The forest at dusk where the magic lives.
**Use case:** Mid-game / interior zones. Cave systems, deep forest, "magic moments."
**Hex:**
`#00070d #0b162a #1f2c3d #26464b #5f6d43 #97933a #deca54`

```
■ #00070d  ■ #0b162a  ■ #1f2c3d  ■ #26464b
■ #5f6d43  ■ #97933a  ■ #deca54
```

**Why it's a candidate:** Only 7 colors — *brutally* solo-dev sustainable. The deep navy → forest green → amber gold ramp is the entire emotional engine of Hollow Knight's Greenpath in seven hex codes. Pair with the cyberpunk palette for combat and you get instant tonal contrast.
**Risk:** Too few colors for full character art. Use this as an environment overlay, not a master palette.
[Lospec page →](https://lospec.com/palette-list/forest-glow)

### 1.3 Cyberpunk Neons — *Neon synthwave for the future-punk overlay*

**Mood:** High-energy. Neon-lit. The DNB drop made visible.
**Use case:** Magic effects, parry flares, blade glows, enemy attack telegraphs, UI accents.
**Hex:**
`#53ebe4 #0f9595 #084f64 #03274c #08173d #0b001b #4d004f #c1115a #e13a6a #e46a87 #eca6c0`

```
■ #0b001b  ■ #08173d  ■ #03274c  ■ #084f64  ■ #0f9595  ■ #53ebe4
■ #4d004f  ■ #c1115a  ■ #e13a6a  ■ #e46a87  ■ #eca6c0
```

**Why it's a candidate:** This is the "punk" half of "future punk." Cyan + magenta against deep navy is the canonical synthwave combo, but the BNA-anime origin keeps it stylized rather than cliché. The cyan `#53ebe4` is the *exact* color your blade should glow on a perfect parry. Lock it.
**Risk:** Easy to overuse and crash into kitsch. Reserve for moments — never paint a tile with these.
[Lospec page →](https://lospec.com/palette-list/cyberpunk-neons)

### 1.4 CyberGum6 — *Pink-teal minimalist cyberpunk*

**Mood:** Lo-fi cyberpunk, almost wholesome. Where Garden Story and Katana Zero hold hands.
**Use case:** Whole-world palette if you want to commit to a single 6-color identity (Downwell-style).
**Hex:** `#3a2b3b #2d4a54 #0c7475 #bc4a9b #eb8d9c #ffd8ba`

```
■ #3a2b3b  ■ #2d4a54  ■ #0c7475  ■ #bc4a9b  ■ #eb8d9c  ■ #ffd8ba
```

**Why it's a candidate:** 6 colors is *radical* constraint and your single biggest force-multiplier as a non-artist. With six well-chosen ramps you can make consistent art faster than with any 32-color set. Peach `#ffd8ba` is a phenomenal elf skintone candidate.
**Risk:** Can read as "indie pixel art" rather than DNB future punk specifically. Mitigation: pair with aggressive bloom + a single accent color (cyan from 1.3) reserved for blade-only moments.
[Lospec page →](https://lospec.com/palette-list/cybergum6)

### 1.5 Synthwave 9 — *Sunset neon, narrative-mode*

**Mood:** Retro-future melancholy. The world after the humans left.
**Use case:** Cutscene / cinematic / sky / vista palette. Skyboxes, parallax horizons, boss arenas.
**Hex:** `#f6eddb #ec8d75 #bd4b64 #9e2281 #40265c #1b1e23 #244584 #50a9cf #96e6c2`

```
■ #1b1e23  ■ #40265c  ■ #244584  ■ #9e2281  ■ #bd4b64
■ #ec8d75  ■ #f6eddb  ■ #50a9cf  ■ #96e6c2
```

**Why it's a candidate:** Best emotional range of any palette here. The peach-coral → magenta → deep purple ramp is a sunset; the cyan + mint give you a "dawn" alternative. If a single zone needs to *feel* like the post-human nostalgia of the world (a ruined human kitchen at dusk, say), this is it.
**Risk:** Too painterly for tile work — use only for backgrounds + lighting passes.
[Lospec page →](https://lospec.com/palette-list/synthwave-9)

### 1.6 Resurrect 64 — *The "if you commit to a year of pixel art" option*

**Mood:** Cozy, broad, RPG-ready. The Hyper Light Drifter / Stardew superset.
**Use case:** Master palette if you go full pixel-art route long-term and want one source of truth.
**Hex (excerpt — 64 total):**
`#2e222f #3e3546 #625565 #966c6c #ab947a … #1ebc73 #91db69 … #4d9be6 #8fd3ff … #c32454 #f04f78 #fdcbb0`

**Why it's a candidate:** It's the de facto modern indie palette — hundreds of shipped games use it. Ramps are pre-organized. Translates the Forest-16 + Cyberpunk Neons combination into a single coherent, well-tested set with all the in-betweens you'll need for shading.
**Risk:** 64 colors is *too many* for your current skill stage. You'll waste hours micro-picking shades. Recommend only if you commit to pixel art as your primary craft for 6+ months.
[Lospec page →](https://lospec.com/palette-list/resurrect-64)

### 1.7 Nova's recommendation

**Anchor on CyberGum6 (1.4) for v0.3 prototype art**, with the cyan `#53ebe4` from Cyberpunk Neons (1.3) reserved as the blade/magic accent — a 7th color that *only* appears on the blade, on parry flares, on magic. This gives you:

- A 6-color world you can actually paint as a non-artist
- A single forbidden accent color that makes every magical moment instantly readable
- A natural upgrade path: when you're ready, expand into Resurrect 64 by mapping CyberGum6 colors onto its ramps

The Forest-16 + Forest Glow combo is the safer, more conservative path if you find CyberGum6 too pink. It will look more like Hollow Knight, less like Katana Zero.

---

## 2. Game reference screenshots — what to learn from each

I can't embed screenshots directly (research only returned URLs to galleries, not direct image URLs I'd trust). Below, each entry is a directed-research target: open the gallery, screenshot the specific aspect noted, drop into a `_bmad-output/art-direction/refs/` folder. This *is* part of the work — looking deliberately is half the artist's craft.

### Scale + silhouette (tiny character in big world)

1. **Hyper Light Drifter — wastes / village screenshots.** Teaches: how to make a small protagonist feel alive against vast geometric environments. Look at how the silhouette stays readable even when surrounded by detail. [Gallery](https://www.mobygames.com/game/78147/hyper-light-drifter/screenshots/)
2. **Garden Story — Concord (the tiny grape) in the Grove.** Teaches: cute-tiny is achieved through proportion, not detail. Concord is barely 16 pixels and still has emotional range. [Press kit](https://www.rosecitygames.com/garden-story-press)
3. **Mina the Hollower — Mina in environment shots.** Teaches: GBC-era constraints can produce a *more* expressive character than a higher-fidelity one. Watch how Yacht Club uses just 4 colors per sprite. [RPGFan gallery](https://www.rpgfan.com/gallery/mina-the-hollower-screenshots/)
4. **A Short Hike — Claire at viewpoints.** Teaches: tiny character + sweeping background = scale tension. Even though 3D, the principle is identical for your 2D framing.
5. **Tinykin — Milo in oversized human rooms.** Teaches: this is *literally* your premise. Every screenshot is a free reference for "human detritus reframed at tiny scale." [ArtStation environment work](https://www.artstation.com/artwork/BXV5Xl)

### Cyberpunk pixel (neon on grit)

6. **Katana Zero — neon city rooftop, club scene.** Teaches: how to use bloom + pure-saturation neon against muted backgrounds without losing pixel crispness. Note how the *backgrounds* are dim and the *foreground action* is electric. [ArtStation](https://www.artstation.com/artwork/qA5dKa) / [Steam wallpaper ref](https://steamcommunity.com/sharedfiles/filedetails/?id=2405240007)
7. **Huntdown — gang lair interiors.** Teaches: industrial/cyberpunk environments at 2x pixel density, with strong silhouettes. Useful for thinking about the "post-human" leftover-tech vibe.
8. **The Last Night — promo screenshots.** Teaches: how lighting (not detail) sells cyberpunk. Their entire aesthetic is silhouette + rim-light + neon. You can ape this with a Godot 2D rim shader.

### Companion design (wordless presence)

9. **Hollow Knight — the Knight in any frame.** Teaches: a wordless protagonist communicates through *posture and stillness*. Even in his idle frames he's saying something. Your blade needs this. [Spriters Resource](https://www.spriters-resource.com/pc_computer/hollowknight/)
10. **Ori and the Will of the Wisps — Ku flying alongside Ori.** Teaches: companion movement is animated *separately* from the player and uses a different rhythm. That asymmetry is what makes a companion feel alive vs. attached. [Concept art](https://www.creativeuncut.com/art_ori-and-the-will-of-the-wisps_a.html)
11. **Solar Ash — Rei traversal scenes.** Teaches: companion-as-scarf trail. The trail itself is character. Useful when you implement blade trail particles.
12. **Okami — Amaterasu's tail / brush.** Teaches: divine animal companion that's also the weapon. Direct reference for your blade's "alive but a tool" duality.

### Tiny world feel (miniature scale framing)

13. **Hollow Knight — Crystal Peak with crystal lighting.** Teaches: how *one* lighting effect (the cyan crystals) defines a whole zone. Pick one signature light per zone of your world.
14. **Pikmin 1/4 — first-day landscape with pikmin tiny against terrain.** Teaches: scale via familiar objects (a leaf is a roof, a bottle is a building). Direct reference for "human detritus reframed."
15. **Tunic — meadow / ruins screenshots.** Teaches: tiny character + isometric-ish framing + diorama-like environments. Note their use of a fixed camera distance to constantly remind you of scale.

### Shader / lighting transformation

16. **Dead Cells — castle interior with light shafts.** Teaches: 2D lighting can transform pixel art without ruining it if it's additive and soft. They use minimal shadows, mostly highlights + rim.
17. **Eastward — interior dialogue scenes with warm point lights.** Teaches: warm/cool lighting balance in pixel environments.
18. **Sea of Stars — night scenes with pre-rendered light layers.** Teaches: even traditional pixel art can have dynamic light passes if you bake them right.

### Animation economy (frame-budget references)

19. **Celeste — Madeline run + dash.** Teaches: 4-frame run cycles can feel *more* alive than 8-frame ones if the timing is sharp. ([Sprite-AI confirms 4-frame run](https://www.sprite-ai.art/blog/sprite-animation-frames))
20. **Shovel Knight — Shovel Knight walk.** Teaches: 6-frame walk for a slightly bigger sprite. Both Celeste and Shovel Knight are masters of "fewer frames, more punch."
21. **Katana Zero — death animations.** Teaches: a single freeze-frame + smear is more impactful than a smooth 12-frame death. Your parry slow-mo is literally this principle in motion.

### Audio-visual sync (rhythm games & beat-tied design)

22. **Sayonara Wild Hearts — chapter intros.** Teaches: every visual beat is locked to the music. The *visuals are choreography*. Your DNB tracks need this discipline applied to combat.
23. **Hi-Fi Rush — combat tied to BPM.** Teaches: enemies attack on beat, your hits land on beat. The *world* pulses on beat.
24. **Crypt of the NecroDancer — beat indicators.** Teaches: subtle on-screen beat indicators that don't break immersion.

### Beetle / insect enemy reference

25. **Tinykin (again) — bug factions.** Teaches: cyberpunked-up insects with personality. Different bug species = different visual cultures. Useful for v0.4+ when beetle variants land. [Destructoid feature](https://www.destructoid.com/tinykin-insect-factions-sweet-art-direction-if-you-dig-paper-mario-pikmin/)

**Action item:** open each gallery, save 2–3 reference images per game into `_bmad-output/art-direction/refs/<game>/`. This is your visual library. Update it whenever you find something better.

---

## 3. Character design — the elf

Currently: 14px-tall green ColorRect. Target: a tiny, distinctive silhouette that reads at thumbnail size and conveys *both* "elf" and "agile fighter" without devolving into fantasy cliché.

### 3.1 Pixel resolution

**Recommended: 16px tall (body, no hat) → 20px tall (with hat/hair).** This matches your 480×270 viewport perfectly:
- 480/16 = 30 horizontal "screens" of elf width — plenty of room for environments to feel large
- 20px is the upper bound before you start needing inner shading detail you don't have skill for yet
- Matches Garden Story's Concord and is one pixel smaller than Mina the Hollower

**Don't go bigger.** 32px sprites quadruple your animation work *and* reduce environmental scale tension. The elf should feel *small*.

### 3.2 Five thumbnail silhouette concepts

Draw these as 16x20 pure black-on-white shapes first. No detail, no color. The one that reads best is the one you build out.

1. **"Hood + ponytail"** — pointed hood pulled up, hair tied back exiting hood at the nape. Strong vertical silhouette. Reads as "rogue / scout." Cyberpunk-friendly hood seam.
2. **"Pointed cap + side bangs"** — classic elf cap (wizardy, slumped to one side), asymmetric bangs. More fairy than hacker. Reads at distance because of the cap.
3. **"Cropped jacket + antenna-tuft hair"** — short choppy hair with one upward tuft (read at distance as an antenna or aerial), oversized cropped jacket. Most "future punk" of the five. Risks reading as anime-generic.
4. **"Cloak + low silhouette"** — full cloak hides arms, only legs and a partial face show. Most mysterious. Hardest to animate (cloak physics). Skip unless you commit to cloth shaders.
5. **"Twin-tail + sash"** — twin pigtails, wrap-around sash that flutters on movement. Most movement-expressive (sash gives you a free secondary animation channel). Best for showcasing your DNB combat rhythm visually.

**Nova's pick: #1 (Hood + ponytail) for production, #5 (twin-tail + sash) as your stretch goal once core animation is working.** Hood + ponytail gives you the strongest read at 16px and a hood you can recolor for trust stages or zone shifts.

### 3.3 Hair / clothing / accessory candidates that read at tiny scale

At 16px, *every* feature must be one of these:
- **Silhouette-defining** (changes the outline shape): hood, cap, ponytail, sash, cape
- **Color-block** (a 2-3px patch of contrasting color): jacket, scarf, belt, glove
- **Accent pixel** (literally one pixel): earring, eye, gem on collar, antenna tip

Forget "details." A buckle is 1 pixel. A pocket doesn't exist. Either it changes the silhouette, blocks a color, or it's a single accent dot.

**Recommended kit for the elf:**
- Hood (silhouette) — peaked, asymmetric, slumped slightly to the dominant-hand side
- Cropped vest or sash (color block) — uses the accent neon color to tie her visually to the blade
- One ear tip visible (silhouette accent) — single pixel, ear breaks hood line, says "elf"
- Glove or gauntlet on blade-hand (color block) — 2px on the forearm, signals "this hand wields the blade"
- Eye (accent pixel) — one pixel, ideally cyan to echo the blade glow

### 3.4 Color blocks by body region (CyberGum6 + cyan accent map)

Mapping the recommended palette to body areas:

| Region | Color | Hex | Why |
|---|---|---|---|
| Skin | peach | `#ffd8ba` | Warm, reads as "small person" not "fantasy creature" |
| Hood / hair | dark plum | `#3a2b3b` | Dark frame around the face, defines silhouette |
| Vest / sash | magenta | `#bc4a9b` | The "punk" color, the brand color of the elf |
| Pants / boots | teal-grey | `#2d4a54` | Recedes, lets the magenta vest pop |
| Glove / gauntlet | teal-bright | `#0c7475` | Ties hand to blade visually |
| Eye + earring + accent | cyan-neon | `#53ebe4` | RESERVED — only this character + the blade get cyan |

This gives you **6 colors per character sprite max**, which is achievable as a non-artist.

### 3.5 Animation frame counts

Based on Celeste/Shovel Knight precedent and your 30fps render constraint:

| Animation | Frames | Loop time @ 30fps | Notes |
|---|---|---|---|
| Idle | 2-4 | 1.0s loop | Subtle bob, sash sway, eye blink every 3rd loop. Don't over-animate idle. |
| Run | 4 | 0.4s loop (10fps playback) | Two contact, two passing. Madeline-style. |
| Jump (rise) | 2 | hold | One liftoff frame, one peak frame |
| Fall | 1-2 | hold | One frame is fine; add hair-trailing variant if you want |
| Attack (blade swing) | 3 | 0.15s | Wind-up, swing, recovery. Smear frame on the swing. |
| Parry (window) | 2 | hold | Brace frame + glow frame. Slow-mo handles the rest visually. |
| Hurt | 1 | flash | Single recoil frame, flicker via shader |
| Death | 3 | 0.4s | Hit frame, knocked-back, lying. Or freeze-frame + particle dissolve if you want stylized. |
| Charge attack hold | 2-3 | pulse loop | Pulse with magic-charged glow, sync to in-game pulse rate |
| Slide | 2 | hold | Crouched-leaning frame + dust particle |

**Total animation frames for full elf set: ~25 frames.** Doable in a weekend once the base sprite is solid.

---

## 4. Blade companion design — wordless, alive, Amaterasu / Knight DNA

Currently: small grey ColorRect. Target: a sword-shaped object that conveys personality through motion + glow alone, never via face or animation-of-features. Three-to-four emotional states max.

### 4.1 "Personality through motion" rules

The blade has no face, no eyes, no mouth — and that's the whole point. Personality emerges from:

- **Hover behavior** — never perfectly still. 1px of bob with sine wave timing at ~1Hz when calm, ~3Hz when alert.
- **Orientation** — blade rotates subtly to "point" at things it cares about. Looks at the player when calm, at threats when alert, at the cursor when aiming.
- **Approach distance** — when held, blade hovers ~6px above player's shoulder when relaxed, drops to ~3px when player is in danger (closer = "I'm scared, stay near me").
- **Lag/lead** — when player moves, blade follows with 4–6 frames of lag in calm states (looks dragged-along, casual) and 1–2 frames of lag in combat (looks ready). Lead vs lag is *the* most important blade-personality control.
- **Tremor** — vibrate 1px on critical moments (perfect parry incoming, magic charged, taking damage). The tremor *is* the blade's voice.

These are all already-supported by your CompanionState architecture — you're not adding code, you're tuning numbers.

### 4.2 Idle hover behavior

State machine for idle:

| State | Hover Hz | Bob amplitude | Distance from player | Rotation |
|---|---|---|---|---|
| Calm | 1.0 Hz | 1px | 6px | drifts ±5° lazily |
| Alert | 2.5 Hz | 1px | 4px | snaps to nearest threat |
| Combat-ready | 3.5 Hz | 0px (locked) | 3px | locked perpendicular to attack-aim |
| Charging (player holding magic) | 6 Hz | 0px (vibrate) | 2px | pulses with charge |

These frequencies are deliberately mappable to your DNB BPMs (more on that in §8).

### 4.3 State-based color shifts

Reserve the `#53ebe4` cyan ONLY for the blade and its effects. Then layer state on top:

| State | Blade body | Glow halo | Trail |
|---|---|---|---|
| Default | `#9babb2` cool grey | none | none |
| Held / calm | `#9babb2` | soft `#53ebe4` 1px halo | none |
| Charging | `#9babb2` pulsing white | `#53ebe4` halo expanding/contracting on beat | none |
| Magic-ready | white-hot `#ffffff` | `#53ebe4` 2px halo, pulse | none |
| Parry success | `#ffd700` gold body 6 frames | `#ffffff` 3px flash flicker | brief radial particles |
| Imbued (tool) | tool color (e.g. thumbtack `#bc4a9b`) | matching halo | none |
| Thrown | `#ffffff` body | cyan trail (Line2D fade) | yes |
| Recall | `#53ebe4` body | thicker cyan trail | yes, longer |

Note: gold for parry is *intentionally outside the cyan palette*. Parry is the skill ceiling and deserves its own forbidden color. Magic = cyan, parry = gold, imbue = tool color. Three semantic colors, never overlap.

### 4.4 Trail / particle effects

Use Godot's `GPUParticles2D` for trails — performant, GPU-driven, fits your perf budget.

- **Throw trail:** 8–12 particles, cyan→transparent fade over 0.15s, 1px size
- **Recall trail:** 16–20 particles, brighter cyan, 0.25s fade — recall feels more "powerful" than throw
- **Parry burst:** one-shot ~24 gold particles radial, 0.3s lifetime, slight gravity
- **Magic-ready ambient:** 2–4 particles per second, cyan, slow upward drift, only when held + magic stocked

Resist the urge to add more. More particles = mush. The blade should feel *crisp*, not glittery.

### 4.5 Blade animation frame counts

| Animation | Frames | Notes |
|---|---|---|
| Idle hover | 2 | Just two body frames cycled, motion is positional not pixel |
| Throw spin | 4 | 90° rotations, can be done via Sprite2D rotation, no extra frames needed |
| Parry flash | 3 | Pre-flash, flash, post-flash; gold tint + glow |
| Charge pulse | 2 | Two-frame breathe loop, scaled in code |
| Imbue transformation | 4–6 | This is the moment to spend frames; the blade physically morphs into tool color |
| Hurt | 1 | One recoil frame (when player takes damage, blade reacts too) |

**Total blade frames: ~12–16.** A weekend's work.

---

## 5. Enemy direction — BeetleSoldier focus

Currently: brown rect with attack arm. The beetle is your first real enemy and the visual template for the entire Beetle faction in v0.3. Get this right.

### 5.1 Silhouette test

The beetle silhouette must read as *dangerous-but-cute small thing* at thumbnail. Key beats:
- **Wider than tall** — beetles are squat, ~16px wide x 12px tall
- **Carapace dome** — the top half is a hard shell curve; this is the visual hook
- **Visible mandibles** — 1–2 pixel forward-pointing mandibles that telegraph attack direction
- **Six legs implied** — animate just 4 (you can fake the back two), each 1px wide
- **Antennae** — 2px tall, twitch independently. *Antennae are personality.*

### 5.2 Cyberpunk + natural-forest tension on a beetle

This is the brief in microcosm. The beetle must read as both "forest creature" *and* "industrial threat." Approach:

- **Carapace base color:** dark organic (`#3a2b3b` or a forest brown) — the natural base
- **Thin neon accent line:** one row of pixels along the carapace edge in the cyberpunk magenta or cyan — like a fiber-optic seam, like the beetle has been *upgraded* by a tech remnant
- **Eyes:** glowing — single pixel, neon. This says "augmented, networked, hostile."
- **Underbelly:** lighter natural color (`#796e63`) — keeps the bottom organic-feeling

The result reads as: nature was here first, then humans left tech behind, and the beetles incorporated it. Perfect post-human worldbuilding via one enemy design.

### 5.3 Animation breakdowns

| State | Frames | Visual notes |
|---|---|---|
| PATROL (walk) | 4 | Leg cycle, 1px body bob, antennae sway |
| ALERT | 2 | Antennae snap up, eye-glow brightens, slight rear-up |
| APPROACH | 4 | Faster walk cycle, mandibles open |
| TELEGRAPH | 3 | Wind-up frames — body coiled back, mandibles wide, accent-line glow PULSE (this is the parry tell) |
| SWING | 2 | Lunge frame + hit frame, hard smear |
| COOLDOWN | 2 | Recoil + recover |
| HURT | 1 | Flash + 1px shake |
| DEATH | 3 | Flip onto back, leg-twitch frame, freeze |

**Critical:** the TELEGRAPH frames must visually scream "now is the parry window." The accent-line pulse is your signal — make it *the* visual cue. The whole combat language of the game depends on telegraphs being readable.

### 5.4 Beetle variants (v0.4+ thumbnails)

Three concepts to develop later:

1. **Beetle Scout** — smaller (12x10), faster, no carapace dome (more streamlined), cyan accent (vs. magenta for soldier). Role: rusher.
2. **Beetle Sapper** — same size as soldier but with a clearly-visible "battery pack" on its back (a found AAA battery). Magenta accent. Role: explodes on death.
3. **Beetle Knight** — bigger (24x18), thicker carapace, gold accent (royal — visually distinct from cyan/magenta which are player+enemy colors). Role: mini-boss before Beetle King.

Different accent colors give the player instant faction-internal hierarchy reading.

---

## 6. Environment direction — post-human miniature forest

Your viewport: 480×270. Your world: a forest where the human stuff is enormous because *you are tiny*. A discarded soda can is a tower. A leaf is a roof. A tape cassette is a building.

### 6.1 Tile size + grid

**Recommended: 16x16 tiles.** Math:
- 480 / 16 = 30 tiles wide
- 270 / 16 = ~17 tiles tall
- Elf = 1 tile tall, fits the world without dwarfing it

This matches your character resolution and standard pixel-art tooling (Aseprite, Godot's TileMap defaults). Don't go to 8x8 (too much micro-detail required) or 32x32 (loses the tiny scale).

### 6.2 Foreground / midground / background palette layering

Use atmospheric perspective via palette de-saturation, not via shader fog (cheaper, more pixel-art-correct):

| Layer | Saturation | Brightness shift | Palette section |
|---|---|---|---|
| Foreground (gameplay layer) | 100% | normal | Full CyberGum6 + cyan accent |
| Midground (parallax 1) | 70% | -10% | CyberGum6, no cyan accent |
| Background (parallax 2) | 40% | -20% | Only the dark + mid colors of CyberGum6 |
| Sky / horizon | 20% | dawn/dusk tint via Synthwave 9 ramp | Synthwave 9 palette only |

This is achievable in Godot by making 3 versions of every parallax tile (paint once at 100%, drop saturation in Aseprite for the others). Don't bake it into a shader — bake into the assets.

### 6.3 "Human detritus reframed at tiny scale" — concrete examples

A list of 20 props to seed the world. Each is one-line reframed:

- Soda can → fortress / tower
- Bottle cap → manhole cover / tile
- AAA battery → power core / boss arena pillar
- Cassette tape → temple wall
- Headphones (oversized) → archway
- Coin → platform
- Matchstick → bridge / plank
- Paper clip → grappling hook anchor / decoration
- Cigarette filter → bench / mushroom alternative
- Bottle cork → pedestal
- Computer chip → ancient rune-stone
- Earbud → waterfall vessel
- Plastic spoon → bridge
- Newspaper scrap → wallpaper / mural
- Pen cap → tower / light post
- Rubber band → tightrope / bouncepad
- Sewing pin (the thumbtack!) → already canonical
- Wristwatch face → clock-puzzle mechanism
- Soda tab → ladder rung
- Crumpled receipt → cliff face / climbable

Pick 5 for v0.3. Hold the rest for later zones.

### 6.4 Lighting moments per zone

One signature lighting effect per zone, like Hollow Knight does. For Golden Glade (your v0.3 zone):
- **Signature light:** golden afternoon shafts cutting through canopy, particles drifting in the light
- **Combat light:** cyan blade glow brightens local environment in combat
- **Boss light:** Beetle King arena lit from below by something glowing magenta — first time the player sees magenta dominate

Do not use more than 2 dynamic lights per scene. CanvasModulate + a single Light2D for the player-blade pair will get you 90% there.

---

## 7. Shader / VFX direction — Godot-native

Pixel art has a shader paradox: most modern post-processing *destroys* pixel art clarity. Use sparingly, intentionally, and always at integer pixel scale.

### 7.1 Bloom — when YES, when NO

**Yes:**
- On the cyan accent color (blade glow, magic, parry burst) — sells the neon
- On scene-specific light sources (golden shafts, crystal glows)

**No:**
- Global bloom — turns everything mushy, ruins crisp edges
- On the elf or normal scenery

**Implementation:** Don't use Godot's environment bloom (it's 3D-oriented and softens pixels). Instead, render the blade + magic effects to a separate Viewport, apply bloom only to that viewport, composite back. Gives you bloom on the *neon parts only*. The [Bloom post-processing for viewports shader](https://godotshaders.com/shader/bloom-post-processing-for-viewports/) is the reference implementation.

### 7.2 Chromatic aberration — almost always NO

Chromatic aberration on pixel art reads as visual noise. Pixels are too small for the channel offset to look intentional — it just looks like the screen is broken. ([Discussion of the problem.](https://godotshaders.com/shader/just-chromatic-aberration/))

**One exception:** apply briefly (0.1–0.2s) as a screen effect on:
- Damage taken
- Death
- Boss intro
- Magic charge release

Use a per-pixel implementation that respects pixel grid (the [GM Shaders Mini implementation](https://mini.gmshaders.com/p/gm-shaders-mini-chromatic-aberration) describes the right approach). Never leave it on continuously.

### 7.3 Scanlines / CRT — almost always NO

Scanlines compete with your pixel grid. At 480×270 already-low-res, adding scanlines = visual noise wars.

**One exception:** if you ever build a "save terminal / computer screen" UI element in-world, give *that* element a CRT shader (and only that element). Story 2.7's save terminal could be a perfect candidate. The [CRT Display shader](https://godotshaders.com/shader/crt-display-shader-pixel-mask-scanlines-glow-godot-4-4-1/) is purpose-built for this.

### 7.4 Particles (GPUParticles2D)

Already covered in §4.4 for blade. World-particle uses:
- Forest dust motes — 2px, drift slowly, light yellow, ambient
- Golden light-shaft motes — denser in light shafts, brighter
- Combat impact sparks — 4–8 particles per hit, white, fast burst, 0.1s
- Beetle death — 4 dark particles + 1 cyan/magenta particle (the augmentation dies free)

Budget rule: never more than 100 active particles on screen. Pixel art with too many particles = mush.

### 7.5 Outline / rim-light shader

**Strong recommendation: outline shader on enemies during PARRY-WINDOW telegraph frames only.**

Rather than always-on outlines (which make pixel art look like cel-shaded 3D), use the outline as a *mechanical* indicator: when an enemy's attack is parryable in the next 3 frames, the enemy gets a 1px white outline. This is communication, not style. The [3D Pixel art outline shader](https://godotshaders.com/shader/3d-pixel-art-outline-highlight-post-processing-shader/) has 2D variants — adapt.

### 7.6 Time-scale (already implemented)

Your slow-mo on parry is the single best shader-substitute you have. Lean on it. Add a slight desaturation pass during slow-mo (drop saturation to 60%) so the *unaffected colors fade* and the *blade gold + cyan pop harder*. This is one shader, one parameter, massive impact.

---

## 8. Audio-visual sync — your DNB tracks as game systems

Simon, this is the part that turns your game from "indie pixel platformer" to "thing nobody else is making." Your DNB tracks are the secret weapon. Don't let them be background music.

### 8.1 Lock combat tempo to BPM

DNB sits typically at 165–180 BPM. At 174 BPM, one beat = ~345ms = ~10 frames at 30fps or ~21 frames at 60Hz physics. Practical applications:

- **Beetle attack telegraph length** ≈ 1 beat (~10 frames at 30fps render). Currently your beetle telegraphs feel right because they're roughly that. *Lock them to BPM explicitly.*
- **Enemy attack cadence** = 2 beats (~20 frames between swings) for soldiers, 1 beat for scouts, 4 beats for knights.
- **Player parry window** stays at 5 frames (~83ms) — this is fine, it's not a beat-sync mechanic, it's a skill mechanic. But the *lead-up* to the parryable swing should land *on* a beat.
- **Charge attack pulse rate** = 2 beats per pulse (matches DNB's standard half-time feel).

### 8.2 Visual beat indicators (subtle, not Crypt of the NecroDancer)

You don't want to make a rhythm game. But subtle beat presence helps:
- **Blade hover frequency** is locked to 1/4 of the track BPM (every 4 beats, one hover cycle). When in combat, locks to 1/2 BPM.
- **Background ambient particles** drift slightly faster on the bass beat (very subtle, just an extra 1-pixel push every beat).
- **Save terminal / health UI** has a 1-pixel pulse on the bass beat. Tiny. Nobody consciously notices. Everybody feels it.

### 8.3 Tracks-as-zones

Each zone of the world gets one DNB track. Because tempos are similar across DNB, the *whole game* feels rhythmically continuous, but each zone has its own melodic personality. Specifics:

- Golden Glade: jungle/liquid DNB, ~170 BPM, warm pads
- Beetle King arena: harder neurofunk, ~174 BPM, aggressive bass
- Save terminals: lo-fi DNB or amen-break ambient, ~85 BPM (half-time), calming

### 8.4 Bass drop = encounter intro

When the player triggers a major encounter (boss, mini-boss, ambush), the music *drops* — and on that exact frame:
- Screen flashes once with the zone's accent color
- Brief chromatic-aberration burst (the one place it's right)
- Slow-mo for 6 frames as the camera frames the enemy
- Beetle (or boss) does its ALERT animation in-sync with the bass hit

This is one of the highest-leverage things you can build. It's also entirely audio-triggered (Godot's `AudioStreamPlayer` can fire signals), so it's mostly a tooling problem, not an art problem.

### 8.5 The radical version (stretch goal)

Make the BeetleSoldier's swing land ON the bass beat. The whole combat system becomes a dance. *This is the "one weird thing" that makes your game memorable.* Playtest it. If it works it's the brand.

---

## 9. Concrete next steps — prioritized checklist

Do these in order. Don't skip ahead.

1. **Buy Aseprite ($20).** Today. It's the only tool you need for a year. [aseprite.org](https://www.aseprite.org/)
2. **Create `game/art/` folder structure** in the project:
   ```
   game/art/
     palettes/
       cybergum6.gpl
       cybergum6_plus_cyan.gpl   ← your master
     characters/
       elf/
       blade/
     enemies/
       beetle_soldier/
     environment/
       golden_glade/
         tiles/
         props/
         parallax/
     vfx/
     ui/
   ```
3. **Pick ONE candidate palette.** My recommendation: CyberGum6 + cyan accent (§1.7). Make the call this week. Don't keep deliberating.
4. **Draw 5 thumbnail elf silhouettes** (§3.2) — pure black on white, 16x20, no detail. 30 minutes total. Pick the strongest.
5. **Color the chosen silhouette** using the §3.4 color block map. One day's work. Take your time, this is your protagonist.
6. **Animate idle (2-4 frames)** — see §3.5. Get it into Godot.
7. **Validate in-engine** — replace the green ColorRect, run the game, FEEL it. The look has to feel right *before* you spend more time on it.
8. **Iterate motion before detail.** If the elf doesn't feel right at idle + run, no amount of polish later will save her. Animate run before you animate hurt.
9. **Once elf works, do the blade.** It's smaller and easier — but the *motion programming* (§4.1, §4.2) is where the personality lives. Tune the lag/lead, the bob, the rotation. Numbers, not pixels.
10. **Re-skin the BeetleSoldier last.** It's an enemy, you have one of them, and you can use the §5 spec to do it in a single sitting once your elf+blade pipeline is established.

Stop after step 7 if the elf doesn't feel right. Iterate. The whole game's visual identity is anchored to her silhouette.

---

## 10. Open questions — Simon needs to answer

Lock these to lock the brief:

1. **Fairy or hacker?** Does the elf read as more "fairy of the woods" (pointed cap, soft features, dress) or more "tiny cyberpunk runaway" (hood, jacket, sash)? My recommendation is hacker-leaning (concept #1) but the world is *miniature forest*, so a fairy reading is equally defensible. **This decision changes everything downstream.**

2. **One palette commitment or multi-zone palettes?** Are you the kind of dev who picks ONE 6-color palette and ships the whole game in it (Downwell route), or do you want each zone to have its own palette variation (Hollow Knight route)? The first is sustainable solo; the second is more impressive but doubles art workload.

3. **How important is "wordless blade" vs. "expressive blade"?** Strict no-face / no-eyes / no-pixel-features means blade personality is 100% motion+color. Adding even one "eye" pixel changes the whole feel. (The Knight from Hollow Knight has eyes; Amaterasu has eyes; *most* wordless companions cheat with eye-glow.) Are you committed to true featureless or willing to add a single accent pixel?

4. **DNB beat-locking — gameplay-mandatory or aesthetic-only?** Are enemy attacks going to *actually* land on bass beats (a design constraint that shapes every encounter), or is the music just thematically tied? The first option is your strongest differentiator. The second is safer but less unique.

5. **Pixel art forever, or pixel art as v0.3 prototype only?** Confirming: are you committing to ship the final game in pixel art? Or is the pixel art a bridge to a higher-fidelity art pipeline (Spine, hand-painted) you'd swap to with a collaborator later? This affects whether you should sweat sprite quality now or treat them as throwaway prototypes.

Answer these five and you have a real visual direction document. Until then, this brief is a strong proposal — opinionated, but not yet a contract.

---

## Appendix A — Palette quick-comparison table

| Palette | Colors | Mood | Best use | Solo-dev sustainability |
|---|---|---|---|---|
| Forest-16 | 16 | Natural, earthy | World tiles | High |
| Forest Glow | 7 | Dark, golden, mysterious | Mid-game zones | Very High |
| Cyberpunk Neons | 11 | Neon, electric | Magic/effects only | High (used sparingly) |
| CyberGum6 | 6 | Lo-fi cyberpunk-cute | **Master palette (recommended)** | Maximum |
| Synthwave 9 | 9 | Sunset, melancholy | Skies/cinematics | High |
| Resurrect 64 | 64 | Cozy, broad | Long-term master | Low (too many colors) |

## Appendix B — Reference URLs for ongoing browsing

**Lospec palettes:**
- [Cyberpunk-tagged palettes](https://lospec.com/palette-list/tag/cyberpunk)
- [Forest-tagged palettes](https://lospec.com/palette-list/tag/forest)
- [Synthwave-tagged palettes](https://lospec.com/palette-list/tag/synthwave)
- [Lofi-tagged palettes](https://lospec.com/palette-list/tag/lofi)
- [Pastel-64](https://lospec.com/palette-list/pastel-64)
- [Pastel Horizon](https://lospec.com/palette-list/pastel-horizon)

**Pixel art tutorials:**
- [Sprite-AI on frame counts](https://www.sprite-ai.art/blog/sprite-animation-frames)
- [Sprite-AI on animation principles](https://www.sprite-ai.art/guides/animation-principles)
- [How to make a run cycle (Thomas Palef)](https://medium.com/@thomaspalef/how-to-make-a-run-cycle-in-pixel-art-e72fb9c0b812)
- [Aseprite docs](https://www.aseprite.org/docs/sprite-size/)
- [Best free Aseprite tutorials roundup](https://conceptartempire.com/aseprite-tutorials/)

**Godot shaders:**
- [Godot Shaders main site](https://godotshaders.com/)
- [Bloom for viewports](https://godotshaders.com/shader/bloom-post-processing-for-viewports/)
- [CRT shader](https://godotshaders.com/shader/crt-display-shader-pixel-mask-scanlines-glow-godot-4-4-1/)
- [Chromatic aberration (use sparingly)](https://godotshaders.com/shader/just-chromatic-aberration/)
- [Pixel art outline shader](https://godotshaders.com/shader/3d-pixel-art-outline-highlight-post-processing-shader/)

**Game galleries (for your refs/ folder):**
- [Hyper Light Drifter — MobyGames](https://www.mobygames.com/game/78147/hyper-light-drifter/screenshots/)
- [Hyper Light Drifter — Riot Pixels](https://en.riotpixels.com/games/hyper-light-drifter/screenshots/)
- [Mina the Hollower — RPGFan](https://www.rpgfan.com/gallery/mina-the-hollower-screenshots/)
- [Mina the Hollower — Yacht Club press kit](https://www.yachtclubgames.com/press/mina-the-hollower/)
- [Garden Story — Rose City press kit](https://www.rosecitygames.com/garden-story-press)
- [Hollow Knight — Spriters Resource](https://www.spriters-resource.com/pc_computer/hollowknight/)
- [Ori — concept art collection](https://www.creativeuncut.com/art_ori-and-the-will-of-the-wisps_a.html)
- [Tinykin — environment ArtStation](https://www.artstation.com/artwork/BXV5Xl)
- [Katana Zero — pixel art ArtStation](https://www.artstation.com/artwork/qA5dKa)
- [Best pixel art cyberpunk games (Game Rant)](https://gamerant.com/best-pixel-art-cyberpunk-games/)

---

*— Nova*
