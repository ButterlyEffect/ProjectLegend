---
stepsCompleted: [1, 2, 3, 4]
status: 'complete'
completedAt: '2026-03-29'
inputDocuments:
  - prd.md
  - architecture.md
---

# ProjectLegend - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for ProjectLegend, decomposing the requirements from the PRD and Architecture into implementable stories.

## Requirements Inventory

### Functional Requirements

- FR1 [MVP]: Player can throw the blade in 8 directions (cardinal + diagonal) using controller input
- FR2 [MVP]: Player can dash-teleport to the blade's location when it has embedded in a valid surface with sufficient clearance
- FR3 [MVP]: Player's momentum at the point of teleport carries through to the destination (velocity preservation)
- FR4 [MVP]: Player can recall the blade mid-flight without teleporting (catch cancel)
- FR5 [MVP]: Blade embeds in wood surfaces (primary surface type for Golden Glade)
- FR5b [Growth]: Additional surface materials introduced per zone (stone bounces, metal locks, water sinks, moss slides)
- FR6 [MVP]: System prevents teleportation when insufficient physical clearance exists at the blade's location
- FR7 [MVP]: When teleportation is blocked by insufficient clearance, the blade remains embedded and the player receives clear visual/audio feedback indicating the teleport failed — the player can then recall the blade or wait
- FR8 [MVP]: Player can perceive their current blade throw range through consistent visual feedback (throw arc, glow radius, or other intuitive indicator)
- FR9 [MVP]: Player can run, jump, wall slide, and wall jump using controller input
- FR10 [MVP]: Player can perform a slide with invincibility frames for evasion and repositioning
- FR11 [MVP]: Movement system supports velocity and state chaining between all movement actions without artificial restrictions
- FR12 [MVP]: Player respawns instantly at the last safe position upon death with no loading screen
- FR13 [MVP]: Player can perform melee attacks with the blade against enemies
- FR14 [MVP]: Player can parry enemy attacks with frame-precise timing
- FR15 [MVP]: Successful parries trigger slow-motion visual feedback and stock magic energy for the blade
- FR16 [MVP]: Chained successful parries build a combo multiplier that increases damage
- FR17 [MVP]: Player can use stocked magic energy to perform enhanced blade attacks
- FR18 [MVP]: Player can complete all combat encounters using only the blade without any tools (graceful degradation)
- FR19 [MVP]: Player can find and pick up improvised tools in the game world (thumbtack, penny, yarn)
- FR20 [MVP]: Player can use each tool for combat, traversal, and puzzle-solving purposes (multi-use design)
- FR21 [MVP]: Tools break after a set number of uses, removing them from inventory
- FR22 [MVP]: Player can craft known tools at save points using discovered recipes
- FR23 [MVP]: Player can view their known recipes, select a recipe, and craft the tool at a save point
- FR24 [MVP]: Player discovers new crafting recipes through world exploration and faction interaction
- FR25 [Growth]: Tools exist in tiered versions (v2/v3) with improved effectiveness in later zones
- FR26 [MVP]: Blade displays distinct visual and audio emotional states (minimum 3-4 states) readable without explanation
- FR27 [MVP]: Blade emotional state responds to gameplay context (environment, combat intensity, player mastery, blade-only play)
- FR28 [MVP]: Blade trust is at Reluctant stage for Golden Glade with corresponding parameter values
- FR28b [Growth]: Blade trust progresses through Willing → Partnered → Trusted stages in worlds 2-5
- FR28c [Vision]: Blade trust completes through Bonded → Perfect Duo stages in worlds 5-6
- FR29 [MVP]: Blade parameters improve with each trust stage: throw speed, landing lag, teleport speed, teleport distance
- FR30 [MVP]: Blade responds emotionally to extended play sessions (excitement during move chains, steadiness during blade-only play)
- FR31 [MVP]: Game begins with a distinct prologue sequence that introduces the player to the world, the elf, and the blade companion
- FR32 [MVP]: Prologue contains scripted blade defiance moments establishing the companion's personality and fear before gameplay begins in earnest
- FR33 [MVP]: Levels are scrolling, connected areas with continuous camera following the player at center
- FR34 [MVP]: Each level contains branching paths with hidden routes accessible through exploration or blade range progression
- FR35 [Growth]: Previously inaccessible areas become reachable when blade trust/range increases in later zones
- FR36 [MVP]: Levels contain human artifact environmental storytelling elements that reward attentive observation
- FR37 [MVP]: World environment reacts visually to player presence and movement to communicate miniature scale
- FR38 [MVP]: Faction NPCs deliver dialogue through a text-based dialogue system
- FR39 [MVP]: Beetle faction offers side quests discoverable through exploration of hidden paths
- FR40 [MVP]: Faction interactions can reward crafting recipes and lore
- FR41 [MVP]: Boss fights test the full range of player skills acquired to that point
- FR42 [MVP]: Bosses interact dynamically with player-placed tools (break them, use them against the player)
- FR43 [MVP]: Boss encounters function fully when player has no tools — attack patterns adapt to provide alternative openings
- FR44 [MVP]: Boss arena tool spawns use pre-set rotations per attempt, cycling through designed tool layouts
- FR45 [MVP]: Player can save progress at designated save points in the world
- FR46 [MVP]: Save points display an orientation hub showing zone map, discovered rooms, available recipes, and blade trust stage
- FR47 [MVP]: Save system persists zone progress, discovered rooms, unlocked recipes, blade trust stage, and crafted tool inventory across sessions
- FR48 [MVP]: Persistent discovery state tracks which rooms have been found and which paths have been opened
- FR49 [MVP]: Each zone has a signature music theme using GBA soundfont instrumentation
- FR50 [MVP]: Combat triggers dynamic music layering (additional percussion, tempo increase) that peels back smoothly after combat ends
- FR51 [MVP]: Blade has a distinct audio identity that evolves with trust stage
- FR52 [MVP]: Sound design communicates scale — world sounds are massive, elf sounds are small and precise
- FR53 [MVP]: Player can pause the game and access a pause menu
- FR54 [MVP]: Player can adjust volume settings (music, sound effects, master)
- FR55 [MVP]: Player can view and configure controller bindings with sensible defaults for common controller types (Xbox, PlayStation)
- FR56 [MVP]: Keyboard input is supported as secondary input method

### NonFunctional Requirements

- NFR1: Game maintains stable 30fps during all gameplay on mid-range PC hardware
- NFR2: Input-to-action latency does not exceed 2 frames (66ms at 30fps) for all player actions
- NFR3: Teleport execution (dash-to-blade) completes within 1 frame visually
- NFR4: Scene transitions between connected level areas are seamless with no loading screens or frame drops
- NFR5: Dynamic music layering transitions smoothly with no audio pops, clicks, or perceptible gaps
- NFR6: Save/load operations complete in under 1 second with no gameplay interruption
- NFR7: All controller bindings are fully remappable with no conflicts between actions
- NFR8: Blade emotional states are communicated through multiple channels (visual + movement + audio)
- NFR9: Text in NPC dialogue and menus meets minimum readability standards for couch-distance play
- NFR10: Game does not rely solely on color to communicate critical gameplay information
- NFR11: Save data is never corrupted by unexpected application closure — save writes are atomic
- NFR12: No gameplay-breaking bugs in the core loop — edge cases fail safely rather than softlocking

### Additional Requirements (from Architecture)

- AR1: Godot 4.x project with blank starter, GDScript only
- AR2: Physics at 60Hz, render at 30fps — configured in project.godot
- AR3: Pixel snap and nearest texture filter enabled for pixel art
- AR4: 5 autoload singletons: GameManager, InputManager, AudioManager, SaveManager, DiscoveryTracker
- AR5: Blade decomposed into 3 composed child nodes: ThrowPhysics, TeleportExecutor, CompanionState
- AR6: PlayerHealth component on Player scene — HP, damage, i-frames, death/respawn signals
- AR7: Signal-based inter-scene communication, shared Resources for state, direct calls within composed scenes only
- AR8: StringName state machines with _change_state() transitions for all state-driven systems
- AR9: All tunable values in @export vars or Resource files — zero magic numbers
- AR10: JSON save format with atomic temp-file-then-rename write pattern
- AR11: AnimationPlayer + AnimationTree for player, code-driven for blade emotional states
- AR12: TileMap + Area2D regions for level prototyping, one scene per zone
- AR13: Data-driven trust stages, tool definitions, and enemy patterns via .tres Resource files
- AR14: GUT framework for automated tests on SaveManager, trust calculations, blade clearance, tool durability
- AR15: Controller-first input with InputManager abstraction layer
- AR16: Scene-based project structure organized by game feature

### UX Design Requirements

No UX Design document — UX for this project is the gameplay feel, validated through playtesting.

### FR Coverage Map

- FR1: Epic 1 — Blade 8-directional throw
- FR2: Epic 1 — Dash-teleport to blade
- FR3: Epic 1 — Momentum preservation through teleport
- FR4: Epic 1 — Catch cancel (recall mid-flight)
- FR5: Epic 1 — Blade embeds in wood
- FR6: Epic 1 — Clearance check prevents invalid teleport
- FR7: Epic 1 — Teleport failure feedback
- FR8: Epic 1 — Blade range visual feedback
- FR9: Epic 1 — Run, jump, wall slide, wall jump
- FR10: Epic 1 — Slide with i-frames
- FR11: Epic 1 — Velocity/state chaining
- FR12: Epic 1 — Instant respawn on death
- FR13: Epic 2 — Blade melee attacks
- FR14: Epic 2 — Frame-precise parry
- FR15: Epic 2 — Parry slow-mo and magic stocking
- FR16: Epic 2 — Combo multiplier
- FR17: Epic 2 — Enhanced blade attacks from magic
- FR18: Epic 2 — Blade-only combat viability (graceful degradation)
- FR19: Epic 3 — Find and pick up tools
- FR20: Epic 3 — Multi-use tool design
- FR21: Epic 3 — Tool durability and breaking
- FR22: Epic 3 — Craft tools at save points
- FR23: Epic 3 — Crafting interface (view recipes, select, craft)
- FR24: Epic 3 — Recipe discovery through exploration
- FR26: Epic 4 — Blade emotional states (3-4 readable)
- FR27: Epic 4 — Emotional state responds to gameplay context
- FR28: Epic 4 — Reluctant trust stage parameters
- FR29: Epic 4 — Trust stage parameter improvements
- FR30: Epic 4 — Blade responds to mastery/blade-only play
- FR31: Epic 5 — Prologue sequence
- FR32: Epic 5 — Scripted blade defiance in prologue
- FR33: Epic 5 — Scrolling connected levels, camera centered
- FR34: Epic 5 — Branching paths with hidden routes
- FR36: Epic 5 — Human artifact environmental storytelling
- FR37: Epic 5 — World reacts to player presence (scale communication)
- FR38: Epic 5 — NPC text dialogue system
- FR39: Epic 5 — Beetle faction side quests
- FR40: Epic 5 — Faction interactions reward recipes and lore
- FR41: Epic 6 — Boss tests full player skill range
- FR42: Epic 6 — Boss interacts with player tools
- FR43: Epic 6 — Boss functions without tools (graceful degradation)
- FR44: Epic 6 — Pre-set tool rotations per boss attempt
- FR45: Epic 7 — Save at designated save points
- FR46: Epic 7 — Save point orientation hub
- FR47: Epic 7 — Persistent save data across sessions
- FR48: Epic 7 — Discovery state tracking
- FR49: Epic 8 — Zone signature music (GBA soundfont)
- FR50: Epic 8 — Dynamic combat music layering
- FR51: Epic 8 — Blade audio identity evolves with trust
- FR52: Epic 8 — Scale-aware sound design
- FR53: Epic 9 — Pause menu
- FR54: Epic 9 — Volume settings
- FR55: Epic 9 — Controller binding configuration
- FR56: Epic 9 — Keyboard secondary input

## Epic List

### Epic 1: Core Movement & Blade Traversal
Set up the Godot project, then build the fundamental gameplay verb: the player can run, jump, slide, wall-jump, throw the blade in 8 directions, and dash-teleport to it with momentum preservation.
**FRs covered:** FR1, FR2, FR3, FR4, FR5, FR6, FR7, FR8, FR9, FR10, FR11, FR12
**ARs covered:** AR1-AR5, AR7-AR9, AR11, AR15, AR16
**Milestone:** v0.1

### Epic 2: Combat & Parry
The player can fight enemies with blade melee attacks, parry with frame-precise timing for slow-mo and magic stocking, chain combos, and unleash enhanced blade attacks. Includes player health, damage, and i-frames.
**FRs covered:** FR13, FR14, FR15, FR16, FR17, FR18
**ARs covered:** AR6, AR8, AR11
**Milestone:** v0.2

### Epic 3: Improvised Tools & Crafting
The player can find, use, and break improvised tools (thumbtack, penny, yarn) for combat, traversal, and puzzles. Recipes are discovered through exploration, and tools are craftable at save points. Complete tool lifecycle in one epic.
**FRs covered:** FR19, FR20, FR21, FR22, FR23, FR24
**ARs covered:** AR13
**Milestone:** v0.2-v0.3

### Epic 4: The Living Blade
The blade becomes a companion with 3-4 readable emotional states that respond to gameplay context. Trust parameters define blade feel at the Reluctant stage. The blade reacts to mastery play, blade-only devotion, and environmental mood.
**FRs covered:** FR26, FR27, FR28, FR29, FR30
**ARs covered:** AR5, AR11, AR13
**Milestone:** v0.3

### Epic 5: Golden Glade — A World to Explore
The player explores a complete scrolling zone with branching paths, hidden routes, environmental storytelling (human artifacts), NPC dialogue with Beetle faction, side quests, and a distinct prologue introducing the world and blade.
**FRs covered:** FR31, FR32, FR33, FR34, FR36, FR37, FR38, FR39, FR40
**ARs covered:** AR12
**Milestone:** v0.3

### Epic 6: The Beetle King
The player faces a multi-phase boss that tests platforming, combat, tools, and blade mastery. The boss breaks and uses player tools, with pre-set tool rotations per attempt. Encounter functions fully blade-only (graceful degradation).
**FRs covered:** FR41, FR42, FR43, FR44
**Milestone:** v0.3

### Epic 7: Save & Progression
The player's progress persists across sessions. Save points serve as orientation hubs showing zone map, discovered rooms, and recipes. Discovery state tracks exploration progress. Atomic saves ensure data integrity.
**FRs covered:** FR45, FR46, FR47, FR48
**ARs covered:** AR10, AR14
**Milestone:** v0.3-v0.4

### Epic 8: Audio & Atmosphere
The world comes alive with GBA soundfont music, dynamic combat layering, blade audio identity that evolves with trust, and scale-aware sound design where the world sounds massive and the elf sounds small.
**FRs covered:** FR49, FR50, FR51, FR52
**Milestone:** v0.3-v0.4

### Epic 9: System & Settings
The player can pause, adjust volume, configure controller bindings, and play with keyboard as secondary input. Steam-ready system polish.
**FRs covered:** FR53, FR54, FR55, FR56
**ARs covered:** AR15
**Milestone:** v0.4

---

## Epic 1: Core Movement & Blade Traversal

Set up the Godot project, then build the fundamental gameplay verb: the player can run, jump, slide, wall-jump, throw the blade in 8 directions, and dash-teleport to it with momentum preservation.

### Story 1.1: Project Setup & Engine Configuration

As a **developer**,
I want a properly configured Godot 4.x project with folder structure, autoloads, and input mapping,
So that all subsequent development follows the architecture consistently.

**Acceptance Criteria:**

**Given** a new Godot 4.x project is created
**When** the project is opened in the Godot editor
**Then** the folder structure matches the architecture document (scenes/, autoloads/, resources/, assets/, tests/)
**And** project.godot is configured: max_fps=30, physics_ticks_per_second=60, pixel snap enabled, nearest texture filter
**And** 5 autoload scripts are registered (GameManager, InputManager, AudioManager, SaveManager, DiscoveryTracker)
**And** InputManager defines all input actions with default controller bindings: move_left, move_right, move_up, move_down, jump, slide, throw_blade, teleport, recall_blade, parry, attack, pause
**And** the project runs without errors showing a blank scene

### Story 1.2: Basic Player Movement

As a **player**,
I want to run, jump, wall slide, and wall jump using a controller,
So that I can navigate the game world with precision.

**Acceptance Criteria:**

**Given** a grey-box CharacterBody2D player with placeholder sprite in a test level with walls and platforms
**When** the player presses the left stick or d-pad
**Then** the player runs left/right with configurable speed (@export var)
**And** pressing the jump button makes the player jump with configurable force
**When** the player moves against a wall while airborne
**Then** the player wall slides with gradual descent
**When** the player presses jump while wall sliding
**Then** the player wall jumps away from the wall with momentum
**And** all movement values are @export variables, zero magic numbers
**And** MovementController uses a StringName state machine with _change_state() transitions
**And** all input reads go through InputManager action names, not hardcoded keys

### Story 1.3: Slide with I-Frames

As a **player**,
I want to perform a slide that grants invincibility frames,
So that I can dodge through attacks and reposition quickly.

**Acceptance Criteria:**

**Given** the player is on the ground and running
**When** the player presses the slide button
**Then** the player performs a low slide with configurable duration and speed
**And** the player has invincibility frames during the slide (collision with damage sources ignored)
**When** the slide ends
**Then** the player returns to standing state and can immediately chain into other actions (jump, throw, run)
**And** velocity from the slide carries into subsequent actions without artificial pauses (FR11)

### Story 1.4: Blade Throw — 8-Directional

As a **player**,
I want to throw my blade in 8 directions using the left stick,
So that I can target surfaces and positions for teleportation.

**Acceptance Criteria:**

**Given** the player has the blade (not already thrown)
**When** the player holds a left stick direction and presses the throw button
**Then** the blade launches in 1 of 8 directions (cardinal + diagonal) based on left stick position
**And** the blade travels along a trajectory with configurable speed until it hits a surface or reaches max range
**When** the blade hits a wood surface
**Then** the blade embeds in the surface and stays (FR5)
**And** ThrowPhysics emits `blade_embedded(position, surface_type)` signal
**When** the blade reaches max range without hitting a valid surface
**Then** the blade falls and can be recalled
**And** if no direction is held on throw, blade throws in the direction the player is facing
**And** player faces right by default at spawn/respawn

### Story 1.5: Dash-Teleport to Blade

As a **player**,
I want to dash-teleport to my blade whether it's embedded or mid-flight,
So that I can traverse gaps, reach platforms, and perform mid-air dashes.

**Acceptance Criteria:**

**Given** the blade is embedded in a surface
**When** the player presses the teleport button
**Then** the system checks clearance at the blade's position for the player's body
**If** clearance is sufficient, the player dashes to the blade position within 1 frame visually (NFR3)
**And** the player's momentum at teleport carries through to the destination (FR3)
**If** clearance is insufficient (FR6), the blade remains embedded
**And** the player receives clear visual/audio feedback that the teleport failed (FR7)
**And** the player can recall the blade or wait

**Given** the blade is in flight (not yet embedded)
**When** the player presses the teleport button
**Then** the system checks clearance at the blade's current mid-air position
**If** clearance is sufficient, the player dashes to the blade's current position
**And** momentum carries through — the blade's flight direction contributes to exit velocity
**And** the blade returns to the player's hand after the mid-air teleport
**If** clearance is insufficient, the teleport fails with visual/audio feedback

**And** TeleportExecutor emits appropriate signals on success or failure

### Story 1.6: Blade Recall (Catch Cancel)

As a **player**,
I want to recall my blade mid-flight without teleporting,
So that I can fake out trajectories and re-aim.

**Acceptance Criteria:**

**Given** the blade is in flight (thrown but not yet embedded)
**When** the player presses the recall button
**Then** the blade returns to the player without triggering a teleport (FR4)
**And** the blade is immediately available for another throw
**Given** the blade is embedded in a surface
**When** the player presses the recall button
**Then** the blade returns to the player without teleporting
**And** the return animation is visible and responsive

### Story 1.7: Movement-Teleport Chaining

As a **player**,
I want to chain movement actions fluidly with teleportation,
So that I can build speed and flow through the world.

**Acceptance Criteria:**

**Given** the player is sliding at speed
**When** the player throws the blade and teleports
**Then** the slide momentum carries through the teleport — the player exits at slide speed (FR3, FR11)
**Given** the player is falling
**When** the player teleports to an embedded blade
**Then** falling velocity carries through appropriately
**Given** the player performs a slide → throw → teleport → wall jump sequence
**When** each input is pressed on consecutive frames
**Then** all four actions execute without any forced delay between them
**And** there are no artificial pauses or restrictions between any movement action and blade throw/teleport

### Story 1.8: Out-of-Bounds Respawn

As a **player**,
I want to respawn instantly when I fall out of the world,
So that I can retry immediately without frustration.

**Acceptance Criteria:**

**Given** the player falls below the level boundary
**When** the out-of-bounds trigger is hit
**Then** the player respawns at the last safe position with no loading screen (FR12)
**And** respawn is near-instantaneous (within a few frames)
**And** the blade returns to the player on respawn
**And** the last safe position is tracked and updated as the player moves through the level on valid ground

### Story 1.9: Blade Range Visual Indicator

As a **player**,
I want to see how far my blade can reach before I throw it,
So that I can make informed decisions about teleport targets.

**Acceptance Criteria:**

**Given** the player is aiming the blade (holding a direction before throw)
**When** the aim direction is held
**Then** a subtle visual indicator shows the blade's maximum throw range (glow radius, dotted arc, or ground highlight)
**And** the indicator updates in real time as the player changes aim direction
**And** the indicator reflects the current trust stage's max_range value from BladeStateResource
**And** the indicator is unobtrusive — visible when needed but doesn't clutter gameplay
**When** the player is not aiming
**Then** the range indicator is hidden

---

## Epic 2: Combat & Parry

The player can fight enemies with blade melee attacks, parry with frame-precise timing for slow-mo and magic stocking, chain combos, and unleash enhanced blade attacks. Includes player health, damage, and i-frames.

### Story 2.1: Blade Melee Attacks

As a **player**,
I want to swing my blade at enemies for melee damage,
So that I can fight threats in close range.

**Acceptance Criteria:**

**Given** the player has the blade in hand (not thrown)
**When** the player presses the attack button
**Then** the player performs a melee swing with a hitbox active for configurable frames
**And** enemies within the hitbox take damage based on configurable attack power
**And** attack animation uses AnimationPlayer with snappy 2-frame keyframes
**And** the player can attack in the direction they're facing (left/right)
**And** attack can be performed from ground, air, or wall slide states
**And** attack values (damage, hitbox duration, cooldown) are @export variables

### Story 2.2: Player Health & Damage

As a **player**,
I want to take damage from enemies and have visible health,
So that combat has stakes and I know when I'm in danger.

**Acceptance Criteria:**

**Given** the player has a PlayerHealth component with configurable max HP
**When** an enemy attack hitbox overlaps the player's hurtbox
**Then** the player takes damage and HP decreases
**And** the player enters i-frames for configurable duration (cannot take damage again immediately)
**And** a knockback force is applied in the direction away from the damage source
**And** PlayerHealth emits `player_damaged(amount)` signal
**When** HP reaches zero
**Then** PlayerHealth emits `player_died` signal
**And** the player respawns at last safe position (extending Story 1.8 to HP-based death)
**And** HP resets to max on respawn

### Story 2.3: Frame-Precise Parry

As a **player**,
I want to parry enemy attacks with precise timing,
So that I can counter threats and stock magic energy.

**Acceptance Criteria:**

**Given** the player presses the parry button
**When** an enemy attack hitbox overlaps the parry detection area within the parry window (configurable frame count at 60Hz physics)
**Then** the enemy attack is negated — no damage taken
**And** Engine.time_scale drops to configurable slow-mo value for configurable physics frames, then restores
**And** the blade glows during slow-mo (visual feedback via AnimationPlayer)
**And** magic energy is added to the player's magic stock (configurable amount per parry)
**And** ParrySubsystem emits `parry_succeeded(magic_gained, combo_count)` signal
**When** the parry button is pressed but no enemy attack overlaps during the window
**Then** the parry whiffs — the player has a brief recovery period where they're vulnerable

### Story 2.4: Combo Multiplier

As a **player**,
I want chained parries to build a combo multiplier,
So that skilled play is rewarded with increasing power.

**Acceptance Criteria:**

**Given** the player successfully parries an attack
**When** the player parries another attack within a configurable combo window (frames)
**Then** the combo counter increments
**And** damage on subsequent melee attacks is multiplied by the combo count
**When** the combo window expires without a successful parry
**Then** the combo counter resets to zero
**And** combo count is included in the `parry_succeeded` signal payload

### Story 2.5: Magic Energy & Enhanced Attacks

As a **player**,
I want to spend stocked magic energy on enhanced blade attacks,
So that parry mastery translates into offensive power.

**Acceptance Criteria:**

**Given** the player has magic energy stocked from successful parries
**When** the player presses the enhanced attack input (e.g., hold attack button)
**Then** the blade performs an enhanced attack consuming configurable magic energy
**And** the enhanced attack deals significantly more damage than a normal swing
**And** a distinct visual effect plays (blade glow intensifies, screen flash)
**And** if insufficient magic energy, the normal attack plays instead — no error state

### Story 2.6: Basic Enemy — Beetle Soldier

As a **player**,
I want to fight a basic enemy with set attack patterns,
So that I can practice combat mechanics in a real encounter.

**Acceptance Criteria:**

**Given** a Beetle Soldier enemy is placed in a test level
**When** the player enters the enemy's detection range
**Then** the enemy activates and follows its set attack pattern (patrol → detect → approach → attack)
**And** the enemy has a melee attack with a hitbox that damages the player
**And** the enemy can be damaged by blade melee attacks and dies after configurable HP
**And** the enemy emits `enemy_died` signal on death
**And** the enemy can be parried during its attack animation
**And** EnemyBase uses a StringName state machine with _change_state() transitions
**And** the enemy functions correctly whether or not the player has tools (FR18 — graceful degradation baseline)

### Story 2.7: Minimal Save/Load for Playtesting

As a **developer**,
I want a basic save/load that persists player position and trust stage,
So that playtesting doesn't require restarting from scratch every session.

**Acceptance Criteria:**

**Given** the player is in a test level
**When** a save is triggered (manual key or auto-save)
**Then** SaveManager writes player position, current scene, and trust stage to user://save_game.json
**When** the game is relaunched
**Then** the save loads and player resumes at the saved position
**And** this is a lightweight implementation — full save hub and discovery tracking come in Epic 7
**And** atomic write pattern (temp file + rename) is used from day one (NFR11)

---

## Epic 3: Improvised Tools & Crafting

The player can find, use, and break improvised tools (thumbtack, penny, yarn) for combat, traversal, and puzzles. Recipes are discovered through exploration, and tools are craftable at save points. Complete tool lifecycle in one epic.

> **Note:** Stories 3.2-3.4 are significantly heavier than typical stories — each defines 3 unique gameplay mechanics (9 total across the three tools). Plan accordingly.

### Story 3.1: Tool Pickup & Inventory

As a **player**,
I want to find and pick up tools scattered in the world,
So that I have improvised weapons and traversal aids.

**Acceptance Criteria:**

**Given** a tool item (thumbtack, penny, or yarn) is placed in the level
**When** the player moves over or interacts with the tool
**Then** the tool is added to the player's inventory
**And** ToolManager emits `tool_picked_up(tool_type)` signal
**And** the tool data loads from tool_definitions.tres (type, tier, durability, uses)
**And** the player can hold a configurable maximum number of tools
**When** inventory is full
**Then** the player receives feedback that they can't carry more

### Story 3.2: Thumbtack — Stab, Springboard, Wall Anchor

As a **player**,
I want to use the thumbtack for stabbing enemies, springboarding off surfaces, and anchoring to walls,
So that one tool transforms how I fight and move.

**Acceptance Criteria:**

**Given** the player has a thumbtack in inventory
**When** the player uses the thumbtack in combat
**Then** the thumbtack performs a stab attack dealing configurable damage
**When** the player pins the thumbtack into the ground
**Then** it becomes a springboard — stepping on it launches the player upward with configurable force
**When** the player pins the thumbtack into a wall
**Then** it becomes a temporary platform the player can stand on
**And** each use consumes 1 durability from the thumbtack
**When** durability reaches zero
**Then** the thumbtack breaks, is removed from inventory, and ToolManager emits `tool_broke(tool_type)` signal

### Story 3.3: Penny — Shield & Slide Platform

As a **player**,
I want to use the penny as a shield to block attacks and as a slide platform,
So that I have a defensive tool option.

**Acceptance Criteria:**

**Given** the player has a penny in inventory
**When** the player uses the penny defensively
**Then** it acts as a shield, blocking incoming damage from the facing direction
**When** the player places the penny on the ground
**Then** it becomes a slide platform the player can ride on for quick horizontal repositioning
**And** each use consumes 1 durability
**When** durability reaches zero
**Then** the penny breaks and is removed from inventory with `tool_broke` signal

### Story 3.4: Yarn — Tripwire, Grapple, Lasso

As a **player**,
I want to use yarn as a tripwire, grapple line, or lasso,
So that I can control enemy movement and traverse creatively.

**Acceptance Criteria:**

**Given** the player has yarn in inventory
**When** the player places yarn between two anchor points
**Then** it creates a tripwire that staggers enemies who walk through it
**When** the player attaches yarn to a high anchor point
**Then** it becomes a grapple the player can swing from
**When** the player throws yarn at a small enemy
**Then** it lassos the enemy, briefly immobilizing it
**And** each use consumes 1 durability
**When** durability reaches zero
**Then** the yarn breaks and is removed from inventory with `tool_broke` signal

### Story 3.5: Recipe Discovery

As a **player**,
I want to discover crafting recipes through exploration and faction interaction,
So that I earn the ability to craft tools rather than relying on world drops.

**Acceptance Criteria:**

**Given** the player explores a hidden path or completes a faction interaction
**When** a recipe reward is triggered
**Then** the recipe is unlocked and persisted in the player's discovery state
**And** a notification informs the player which recipe they learned
**And** DiscoveryTracker records the unlocked recipe
**And** the recipe is available at any save point's crafting interface going forward

### Story 3.6: Crafting at Save Points

As a **player**,
I want to craft tools at save points using my discovered recipes,
So that I can prepare for challenges ahead with the tools I need.

**Acceptance Criteria:**

**Given** the player interacts with a save point
**When** the player opens the crafting interface
**Then** a list of discovered recipes is displayed with the tool name and description
**And** the player can select a recipe and craft the tool
**And** the crafted tool is added to inventory (respecting max inventory limit)
**When** the player has no discovered recipes
**Then** the crafting interface shows an empty state indicating no recipes found yet
**And** crafting interface reads from tool_definitions.tres for display data

---

## Epic 4: The Living Blade

The blade becomes a companion with 3-4 readable emotional states that respond to gameplay context. Trust parameters define blade feel at the Reluctant stage. The blade reacts to mastery play, blade-only devotion, and environmental mood.

### Story 4.1: Blade Emotional State Machine

As a **player**,
I want the blade to display distinct emotional states I can read without explanation,
So that I feel connected to my companion.

**Acceptance Criteria:**

**Given** the CompanionState node is active on the blade scene
**When** gameplay is running
**Then** the blade displays one of 3-4 emotional states through visual glow color, vibration/movement pattern, and particle emission
**And** states include at minimum: Neutral, Fearful, Proud, Excited
**And** each state has distinct, non-overlapping visual and audio feedback (NFR8 — multi-channel)
**And** emotional states are code-driven via CompanionState, not AnimationPlayer timelines
**And** state transitions are smooth (blend between glow colors, not hard-cut)

### Story 4.2: Context-Driven Emotional Response

As a **player**,
I want the blade to react to what's happening in gameplay,
So that the companion feels aware and alive.

**Acceptance Criteria:**

**Given** the blade is observing gameplay via signals
**When** the player enters a combat encounter (enemies detected)
**Then** the blade shifts to Fearful state (early trust — it's scared of fighting)
**When** the player lands a successful parry
**Then** the blade briefly flashes Proud
**When** the player chains 3+ moves without stopping
**Then** the blade shifts to Excited (vibrates with energy, glows brighter with each successive move)
**When** the player is in a calm environment with no threats
**Then** the blade returns to Neutral
**And** CompanionState listens to signals from combat, movement, and environment systems — no direct references across scene boundaries

### Story 4.3: Trust Stage Parameters — Reluctant

As a **player**,
I want the blade to feel like the Reluctant trust stage in Golden Glade,
So that the blade's limitations feel intentional and improvement feels earned.

**Acceptance Criteria:**

**Given** GameManager holds the current trust stage as "reluctant"
**When** the blade is used for any action (throw, teleport, melee)
**Then** blade parameters match the Reluctant stage values from trust_stages.tres: slow throw speed, long landing lag, slow teleport speed, short max range
**And** BladeStateResource reflects these values and is readable by all systems
**And** the blade's emotional reactions are muted at Reluctant stage (smaller glow, shorter excitement bursts)
**And** parameter values are entirely data-driven from trust_stages.tres — no hardcoded numbers

### Story 4.4: Blade-Only Devotion Response

As a **player**,
I want the blade to recognize when I'm playing without tools,
So that the companion acknowledges my trust in it alone.

**Acceptance Criteria:**

**Given** the player has no tools in inventory and is engaging in combat
**When** the player fights using only blade melee, parry, and teleport
**Then** the blade's idle animation subtly changes — stands taller, glow is steadier
**And** the blade's Proud state triggers more easily during blade-only combat
**When** the player picks up a tool
**Then** the blade-only response deactivates and returns to normal behavior
**And** CompanionState tracks tool inventory state via ToolManager signals

---

## Epic 5: Golden Glade — A World to Explore

The player explores a complete scrolling zone with branching paths, hidden routes, environmental storytelling (human artifacts), NPC dialogue with Beetle faction, side quests, and a distinct prologue introducing the world and blade.

### Story 5.1: Prologue — The Blade's Defiance

As a **player**,
I want to experience a scripted prologue that introduces the world and my blade companion,
So that I understand the setting and the blade's personality before gameplay begins.

**Acceptance Criteria:**

**Given** the player starts a new game
**When** the prologue scene loads
**Then** a scripted sequence introduces the miniature forest world and the elf
**And** the blade is introduced with scripted defiance moments — it refuses to cooperate, yanks away, dims when asked to fight
**And** the prologue establishes the blade's fear and reluctance through animation and behavior, not dialogue
**And** the prologue transitions into Golden Glade gameplay when the blade reluctantly begins to function
**And** the prologue is a distinct scene (scenes/levels/prologue/)

### Story 5.2a: Base Level Layout & Scrolling

As a **player**,
I want to move through a scrolling level with solid collision and camera tracking,
So that the core world navigation works before full zone buildout.

**Acceptance Criteria:**

**Given** a TileMap scene with terrain, collision, and platforms
**When** the player moves through the level
**Then** the Camera2D follows the player at center with continuous scrolling (FR33)
**And** collision is solid — player stands on platforms, bumps into walls
**And** the level has at least one connected area to prove scrolling works end-to-end
**And** TileMap uses placeholder tiles swappable with final art
**And** at least one Area2D region marks a room boundary for future discovery tracking

### Story 5.2b: Full Zone Buildout — Golden Glade

As a **player**,
I want to explore 4-5 connected level areas with branching paths and hidden routes,
So that the world feels expansive and rewards curiosity.

**Acceptance Criteria:**

**Given** the base level layout from Story 5.2a exists
**When** the zone is expanded
**Then** 4-5 connected level areas exist with distinct visual landmarks and terrain variety
**And** each area has at least one branching path with a hidden route (FR34)
**And** hidden routes are accessible through exploration or skill (not blade range gated in MVP)
**And** Area2D regions mark all room boundaries for discovery tracking
**And** enemy spawn positions are placed in combat-appropriate areas
**And** NPC positions and side quest locations are placed in discoverable spots

### Story 5.3: Environmental Storytelling — Human Artifacts

As a **player**,
I want to discover human artifacts repurposed by elves throughout the world,
So that the miniature world feels rich with history and dramatic irony.

**Acceptance Criteria:**

**Given** human artifact props are placed throughout Golden Glade levels
**When** the player encounters an artifact (penny altar, fork-in-ground, thimble house, etc.)
**Then** the artifact is visually distinct and readable as a repurposed human object
**And** each level area contains at least 2-3 environmental storytelling elements
**And** some artifacts have nearby NPC dialogue or environmental text explaining the elves' interpretation
**And** artifacts are implemented as reusable scene instances from scenes/levels/golden_glade/environment/

### Story 5.4: World Reactivity & Scale Communication

As a **player**,
I want the environment to react to my presence and communicate my tiny scale,
So that the miniature world feels enormous and alive around me.

**Acceptance Criteria:**

**Given** the player moves through Golden Glade
**When** the player passes near interactive environment elements
**Then** grass blades sway in response to player movement
**And** environmental particles float at visible scale (pollen, dust motes, spores)
**And** parallax background layers create depth (soft watercolor gradients behind crisp pixel foreground)
**And** the visual environment reinforces that the player is tiny — objects like leaves, pebbles, and twigs are enormous relative to the elf

### Story 5.5: NPC Dialogue System

As a **player**,
I want to talk to Beetle faction NPCs through text dialogue,
So that I learn about the world and receive quests and recipes.

**Acceptance Criteria:**

**Given** an NPC is placed in the level with dialogue data
**When** the player interacts with the NPC
**Then** a text dialogue box appears displaying the NPC's dialogue
**And** the player can advance through dialogue pages with a button press
**And** dialogue can trigger game events (recipe unlock, quest start, lore flag)
**And** DialogueSystem is a reusable framework — NPC-specific content is data, not code
**And** dialogue text meets minimum readability standards for couch distance (NFR9)

### Story 5.6: Beetle Faction Side Quests

As a **player**,
I want to discover and complete side quests from the Beetle faction,
So that exploration is rewarded with recipes, lore, and faction connection.

**Acceptance Criteria:**

**Given** the player explores a hidden path in Golden Glade
**When** the player finds a Beetle NPC with a side quest
**Then** the NPC presents a quest through dialogue (e.g., "recover the sacred relic")
**And** the quest has a clear objective achievable within the current zone
**When** the player completes the quest objective and returns to the NPC
**Then** the NPC rewards the player with a crafting recipe and/or lore
**And** quest completion is tracked in DiscoveryTracker
**And** faction interactions can reward recipes (FR40) — at least one side quest rewards a tool recipe

### Story 5.7: Save Point Placement in World

As a **player**,
I want save points placed at strategic locations in Golden Glade,
So that I can save progress and craft tools as I explore.

**Acceptance Criteria:**

**Given** the Golden Glade zone is built out
**When** the player explores the zone
**Then** save points are placed at strategic intervals (zone entrance, mid-zone, pre-boss)
**And** save points are visually distinct and recognizable as interactive objects
**And** each save point triggers save functionality (from Story 2.7 minimal save, upgraded in Epic 7)
**And** save points serve as crafting locations (from Story 3.6)
**And** placement ensures the player is never more than a few minutes of gameplay from a save point

---

## Epic 6: The Beetle King

> **Cross-epic dependencies:** This epic requires Epics 2 (combat), 3 (tools), and 5 (world) to be complete. The boss tests combat skills, interacts with tools, and exists within Golden Glade. Do not begin this epic before those are implemented.

The player faces a multi-phase boss that tests platforming, combat, tools, and blade mastery. The boss breaks and uses player tools, with pre-set tool rotations per attempt. Encounter functions fully blade-only (graceful degradation).

### Story 6.1: Boss Arena & Phase Framework

As a **player**,
I want to enter a boss arena and fight a multi-phase encounter,
So that the climax of Golden Glade tests everything I've learned.

**Acceptance Criteria:**

**Given** the player enters the Beetle King arena
**When** the fight begins
**Then** the boss follows a multi-phase encounter structure with distinct phases
**And** each phase has different attack patterns testing different skills (platforming, combat, parry, positioning)
**And** BossFramework manages phase transitions with `phase_changed` signal
**And** phase transition triggers distinct animations (boss roars, arena shifts, brief pause)
**And** the boss has configurable HP per phase from beetle_king_phases.tres
**When** the player dies during the boss fight
**Then** the player respawns at the arena entrance
**And** the boss resets to phase 1 with full HP
**And** placed tools from the previous attempt are cleared
**And** a new tool rotation loads for the next attempt

### Story 6.2: Boss Tool Interaction & Destruction

As a **player**,
I want the boss to interact with my placed tools — breaking them or using them against me,
So that the fight forces improvisation and adaptation.

**Acceptance Criteria:**

**Given** the player has placed tools in the boss arena (thumbtack springboard, yarn tripwire, etc.)
**When** the boss enters a phase where it targets tools
**Then** the boss can break player-placed tools as a phase transition mechanic
**And** the boss can pick up and use penny shields or thumbtacks against the player
**And** tool destruction emits `tool_destroyed` signal
**And** the fight remains fair after tool destruction — the boss doesn't become unbeatable

### Story 6.3: Pre-Set Tool Rotations

As a **player**,
I want different tools available in the boss arena on each attempt,
So that every fight feels different and I can't memorize one optimal strategy.

**Acceptance Criteria:**

**Given** the player enters (or re-enters after death) the Beetle King arena
**When** the fight starts
**Then** tools spawn at pre-set positions defined by the current rotation
**And** rotations cycle through designed layouts from beetle_king_phases.tres (not random)
**And** each rotation provides sufficient tools for a viable strategy
**And** tool spawn positions are placed in tactically interesting but risky locations

### Story 6.4: Graceful Degradation — Blade-Only Boss

As a **player**,
I want to be able to beat the Beetle King with only my blade,
So that challenge runners and blade-only playstyles are viable.

**Acceptance Criteria:**

**Given** the player enters the boss fight with no tools and picks up none during the fight
**When** boss attack patterns that normally target player tools activate
**Then** those patterns redirect into positional attacks creating different but fair openings
**And** all boss phases are completable with blade melee, parry, and teleport alone
**And** the fight is harder without tools but never unfair — clear openings exist in every phase
**And** the boss does not softlock or behave unexpectedly when no tools are present

---

## Epic 7: Save & Progression

The player's progress persists across sessions. Save points serve as orientation hubs showing zone map, discovered rooms, and recipes. Discovery state tracks exploration progress. Atomic saves ensure data integrity.

### Story 7.1: Full Save Points & Persistence

As a **player**,
I want save points to persist my complete game state,
So that I can stop playing and return with all my progress intact.

**Acceptance Criteria:**

**Given** the player interacts with a save point (upgrading Story 2.7 minimal save)
**When** the save triggers
**Then** SaveManager serializes complete game state to JSON: trust stage, player position, current zone, discovered rooms, unlocked recipes, tool inventory, quest flags, play time
**And** save writes use atomic pattern (write to .tmp, rename to .json) (NFR11)
**When** the player launches the game later
**Then** the save loads and the player resumes at the save point with all state restored
**And** save/load completes in under 1 second (NFR6)

### Story 7.2: Discovery State Tracking

As a **player**,
I want the game to track which rooms I've discovered, paths I've opened, and recipes I've unlocked,
So that my exploration progress is meaningful and persistent.

**Acceptance Criteria:**

**Given** the player enters a new room (crosses an Area2D room boundary)
**When** the room has not been previously discovered
**Then** DiscoveryTracker records the room as discovered
**And** discovered rooms, unlocked recipes, and opened paths are included in save data
**When** the save loads
**Then** all discovery state is restored — previously discovered rooms remain discovered
**And** DiscoveryTracker emits signals when new discoveries occur

### Story 7.3: Save Point Orientation Hub

As a **player**,
I want save points to show me a zone map, my discovered rooms, and my recipes,
So that I can orient myself and plan my next move.

**Acceptance Criteria:**

**Given** the player interacts with a save point
**When** the save point hub interface opens
**Then** it displays a zone map showing discovered rooms and undiscovered areas as shadows
**And** it shows the player's current blade trust stage
**And** it shows available crafting recipes (linking to crafting interface from Epic 3)
**And** the hub reads from DiscoveryTracker and GameManager — no duplicate state
**And** the interface is navigable with controller input

### Story 7.4: Save Data Integrity & GUT Tests

As a **developer**,
I want automated tests for save system integrity and critical game systems,
So that corruption and edge-case bugs are caught before they reach playtesters.

**Acceptance Criteria:**

**Given** GUT test framework is installed
**When** test_save_manager.gd runs
**Then** tests verify: write/read round-trip produces identical data
**And** tests verify: atomic write pattern — if write is interrupted, .json from previous save remains intact
**And** tests verify: corrupt JSON triggers new game fallback, not crash
**And** tests verify: save schema version field exists for future migration
**When** test_trust_stages.gd runs
**Then** tests verify parameter values per stage match trust_stages.tres
**When** test_tool_durability.gd runs
**Then** tests verify tools break at zero durability and inventory updates correctly
**When** test_blade_clearance.gd runs
**Then** tests verify: teleport to position where player barely fits succeeds
**And** tests verify: teleport to position inside a wall fails safely with feedback
**And** tests verify: teleport near corners and tight spaces doesn't softlock

---

## Epic 8: Audio & Atmosphere

The world comes alive with GBA soundfont music, dynamic combat layering, blade audio identity that evolves with trust, and scale-aware sound design where the world sounds massive and the elf sounds small.

### Story 8.1: Zone Music & Audio Bus Setup

As a **player**,
I want Golden Glade to have its own GBA soundfont music theme,
So that the world has a distinct sonic identity.

**Acceptance Criteria:**

**Given** AudioManager is set up with audio bus routing (Master, Music, SFX, Blade)
**When** the player is in Golden Glade
**Then** the zone's signature theme plays using GBA soundfont instrumentation
**And** music loops seamlessly
**And** AudioManager manages playback — gameplay systems trigger music via signals, not direct AudioStreamPlayer access
**And** music volume is adjustable independently from SFX

### Story 8.2: Dynamic Combat Music Layering

As a **player**,
I want music to intensify during combat and ease back afterward,
So that fights feel urgent without jarring transitions.

**Acceptance Criteria:**

**Given** the zone theme is playing
**When** the player enters combat (enemy detection trigger)
**Then** additional percussion and tempo layers fade in over a configurable duration
**When** combat ends (all enemies in area defeated or player leaves area)
**Then** combat layers peel back smoothly over a configurable duration
**And** transitions have no audio pops, clicks, or perceptible gaps (NFR5)
**And** AudioManager handles layering through Godot audio bus routing

### Story 8.3: Blade Audio Identity

As a **player**,
I want the blade to have distinct sounds that evolve with trust,
So that the companion's personality is expressed through audio.

**Acceptance Criteria:**

**Given** the blade is at the Reluctant trust stage
**When** the blade is thrown
**Then** a thin, uncertain metallic ring plays
**When** the blade embeds in a surface
**Then** a muted thud/embed sound plays
**When** a parry succeeds
**Then** a satisfying chime plays that matches the blade's current trust-stage audio set
**And** blade audio files are organized per trust stage in assets/audio/sfx/blade/
**And** AudioManager selects the correct audio set based on BladeStateResource.trust_stage
**And** blade audio is on the dedicated Blade audio bus for independent volume control

### Story 8.4: Scale-Aware Sound Design

As a **player**,
I want the world to sound massive around my tiny elf,
So that audio reinforces the miniature scale.

**Acceptance Criteria:**

**Given** the player moves through Golden Glade
**When** environment sounds play (ambient wind, rustling, insects, water)
**Then** world sounds are low-frequency and voluminous — a leaf falling sounds like a hang glider whoosh, an ant's footsteps are heavy thuds
**And** player sounds are small and precise — light footsteps, tiny grunts, crisp slide sound
**And** the contrast between massive world sounds and small player sounds is consistent throughout
**And** ambient soundscape layers are present in every level area

---

## Epic 9: System & Settings

The player can pause, adjust volume, configure controller bindings, and play with keyboard as secondary input. Steam-ready system polish.

### Story 9.1: Pause Menu

As a **player**,
I want to pause the game and access a pause menu,
So that I can take breaks and access settings mid-game.

**Acceptance Criteria:**

**Given** the player is in gameplay
**When** the player presses the pause button
**Then** the game pauses (SceneTree.paused = true)
**And** a pause menu appears with options: Resume, Settings, Quit to Main Menu
**When** the player selects Resume
**Then** the game unpauses and returns to gameplay
**And** pause menu is navigable with controller input

### Story 9.2: Volume Settings

As a **player**,
I want to adjust music, sound effects, and master volume independently,
So that I can customize the audio experience.

**Acceptance Criteria:**

**Given** the player opens the settings menu (from pause or main menu)
**When** the player adjusts volume sliders
**Then** Master, Music, and SFX volumes update in real time via audio bus
**And** volume settings persist to user://settings.cfg via ConfigFile
**And** settings load on game startup
**And** sliders are navigable and adjustable with controller input

### Story 9.3: Controller Binding Configuration

As a **player**,
I want to view and remap my controller bindings,
So that I can play with the button layout that feels best.

**Acceptance Criteria:**

**Given** the player opens controller settings
**When** the player selects an action to remap
**Then** the game prompts for a new button input
**And** the new binding is applied immediately
**And** conflicts are detected — if the new binding is already used, the player is warned
**And** sensible defaults exist for Xbox and PlayStation controllers (FR55)
**And** a "Reset to Defaults" option is available
**And** bindings persist to user://settings.cfg
**And** InputManager applies saved bindings on startup

### Story 9.4: Keyboard Secondary Input

As a **player**,
I want keyboard input to work as a secondary control method,
So that I can play without a controller if needed.

**Acceptance Criteria:**

**Given** no controller is connected or the player prefers keyboard
**When** the player uses keyboard input
**Then** all gameplay actions are mapped to sensible default keyboard keys
**And** keyboard bindings are also remappable through the settings menu
**And** the game seamlessly switches between controller and keyboard input when either is used
**And** UI prompts update to show keyboard keys or controller buttons based on active input device

### Story 9.5: Main Menu

As a **player**,
I want a main menu when I launch the game,
So that I can start a new game, continue a save, or access settings.

**Acceptance Criteria:**

**Given** the player launches ProjectLegend
**When** the main menu loads
**Then** options are displayed: New Game, Continue (if save exists), Settings, Quit
**When** the player selects New Game
**Then** the prologue scene loads
**When** the player selects Continue
**Then** the game loads from user://save_game.json and resumes at the last save point
**When** Continue is selected but no save file exists
**Then** the option is greyed out or hidden
**And** main menu is navigable with controller and keyboard
