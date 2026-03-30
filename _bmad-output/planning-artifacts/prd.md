---
stepsCompleted: ['step-01-init', 'step-02-discovery', 'step-02b-vision', 'step-02c-executive-summary', 'step-03-success', 'step-04-journeys', 'step-05-domain-skipped', 'step-06-innovation', 'step-07-project-type', 'step-08-scoping', 'step-09-functional', 'step-10-nonfunctional', 'step-11-polish', 'step-12-complete']
inputDocuments:
  - product-brief-ProjectLegend.md
  - product-brief-ProjectLegend-distillate.md
  - brainstorming-session-2026-03-25-01.md
documentCounts:
  briefs: 1
  research: 0
  brainstorming: 1
  projectDocs: 0
  distillate: 1
workflowType: 'prd'
classification:
  projectType: 'Game (2D precision platformer)'
  domain: 'Gaming / Interactive Entertainment'
  designComplexity: 'Medium'
  executionComplexity: 'High'
  projectContext: 'Greenfield'
  notes: 'Creative-first passion project. PRD requirements framed as player experience targets, not feature checklists. Creative vision takes priority over completeness.'
---

# Product Requirements Document - ProjectLegend

**Author:** Simon
**Date:** 2026-03-25

## Executive Summary

ProjectLegend is set in a post-human miniature forest where elves built civilization in the margins of human ruins. A matchbox is a building. A penny is a religious altar. A fork is a "four-pointed crown of the giants." The elves don't know what these objects were — but the player does. This dramatic irony creates a world of charm, humor, and quiet heartbreak where every environment tells a story the protagonist can't read.

Through this world, a tiny elf carries a living teleportation blade — a wordless companion in the tradition of Amaterasu or the Knight from Hollow Knight. The blade starts terrified of combat, desperate to prove itself worthy of a destiny it doesn't yet understand. It communicates through movement, glow, and vibration. Other characters in the world speak, but the blade never does — its personality is expressed entirely through how it feels in your hands. As trust grows zone by zone, four blade parameters improve (throw speed, landing lag, teleport speed, teleport distance), making the game literally feel better to play as the relationship deepens.

The core mechanic — throw the blade, dash-teleport to it — unifies traversal, combat, puzzles, and the companion arc into a single verb. The creative goal is the moment where these systems intersect and the player stops thinking: dodge flows into parry flows into teleport flows into improvised tool strike. Players scavenge breakable human-relic tools (thumbtacks, yarn, pennies) that serve as weapons, traversal aids, and puzzle solvers — temporary and impermanent, like everything borrowed from a vanished civilization. The blade alone always works, enabling minimalist challenge runs.

Scope is shaped by a deliberate constraint: one developer, iterative milestones, every system earned through prototyping. Prove the movement feel first, then combat mechanics, then one complete world (Golden Glade) that validates flow and atmosphere together. Target platform is Steam/PC.

### What Makes This Special

- **The companion IS the mechanic.** The blade is simultaneously the traversal system, combat weapon, puzzle tool, and emotional heart of the narrative. No game has unified these into a single entity with its own wordless arc.
- **Controls evolve with the story.** Progressive blade parameter improvements mean the game's responsiveness is the trust relationship made tangible — a design technique almost no one attempts.
- **Wordless emotional storytelling through feel.** The blade's coward-to-brave arc is told entirely through animation states and input response. Every moment of gameplay is storytelling. The world speaks through NPCs; the blade speaks through how it plays.

## Project Classification

- **Project Type:** Game (2D precision platformer)
- **Domain:** Gaming / Interactive Entertainment
- **Design Complexity:** Medium — proven genre foundations, clear reference points (Celeste, Minish Cap, Silksong)
- **Execution Complexity:** High — solo developer, first Godot project, novel teleport physics, wordless companion emotion system
- **Project Context:** Greenfield, creative-first passion project
- **Visual References:** Minish Cap (character/world art), Yoshi's Island (color vibrancy), GBA soundfont music
- **Development Approach:** Iterative, playtesting at every milestone

## Success Criteria

### Player Success

- **The Flow Test:** Players engage in continuous, uninterrupted play — they don't pause between actions, they chain moves unprompted (slide → throw → teleport → parry → strike), and they experiment with combos on their own without being told. Observable signal: when a playtest ends, they're upset there isn't more.
- **The Companion Test:** Players develop genuine attachment to the blade without it ever speaking. Observable signal: players talk about the blade as "he" or "she," react visibly when the blade shows fear or pride, and notice when blade behavior changes between zones.
- **The Atmosphere Test:** The miniature world feels alive and enormous around the player. Observable signal: players stop to look at environmental details, comment on the dramatic irony of human objects, and describe the world to others unprompted.

### Creative Success

- **The "We Got Something Here" Moment:** When combat flow and atmosphere come together in one polished world (Golden Glade), an external playtester's response makes it clear this is a game worth finishing. This is the primary creative gate.
- **Move Chaining as Design Validation:** Players independently discover and execute multi-move chains (slide-cancel-teleport, wall-bounce-teleport sequences). This confirms the movement system is expressive enough to sustain the full vision.
- **Blade Readability:** Playtesters can identify at least 3 of the blade's emotional states without being told what they mean. The wordless communication is working.

### Business Success

- Revenue and audience are not development drivers. If the game finds players and makes money, that's a welcome bonus.
- The only business-adjacent goal: release one polished world on Steam that represents the creative vision faithfully.

### Technical Success

- Blade-throw teleport (dash-to-blade with clearance check) feels responsive and predictable — no edge cases where the player teleports somewhere unexpected.
- Momentum preservation through teleports feels natural — players intuitively understand that speed carries through.
- Stable 30fps gameplay on mid-range PC hardware (art target is GBA-era pixel art, so performance ceiling should be achievable).
- Save system works reliably — crafting recipes, zone progress, and blade trust stage persist correctly.

### Measurable Outcomes

| Signal | How to Measure | Target |
|--------|---------------|--------|
| Continuous play | Playtest session length without voluntary stops | 20+ minutes uninterrupted |
| Move chaining | Unprompted multi-move combos observed | 3+ move chains within first hour |
| Blade attachment | Playtester refers to blade with personality | Majority of testers |
| World immersion | Unsolicited comments about environment details | At least 1 per playtest |
| "Want more" reaction | Playtester asks when next world is coming | Majority of testers |

## Product Scope

**MVP:** One complete Golden Glade world that proves flow-state combat and atmospheric immersion. **Growth:** Worlds 2-3 (Understory, Clearing) expanding proven foundations. **Vision:** All six worlds with full narrative arc. See [Project Scoping & Phased Development](#project-scoping--phased-development) for detailed breakdown.

## User Journeys

### Journey 1: First-Time Player — "The Blade Finds Its Elf"

**Meet Kai.** He just downloaded ProjectLegend because a clip of someone chaining a slide-teleport-parry combo blew up on TikTok. He's played Celeste and Hollow Knight, he loves tight platformers, but he's never seen anything like the blade-throw mechanic.

**Opening Scene:** Kai starts in the prologue. The blade is defiant, barely functional — scripted moments where it refuses to cooperate. He's confused but intrigued. The world around him is breathtaking — golden light through enormous grass blades, dew drops like crystal balls. He stops moving just to look. Then he notices a rusted thimble that someone has turned into a house. He laughs. He gets it.

**Rising Action:** The blade reluctantly starts working. Kai's first real throw is clumsy — slow, short range, noticeable landing lag. He dies a few times figuring out the dash-to-blade mechanic. But then he slides under a mushroom cap, throws the blade at a far wall, teleports, and lands on a platform he couldn't reach before. Something clicks. He finds a thumbtack, stabs an enemy with it, then pins it to the ground and uses it as a springboard. He didn't know he could do that. He tries it again on purpose.

**Climax:** Midway through Golden Glade, Kai enters a room with two enemies and a gap he can't jump. Without thinking, he slides past the first enemy, throws the blade at the wall across the gap, parries the second enemy's attack mid-slide, teleports across, and lands running. He didn't plan it. It just happened. He's in flow. The blade glows warm — it's proud of him. He notices.

**Resolution:** Kai beats the Beetle King after a dozen attempts. Each attempt felt different because tool spawns varied and the boss broke his strategies. When it's over, he's upset there isn't more. He messages a friend: "You NEED to play this. The sword is alive and it's scared of everything." He's already thinking about the hidden paths he couldn't reach.

**Requirements Revealed:** Onboarding through scripted blade defiance, forgiving early level design, escalating room complexity, instant respawn, environmental storytelling that rewards pausing, blade emotional feedback visible during gameplay.

---

### Journey 2: Mastery Player — "The Perfect Chain"

**Meet Rena.** She's 40 hours in. She's beaten Golden Glade, explored every route her current blade range allows, and she knows every Beetle King attack pattern by heart. She watches her own clips back looking for faster lines.

**Opening Scene:** Rena loads into a room she's cleared before. But this time the blade is at Willing trust stage — faster throws, less lag. The room feels different. A ledge she used to need a thumbtack springboard to reach? She can teleport directly now. A new route opens.

**Rising Action:** She starts experimenting. Slide-cancel into throw, teleport at the apex, catch-cancel the blade mid-air without teleporting (faking out the trajectory), re-throw at a new angle, teleport through a gap she used to go around. She chains 5 moves without touching the ground. The blade is vibrating with excitement — it hums in rhythm with her chains, glowing brighter with each successive move. It's *thrilling* at being pushed this hard. She didn't learn any of this from a tutorial. She discovered it by pushing the system.

**Climax:** She finds a hidden room behind a wall she couldn't reach at Reluctant trust range. Inside: a v2 thumbtack recipe. She heads to the nearest save point — the familiar glow, the crafting interface showing her discovered recipes, the zone progress map marking rooms she's found and paths she's opened. She crafts the v2 thumbtack. It launches higher. She immediately realizes she can reach a platform she's been staring at since hour one. The world is reshaping around her growth.

**Resolution:** Rena records a 47-second speedrun of a level that took her 8 minutes on first play. She posts it. Someone in the comments points out a line she missed using a wall-bounce-teleport she didn't know existed. She goes back. The game is still teaching her.

**Requirements Revealed:** Movement tech that emerges from system interactions (not hand-designed), blade emotional response to mastery play (excitement during chains), tool tiers that recontextualize existing spaces, blade range increases opening new routes in old areas, save point crafting with recipe management and discovery tracking, replay value through skill expression.

---

### Journey 3: Explorer — "The Archaeologist"

**Meet Dex.** He plays slowly. He reads every environmental detail. He's the kind of player who found every Korok in Breath of the Wild. He's here for the world, not the speedrun.

**Opening Scene:** Dex enters Golden Glade and immediately notices the penny altar where beetles are bowing. He knows it's a penny. They think it's sacred. He spends two minutes just looking at the scene, reading the NPC dialogue about "the great copper disc fallen from the sky." He's charmed and a little sad.

**Rising Action:** Dex finds a fork embedded in the ground like Excalibur. A beetle elder calls it "the four-pointed crown of the giants, too heavy for any living creature to lift." Dex laughs out loud. He starts cataloguing what the elves have misidentified — a light bulb is a "dead sun," a wristwatch is a "cursed wheel." He screenshots everything. He finds a branching path behind a vine wall, follows it to a hidden Beetle side quest about recovering a "sacred relic" (a button). He completes it. The beetle gives him a yarn recipe.

**Climax:** Deep in a side path, Dex finds a cracked photograph — faded, half-buried, incomprehensible to the elf but crystal clear to the player. It's a family photo. The humans were real. The elves built religion around their garbage. The humor turns bittersweet. The blade dims slightly — it senses something old and heavy here. Dex sits with that feeling.

**Resolution:** Dex has played twice as long as Rena but cleared half the levels. He doesn't care. He tells friends about the world, not the mechanics. He's already planning a second playthrough to find the details he missed. When new zones release, he's first in line — not for new combat, but for new archaeological layers.

**Requirements Revealed:** Environmental storytelling density (multiple human artifact interactions per level), NPC dialogue system for faction characters, branching hidden paths discoverable through observation, blade emotional response to environmental context, side quest system tied to faction interaction, collectible/discoverable lore elements.

---

### Journey 4: Challenge Runner — "Blade and Nothing Else"

**Meet Vex.** She's beaten the game. Now she wants to prove she can beat it with just the blade — no tools, no crafting, pure sword combat. The weakest possible approach, by design.

**Opening Scene:** Vex starts a new run. She passes the first thumbtack and doesn't pick it up. The game doesn't stop her. There's no popup saying "you need this." The blade is all she has. First enemy encounter: without a thumbtack springboard, she has to parry perfectly to create openings. Every hit takes longer. She's grinning.

**Rising Action:** Rooms that were puzzles with tools become pure execution challenges without them. A gap that was trivial with yarn-as-grapple now requires a precise slide-cancel-teleport chain. A combat encounter designed around tool scavenging becomes a parry gauntlet. The blade's magic stocking from parries becomes her only power source. She notices something subtle: the blade feels *different* on this run. It stands taller in idle. Its glow is steadier. It knows it's being trusted as enough on its own — and it's rising to it.

**Climax:** The Beetle King fight without tools. No thumbtack springboards, no penny shields, no yarn tripwires. Just blade, parry, and teleport. The boss's scripted tool interactions gracefully adapt — attack patterns that would target placed tools redirect into positional attacks, creating different but fair openings. She has to fill those windows with raw skill. It takes her thirty attempts. The winning run is 90 seconds of unbroken flow — the purest expression of the core mechanic loop.

**Resolution:** Vex records the run. It looks like a completely different game from Dex's exploration playthrough. Both are valid. Both were designed for. She starts thinking about a no-damage run next.

**Requirements Revealed:** Game must be completable without tools (blade-only always viable), all combat encounters must function without tools present (graceful degradation — tool interactions enhance but never gate), blade emotional response to blade-only play (recognition of trust), parry system deep enough to sustain tool-less combat, level design must have blade-only solutions alongside tool-assisted ones.

---

### Journey 5: The Return — "The Blade Remembers"

**Meet Kai again.** It's been three weeks. Life got busy — work, friends, the usual. He hasn't opened ProjectLegend since beating the Beetle King. He almost forgot where he was.

**Opening Scene:** Kai launches the game. His save loads at the last save point. The blade does something he hasn't seen before — a quick excited wiggle, a warm pulse of light. It noticed he's back. No menu popup, no "previously on" recap. Just his companion saying hello in the only language it knows.

**Rising Action:** The save point shows his zone progress — rooms cleared, paths discovered, recipes found. He orients quickly. He remembers he was trying to reach a hidden ledge. He throws the blade — the muscle memory is still there, but slightly rusty. The blade is patient. Within two minutes he's flowing again.

**Resolution:** The gap between sessions dissolved because the return felt personal, not mechanical. The blade's greeting turned "I should play this" into actually playing.

**Requirements Revealed:** Save point as orientation hub (zone map, discovered rooms, recipe list), blade emotional response to session return, persistent player state across sessions, gentle re-engagement through companion warmth rather than UI recaps.

---

### Journey Requirements Summary

| Capability | Revealed By | Priority |
|-----------|-------------|----------|
| Blade-throw teleport with momentum (dash-to-blade) | All journeys | MVP Core |
| Parry system with magic energy stocking | Kai, Rena, Vex | MVP Core |
| Blade emotional feedback (3-4 visual/audio states) | All journeys | MVP Core |
| Blade responds to playstyle (mastery chains, blade-only trust, return) | Rena, Vex, Kai return | MVP Core |
| Instant respawn on death | Kai, Vex | MVP Core |
| Scrolling connected levels with branching paths | All journeys | MVP Core |
| Environmental storytelling (human artifact interactions) | Kai, Dex | MVP Core |
| NPC dialogue system (faction characters) | Dex | MVP Core |
| Tool system (find, use, break) | Kai, Rena | MVP Core |
| All combat encounters function without tools (graceful degradation) | Vex | MVP Core |
| Crafting at save points with recipe discovery | Rena, Dex | MVP Core |
| Save point as orientation hub (zone map, progress, recipes) | Rena, Kai return | MVP Core |
| Persistent discovery state (rooms, recipes, paths) | Rena, Kai return | MVP Core |
| Boss fights with tool interaction/destruction | Kai, Vex | MVP Core |
| Blade-only viability (no tool hard gates) | Vex | MVP Core |
| Hidden routes gated by blade range | Rena, Dex | MVP Core |
| Side quest system tied to factions | Dex | MVP |
| Tool tiers (v2/v3 in later zones) | Rena | Growth |
| Blade response to session return | Kai return | Growth |
| Advanced movement tech (emergent from systems) | Rena | MVP (emerges from core) |
| Replay value through multiple valid playstyles | All journeys | MVP (structural) |

## Innovation & Novel Patterns

### Detected Innovation Areas

**1. Unified Companion-Mechanic System**
The blade is simultaneously traversal tool, combat weapon, puzzle solver, and emotional narrative vehicle. Games typically separate these into distinct systems — a companion character here, a movement ability there, a weapon somewhere else. ProjectLegend collapses them into a single entity. The closest precedent is Ori's Sein (companion + ranged attack), but Sein doesn't carry an emotional arc or evolve mechanically.

**2. Responsive Controls as Narrative Device**
Four specific input parameters (throw speed, landing lag, teleport speed, teleport distance) improve as the story progresses. The game literally feels better to play as the blade trusts you more. Most games use cutscenes or dialogue to convey relationship growth. ProjectLegend uses input responsiveness — the most intimate layer of the player-game interface.

**3. Genre Intersection**
Celeste-style precision platforming + Hollow Knight-style atmosphere and combat mastery + Zelda-style progressive world unlocking + improvised tool crafting — unified through a single verb (blade-throw teleport). Each genre's audience recognizes familiar DNA, but the combination is unexplored.

**4. Graceful Degradation as Design Philosophy**
Every system is optional except the blade. Tools enhance but never gate. Combat encounters function with or without tools. This creates emergent difficulty scaling — the same content serves casual players (with tools) and challenge runners (blade-only) without separate difficulty modes.

### Validation Approach

Each innovation is validated through the iterative milestone structure:

| Innovation | Validated At | How |
|-----------|-------------|-----|
| Blade-throw teleport feel | v0.1 | Does the dash-to-blade momentum feel right in grey-box? |
| Combat flow (parry + tool + teleport) | v0.2 | Do individual mechanics feel satisfying? |
| Unified companion-mechanic experience | v0.3 | Does the blade's personality come through during real gameplay in Golden Glade? |
| Controls-as-narrative | v0.3+ | When blade trust increases between zones, do players notice the game feeling better? |
| Graceful degradation | v0.3 | Can playtesters complete Golden Glade blade-only? Is it fun, not frustrating? |

### Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| Blade companion feels like a UI element, not a character | Pre-dev character document defining 3-4 clear emotional states. Early playtest for blade readability at v0.2. |
| Controls-as-narrative is too subtle for players to notice | Exaggerate the parameter differences between trust stages. Players should feel the jump, not need to be told. |
| Genre combination creates identity confusion ("what kind of game IS this?") | Lead marketing with one 30-second GIF of a flow-state chain. The blade-throw teleport is the hook — everything else follows. |
| Blade-only runs are frustrating rather than rewarding | Boss encounters must have clear blade-only paths. Graceful degradation tested explicitly at every milestone. |

## Game-Specific Requirements

### Platform & Input

- **Target platform:** Steam/PC
- **Input:** Controller-first design. Keyboard support as secondary. All mechanics designed around controller input mapping (analog stick, face buttons, triggers/bumpers for blade throw and parry).
- **Frame rate:** 30fps target — deliberate stylistic choice matching GBA-era snappy keyframe animation. Two-frame attacks, held poses, impact freezeframes, smear frames. Every frame is a statement.

### Camera & World Rendering

- **Camera:** Tight follow, player always centered. No lookahead, no room transitions — continuous scrolling world.
- **Parallax:** Layered parallax backgrounds (soft watercolor gradients behind crisp pixel foregrounds) to sell depth and scale in the miniature world.
- **Scale communication:** Environmental particles (pollen, spores, dust motes at boulder-size), grass sway on player pass, flowers tracking movement — all reinforcing miniature scale.

### Core Systems Architecture

- **Blade system:** Central game object managing throw trajectory, dash-teleport execution, clearance checking, momentum preservation, trust stage parameters, and emotional state. This is the most critical system — everything depends on it.
- **Tool system:** Inventory of breakable items with find/use/break lifecycle. Crafting interface at save points. Recipe discovery persistence. Tool tier data (v1/v2/v3).
- **Combat system:** Parry detection with frame-precise timing, slow-mo trigger, magic energy stocking, combo multiplier tracking. Boss encounter framework supporting tool interaction/destruction and graceful degradation when no tools present.
- **Save system:** Persistent state for zone progress, discovered rooms, unlocked recipes, blade trust stage, crafted tool inventory. Save point as orientation hub (zone map, progress visualization).
- **NPC dialogue system:** Simple dialogue framework for faction NPCs and environmental text. Minimal but functional.

### Audio Architecture

- **Music:** GBA soundfont instrument set. Zone themes with combat layering (percussion/tempo intensifies, layers peel back after combat). Blade leitmotif.
- **Sound design:** Scale-aware — world sounds massive (leaf falls = hang glider whoosh), elf sounds small and precise. Blade audio evolves with trust stage (thin metallic ring → fuller resonance → harmonic trail).

### Implementation Considerations

- **Godot engine (first project):** Prioritize built-in Godot patterns over custom solutions. Use Godot's physics for basic collision/movement, implement blade teleport as custom dash logic on top.
- **AI-assisted development:** Lean on AI tools for Godot learning curve, shader implementation, and animation pipeline.
- **Art pipeline:** Undefined — biggest production risk. Architecture should support placeholder/grey-box art swappable with final assets without code changes.
- **Modular zone loading:** Architecture should support adding new zones without modifying core systems. Each zone = new content (levels, enemies, faction, boss, tools) plugging into existing frameworks.

## Project Scoping & Phased Development

### MVP Strategy & Philosophy

**MVP Approach:** Experience MVP — prove the core feel, not feature completeness. One world that nails flow-state combat and atmospheric immersion validates the entire vision. If Golden Glade feels right, every subsequent zone is content expansion on proven foundations.

**Resource:** Solo developer, free time, AI-assisted Godot development. No budget for hiring. Art production strategy TBD.

### MVP Feature Set (Phase 1 — Golden Glade)

**Core Player Journeys Supported:**
- Kai (first-time player) — full journey from prologue through Beetle King
- Vex (challenge runner) — blade-only viability confirmed
- Dex (explorer) — branching paths, environmental storytelling, Beetle faction side quests
- Rena (mastery player) — partially supported through emergent movement tech

**Must-Have Capabilities:**

| System | MVP Requirement | Dependency |
|--------|----------------|------------|
| Blade teleport | Dash-to-blade with momentum, clearance check | None — build first |
| Movement | Run, jump, slide (i-frames), wall slide, wall jump | Blade teleport |
| Parry | Frame-precise detection, slow-mo, magic stocking | Movement + blade |
| Blade companion | Reluctant trust stage, 3-4 emotional states | Blade teleport |
| Tool system | Thumbtack, penny, yarn (v1). Find, use, break. | Movement + combat |
| Crafting | Save point interface, recipe discovery persistence | Tool system + save |
| Save system | Zone progress, rooms, recipes, trust stage, tool inventory | All core systems |
| Level design | 4-5 scrolling connected levels, branching paths, hidden routes | All gameplay systems |
| Enemies | Beetle faction basic enemies with set patterns | Combat system |
| Boss | Beetle King — tool interaction/destruction, graceful degradation | All systems |
| NPC dialogue | Beetle faction characters, environmental text | Level design |
| Environmental storytelling | Human artifact interactions per level | Level design + art |
| Art direction | Minish Cap + Yoshi's Island pixel art established | Parallel with gameplay |
| Music | GBA soundfont, Golden Glade theme, combat layering | Parallel with gameplay |
| Controller input | Controller-first, keyboard secondary | Core architecture |

### Development Sequence (Dependencies)

```
v0.1: Blade teleport → Movement → Momentum preservation
         ↓
v0.2: Parry system → Tool system (thumbtack) → Basic enemy
         ↓
v0.3: Level design → Beetle faction → Boss → Save system → Crafting
       Art direction → Music → Environmental storytelling → NPC dialogue
         ↓
v0.4: Polish → Blade emotional system → Hidden routes → Side quests
```

### Post-MVP Features

**Phase 2 — Growth (Worlds 2-3):**
- Understory (Spiders) and Clearing (Fireflies)
- Blade trust: Willing → Partnered with parameter improvements
- Tool tiers v2 in deeper zones
- New tool types per zone
- Additional blade emotional states
- Backtracking to Golden Glade with new range opens new routes
- Blade response to session return

**Phase 3 — Full Vision (Worlds 4-6):**
- Fungal Depths (Moths), Root Hollows (Ants), Temple
- Full trust arc through Perfect Duo
- Tool tiers v3
- Complete narrative arc and temple choice
- The Moral Fracture: each faction holds a distinct philosophical stance on whether humanity should return — beetles revere humans as creators, moths remember them as destroyers, ants see their legacy as raw material, fireflies observe without judgment, spiders bargain with the truth. The player accumulates perspectives through environmental storytelling and NPC dialogue across all zones, forming their own opinion before discovering the choice is theirs
- Faction musical identity: each faction has instrument associations woven into the zone theme when entering their territory (beetles = heavy brass, moths = high strings/flute, ants = rhythmic percussion, fireflies = bells/chimes, spiders = plucked strings)
- Monument Valley-inspired temple art shift
- Speedrunning support (leaderboards, ghost data)

### Risk Mitigation Strategy

| Risk | Severity | Contingency |
|------|----------|------------|
| Blade teleport doesn't feel right at v0.1 | Critical | Iterate on dash parameters before adding any other system. If fundamental feel can't be achieved, reconsider the dash-to-blade model entirely. This is the make-or-break gate. |
| Art production bottleneck | High | Ship with polished placeholder art if needed. Grey-box gameplay must be fun independent of art quality. Explore AI art tools, asset stores, or community collaborators. Architecture supports hot-swapping art assets. |
| Godot learning curve slows progress | High | Lean on AI-assisted development. Use proven Godot patterns and community examples. Avoid custom engine modifications. Accept simpler implementations that ship over elegant ones that don't. |
| Scope creep beyond Golden Glade | Medium | Golden Glade IS the game for now. Resist adding World 2 content until v0.4 is externally playtested and validated. One polished world > two half-finished worlds. |
| Motivation loss (free-time project) | Medium | Playtest at every milestone for external validation. Keep milestones small enough to complete in reasonable timeframes. The blade character document and world bible provide creative anchors when code gets tedious. |
| Wordless companion emotion doesn't land | Medium | Test blade readability at v0.2 with 2-3 people. If states aren't readable, simplify to fewer, more exaggerated states. The blade can be charming with just 2 clear emotions done well. |

## Functional Requirements

### Blade Traversal & Teleportation

- **FR1** [MVP]: Player can throw the blade in 8 directions (cardinal + diagonal) using controller input
- **FR2** [MVP]: Player can dash-teleport to the blade's location when it has embedded in a valid surface with sufficient clearance
- **FR3** [MVP]: Player's momentum at the point of teleport carries through to the destination (velocity preservation)
- **FR4** [MVP]: Player can recall the blade mid-flight without teleporting (catch cancel)
- **FR5** [MVP]: Blade embeds in wood surfaces (primary surface type for Golden Glade)
- **FR5b** [Growth]: Additional surface materials introduced per zone (stone bounces, metal locks, water sinks, moss slides)
- **FR6** [MVP]: System prevents teleportation when insufficient physical clearance exists at the blade's location
- **FR7** [MVP]: When teleportation is blocked by insufficient clearance, the blade remains embedded and the player receives clear visual/audio feedback indicating the teleport failed — the player can then recall the blade or wait
- **FR8** [MVP]: Player can perceive their current blade throw range through consistent visual feedback (throw arc, glow radius, or other intuitive indicator)

### Core Movement

- **FR9** [MVP]: Player can run, jump, wall slide, and wall jump using controller input
- **FR10** [MVP]: Player can perform a slide with invincibility frames for evasion and repositioning
- **FR11** [MVP]: Movement system supports velocity and state chaining between all movement actions without artificial restrictions (slide into throw into teleport into wall jump)
- **FR12** [MVP]: Player respawns instantly at the last safe position upon death with no loading screen

### Combat System

- **FR13** [MVP]: Player can perform melee attacks with the blade against enemies
- **FR14** [MVP]: Player can parry enemy attacks with frame-precise timing
- **FR15** [MVP]: Successful parries trigger slow-motion visual feedback and stock magic energy for the blade
- **FR16** [MVP]: Chained successful parries build a combo multiplier that increases damage
- **FR17** [MVP]: Player can use stocked magic energy to perform enhanced blade attacks
- **FR18** [MVP]: Player can complete all combat encounters using only the blade without any tools (graceful degradation)

### Tool System

- **FR19** [MVP]: Player can find and pick up improvised tools in the game world (thumbtack, penny, yarn)
- **FR20** [MVP]: Player can use each tool for combat, traversal, and puzzle-solving purposes (multi-use design)
- **FR21** [MVP]: Tools break after a set number of uses, removing them from inventory
- **FR22** [MVP]: Player can craft known tools at save points using discovered recipes
- **FR23** [MVP]: Player can view their known recipes, select a recipe, and craft the tool at a save point
- **FR24** [MVP]: Player discovers new crafting recipes through world exploration and faction interaction
- **FR25** [Growth]: Tools exist in tiered versions (v2/v3) with improved effectiveness in later zones

### Blade Companion System

- **FR26** [MVP]: Blade displays distinct visual and audio emotional states (minimum 3-4 states) readable without explanation
- **FR27** [MVP]: Blade emotional state responds to gameplay context (environment, combat intensity, player mastery, blade-only play)
- **FR28** [MVP]: Blade trust is at Reluctant stage for Golden Glade with corresponding parameter values
- **FR28b** [Growth]: Blade trust progresses through Willing → Partnered → Trusted stages in worlds 2-5
- **FR28c** [Vision]: Blade trust completes through Bonded → Perfect Duo stages in worlds 5-6
- **FR29** [MVP]: Blade parameters improve with each trust stage: throw speed, landing lag, teleport speed, teleport distance
- **FR30** [MVP]: Blade responds emotionally to extended play sessions (excitement during move chains, steadiness during blade-only play)

### Prologue & Onboarding

- **FR31** [MVP]: Game begins with a distinct prologue sequence that introduces the player to the world, the elf, and the blade companion
- **FR32** [MVP]: Prologue contains scripted blade defiance moments establishing the companion's personality and fear before gameplay begins in earnest

### World & Level Design

- **FR33** [MVP]: Levels are scrolling, connected areas with continuous camera following the player at center
- **FR34** [MVP]: Each level contains branching paths with hidden routes accessible through exploration or blade range progression
- **FR35** [Growth]: Previously inaccessible areas become reachable when blade trust/range increases in later zones
- **FR36** [MVP]: Levels contain human artifact environmental storytelling elements that reward attentive observation
- **FR37** [MVP]: World environment reacts visually to player presence and movement to communicate miniature scale

### Faction & NPC System

- **FR38** [MVP]: Faction NPCs deliver dialogue through a text-based dialogue system
- **FR39** [MVP]: Beetle faction offers side quests discoverable through exploration of hidden paths
- **FR40** [MVP]: Faction interactions can reward crafting recipes and lore

### Boss Encounters

- **FR41** [MVP]: Boss fights test the full range of player skills acquired to that point (platforming, combat, tools, blade mastery)
- **FR42** [MVP]: Bosses interact dynamically with player-placed tools (break them, use them against the player)
- **FR43** [MVP]: Boss encounters function fully when player has no tools — attack patterns adapt to provide alternative openings
- **FR44** [MVP]: Boss arena tool spawns use pre-set rotations per attempt, cycling through designed tool layouts to create varied but deterministic tactical situations

### Save & Progression

- **FR45** [MVP]: Player can save progress at designated save points in the world
- **FR46** [MVP]: Save points display an orientation hub showing zone map, discovered rooms, available recipes, and blade trust stage
- **FR47** [MVP]: Save system persists zone progress, discovered rooms, unlocked recipes, blade trust stage, and crafted tool inventory across sessions
- **FR48** [MVP]: Persistent discovery state tracks which rooms have been found and which paths have been opened

### Audio & Music

- **FR49** [MVP]: Each zone has a signature music theme using GBA soundfont instrumentation
- **FR50** [MVP]: Combat triggers dynamic music layering (additional percussion, tempo increase) that peels back smoothly after combat ends
- **FR51** [MVP]: Blade has a distinct audio identity that evolves with trust stage (thin metallic ring early → fuller resonance late)
- **FR52** [MVP]: Sound design communicates scale — world sounds are massive, elf sounds are small and precise

### System & Settings

- **FR53** [MVP]: Player can pause the game and access a pause menu
- **FR54** [MVP]: Player can adjust volume settings (music, sound effects, master)
- **FR55** [MVP]: Player can view and configure controller bindings with sensible defaults for common controller types (Xbox, PlayStation)
- **FR56** [MVP]: Keyboard input is supported as secondary input method

## Non-Functional Requirements

### Performance

- **NFR1:** Game maintains stable 30fps during all gameplay including combat, boss fights, and maximum particle effects on mid-range PC hardware (integrated GPU level)
- **NFR2:** Input-to-action latency does not exceed 2 frames (66ms at 30fps) for all player actions — precision platforming and parry timing demand tight input response
- **NFR3:** Teleport execution (dash-to-blade) completes within 1 frame visually — no perceptible delay between input and arrival
- **NFR4:** Scene transitions between connected level areas are seamless with no loading screens or frame drops
- **NFR5:** Dynamic music layering (combat start/end) transitions smoothly with no audio pops, clicks, or perceptible gaps
- **NFR6:** Save/load operations complete in under 1 second with no gameplay interruption

### Accessibility

- **NFR7:** All controller bindings are fully remappable with no conflicts between actions
- **NFR8:** Blade emotional states are communicated through multiple channels (visual glow + movement + audio) so that no single sense is required to read the blade's state
- **NFR9:** Text in NPC dialogue and menus meets minimum readability standards (sufficient size and contrast for couch-distance play on a TV)
- **NFR10:** Game does not rely solely on color to communicate critical gameplay information (parry timing, teleport availability, danger)

### Reliability

- **NFR11:** Save data is never corrupted by unexpected application closure (crash, power loss, alt-F4) — save writes are atomic
- **NFR12:** No gameplay-breaking bugs in the core loop (blade throw, teleport, parry, movement chaining) — edge cases in the physics system must fail safely rather than softlocking the player
