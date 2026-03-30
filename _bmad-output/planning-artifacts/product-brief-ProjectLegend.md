---
title: "Product Brief: ProjectLegend"
status: "complete"
created: "2026-03-25"
updated: "2026-03-25"
inputs:
  - brainstorming-session-2026-03-25-01.md
---

# Product Brief: ProjectLegend

## Executive Summary

ProjectLegend is a 2D precision platformer where a tiny elf wields a living teleportation blade through a post-human miniature forest world. The blade isn't an item — it's a wordless companion with its own personality, fears, and arc. Every mechanic flows through this single relationship: throw the blade to teleport, parry with it in combat, solve spatial puzzles with its range, and grow together as the blade's capabilities expand zone by zone.

The game lives at the intersection of Celeste's precision platforming, Minish Cap's miniature-world charm, and Silksong's tight combat — unified by a central mechanic no one has attempted: a companion weapon that IS the traversal, combat, puzzle, and narrative system simultaneously. Built in Godot with GBA-era pixel art (Minish Cap characters, Yoshi's Island color vibrancy) and soundfont music, ProjectLegend is a solo passion project designed for iterative development, with a single polished world proving the vision before expanding to the full six-zone journey.

## Creative Vision

ProjectLegend exists to answer one question: **what does it feel like when combat, traversal, and puzzle-solving blur into a single flow state?**

The blade-throw teleport is the universal verb. Slide through a corridor, throw the blade at a wall, dash-teleport to it mid-air, parry an incoming attack, land on a thumbtack springboard, throw again, teleport above a boss, downward strike. When it clicks, the player stops thinking about individual actions and enters flow — dodge, parry, teleport, and improvise as one continuous motion.

This flow is wrapped in a miniature world where human artifacts are ancient ruins. A matchbox is a building. A penny is a religious altar. A fork is a "four-pointed crown of the giants." The player knows the truth the elf doesn't — constant dramatic irony woven into the world's texture. Attentive players discover new details on every playthrough; others simply experience a rich, living environment.

## The Blade Companion

The blade is a wordless character in the Pikachu tradition — you understand how it feels through movement, glow, vibration, and sound, never through words. Players interpret its emotional state, creating personal attachment through projection rather than exposition.

**Personality:** Think Usopp from One Piece — a coward who desperately wants to be brave. The blade's core fear is incompetence; it has never fought before, and enemies terrify it initially. Its core desire is to live out its legend — a purpose it senses but doesn't understand until the journey's end. It wants to prove to itself that it can be what it was meant to be.

**Early defiance is a prologue narrative beat**, not a recurring mechanic. Once the adventure begins in earnest, the blade is reliable. Its growing confidence is expressed through animation and feel, not through withholding function from the player.

**Trust Progression — Zone-Gated, Linear, Never Lost:**
Trust grows through shared experience across zones. It is not a player-managed mechanic — it's the narrative wrapper for progressive ability unlocking, like gaining new items in Zelda that open previously inaccessible areas.

| Stage | Zone | Blade Feel |
|-------|------|------------|
| Useless | Prologue | Can barely function, scripted defiance |
| Reluctant | Golden Glade | Slow throws, landing lag, short range |
| Willing | Understory | Faster throws, reduced lag |
| Partnered | Clearing | Confident movement, extended range |
| Trusted | Fungal Depths | Quick throws, blade leans into strikes |
| Bonded | Root Hollows | Near-instant response, anticipates input |
| Perfect Duo | Temple | Blade and elf move as one |

**Specific parameters that improve:** Throw speed, landing lag, teleport speed, teleport distance. These apply only to the blade — improvised tools have no input parameter progression.

**Pre-development deliverable:** A one-page blade character document defining its arc beats, emotional vocabulary (3-4 clear visual/audio states), and key moments per zone.

## Core Experience

**Scrolling World Design:** Not single-screen challenges — ProjectLegend uses scrolling, connected levels like Super Mario Bros or Metroid. Zones contain interconnected areas with hidden routes, branching paths, and side quest areas that become accessible as blade trust grows and new abilities unlock. Revisiting earlier zones with new capabilities reveals previously unreachable secrets.

**Precision Platforming:** Run, jump, slide (i-frames for evasion and repositioning — Megaman X model), wall slide, wall jump, blade throw, teleport. Teleportation is a dash-to-blade — the elf needs physical clearance at the destination, no phasing through matter. Momentum carries through teleports. Advanced techniques (slide cancel teleport, wall bounce teleport, catch cancel) emerge naturally for skilled players.

**Improvised Tools:** Human-scale objects become weapons at elf scale. A thumbtack is a spear, springboard, and wall anchor. A penny is a shield. Yarn is a tripwire. Each tool has combat, traversal, AND puzzle utility. Tools are temporary and breakable, found in the world and craftable at save points once the recipe is learned. Tools come in v1/v2/v3 tiers — stronger versions discovered in deeper zones. Without tools, the player can always fight with the blade alone (weakest approach), enabling minimalist challenge runs.

**Combat Identity:** Parrying is the skill ceiling. Perfect parries trigger slow-mo blade glow, chain into combo multipliers, and stock magic energy for the blade to unleash. Parry rewards combat power, not trust progression. Boss fights are comprehensive skill exams — arena scavenging under fire, tool destruction as phase transitions, bosses that use your placed tools against you or break them to force adaptation. Bosses follow set patterns (no adaptive AI) but interact dynamically with your tool placement.

## What Makes This Different

- **The companion IS the mechanic.** No platformer has unified companion, traversal, combat, and puzzle systems into a single entity with its own emotional arc.
- **Miniature world as mechanic, not just aesthetic.** Scale affects physics, tools, and level vocabulary. Every player already knows what a thumbtack is — instant readability, no tutorial needed.
- **Wordless emotional storytelling.** The blade communicates through gameplay feel, not dialogue. Minimal dialogue exists in the world (faction NPCs, environmental text) but the blade itself never speaks.
- **Controls that evolve with the story.** Four specific parameters (throw speed, landing lag, teleport speed, teleport distance) improve as trust grows — the game literally feels better to play as the relationship deepens.
- **GBA-era aesthetic in a modern vacuum.** Minish Cap character art meets Yoshi's Island color vibrancy, with GBA soundfont music. Not chiptune, not orchestral — a specific era nearly untouched in modern indie releases.
- **Tools as both power and philosophy.** Breakable improvised tools from a vanished civilization embody impermanence — the elf can't keep anything, everything is borrowed from a world that's gone. Thematic coherence between mechanics and world.

## Who This Is For

**Primary:** Players who loved Celeste's precision and emotional depth, Hollow Knight's atmosphere and combat mastery, and Minish Cap's charm — and want all three in one game. People who chase flow states in tight action games.

**Secondary:** The speedrunning and challenge community. Movement tech is designed for community discovery and expression. Streamable, clip-friendly, and inherently social. Minimalist blade-only runs provide an additional challenge layer.

## Iterative Development Approach

Playtesting happens at every milestone — not just the polished version.

**Milestone 0 — Movement Prototype (v0.1):**
Grey-box blade-throw teleport loop in Godot. Does the dash-to-blade feel right? Does momentum carry naturally? Does slide-cancel-teleport chain smoothly? Pure movement feel — no art, no enemies. Playtest with friends for basic feel.
*Gate: Does the core movement feel good enough to build on?*

**Milestone 1 — Combat Mechanics (v0.2):**
Add parrying, one improvised tool (thumbtack), and a basic enemy in grey-box. Test individual mechanics — does parrying feel satisfying? Does tool interaction work? Not yet testing for flow (needs world context). Playtest for mechanical feel and legibility.
*Gate: Do the individual pieces feel right?*

**Milestone 2 — One Complete World (v0.3):**
Golden Glade as scrolling connected world with branching paths, Beetle faction, tool set with crafting at save points, Beetle King boss, early blade companion personality, and initial art/music direction. This is the first real flow test — combat, traversal, and atmosphere together. Playtest for flow state and emotional response.
*Gate: Can a player enter flow? Does the world feel alive?*

**Milestone 3 — Vertical Slice Polish (v0.4):**
Polish Golden Glade to release quality. Blade emotional system fully realized, surface-material puzzle vocabulary, side quest paths, hidden routes, GBA pixel art and soundfont music. Broader external playtesting. This is the "do we have something here?" gate.
*Gate: Does combat flow + atmosphere = a game worth finishing?*

**Beyond v0.4:** Expand zone by zone — Understory, Clearing, Fungal Depths, Root Hollows, Temple — each building on proven foundations. Full companion arc, all five factions, the philosophical choice about human restoration.

**Pre-development deliverables (before Milestone 0):**
- Blade character document (personality, arc beats, emotional states)
- Teleport physics design spec (dash-to-blade rules, clearance requirements, edge cases)
- World bible (created after v0.1 proves movement feel — build the world around what works)

## The Full Vision

Six zones from sunlit Golden Glade to geometric Temple. Five living factions with opposing philosophies on humanity's return. A blade companion whose Usopp-like arc — from terrified coward to brave partner — resolves in a gut-punch choice: use your friend as a key to restore humanity, potentially losing its personality forever, or refuse destiny to keep your companion. The stoic elf's one visible moment of emotion.

A game where the core mechanic, the companion relationship, and the narrative climax are all the same thing.

## Constraints & Realities

- **Solo developer, free-time project.** Scope discipline is survival. Each milestone must be satisfying on its own.
- **First Godot project.** AI-assisted development is part of the strategy. Architecture should prioritize proven Godot patterns and keep systems as simple as possible. Teleport physics should use a dash model, not true physics simulation.
- **Art is the biggest production risk.** The GBA-era aesthetic target (Minish Cap + Yoshi's Island) historically required teams. Art production strategy is open — AI tools, asset stores, and potential collaborators will be explored as the project progresses. The blade's emotional vocabulary should be kept to 3-4 clear visual/audio states to stay within solo capacity.
- **Target platform:** Steam/PC. Local builds for testing throughout.

## Success Criteria

This is a creative endeavor first. Success is measured by feel, not revenue:

1. **The flow test:** Can a player enter combat flow — where dodge, parry, teleport, and tool use blur into one continuous motion?
2. **The atmosphere test:** Does the miniature world feel alive, enormous, and emotionally resonant?
3. **The companion test:** Does the player develop genuine attachment to a weapon that never speaks a word?
4. **The "we got something here" moment:** When combat flow and atmosphere come together in one polished world, does it feel like a game worth finishing?

If it also finds an audience and makes money — that's a wonderful bonus, not the goal.
