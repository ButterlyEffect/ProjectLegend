---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
lastStep: 8
status: 'complete'
completedAt: '2026-03-29'
inputDocuments:
  - prd.md
  - product-brief-ProjectLegend.md
  - product-brief-ProjectLegend-distillate.md
workflowType: 'architecture'
project_name: 'ProjectLegend'
user_name: 'Simon'
date: '2026-03-27'
---

# Architecture Decision Document

_This document builds collaboratively through step-by-step discovery. Sections are appended as we work through each architectural decision together._

## Project Context Analysis

### Requirements Overview

**Functional Requirements:**
56 FRs across 10 capability areas. The blade system (FR1-FR8) is the architectural foundation — 7 other capability areas depend on it. The blade decomposes into three distinct responsibilities: **throw physics** (trajectory, embedding, clearance), **teleport execution** (dash, momentum transfer), and **companion state** (emotional feedback, trust parameters). These are separate composed nodes, not a monolithic system. Combat (FR13-FR18) and Tools (FR19-FR25) are the next most interconnected systems, both requiring awareness of each other for graceful degradation (FR18, FR43). The companion state machine (FR26-FR30) observes multiple game systems to drive emotional state via signals — a cross-cutting observer pattern.

**Non-Functional Requirements:**
- **NFR1-3 (Performance):** 30fps render target, 2-frame input latency max, 1-frame teleport execution. Physics runs at 60Hz for tighter parry detection granularity (16ms per tick vs 33ms at 30Hz), while rendering at 30fps preserves the GBA-era aesthetic. Frame-based combat timing uses physics ticks, not render frames.
- **NFR4-5 (Seamless transitions):** No loading screens between level areas, smooth music layering. For MVP, use simple scene transitions or one large scene with camera bounds — no streaming architecture until load times become an issue post-MVP.
- **NFR7-10 (Accessibility):** Remappable bindings, multi-channel blade feedback, no color-only communication. Shapes input abstraction and feedback system design.
- **NFR11-12 (Reliability):** Atomic saves, no softlocks from physics edge cases. Shapes save system and physics fail-safe design.

**Scale & Complexity:**

- Primary domain: Godot 4.x, 2D, GDScript
- Complexity level: Medium-high
- Estimated core architectural components: ~14 (see component-to-milestone mapping below)

### Technical Constraints & Dependencies

- **Godot 4.x (first project):** Architecture must use proven Godot patterns. CharacterBody2D for player, Area2D for detection zones, AnimationPlayer/AnimationTree for blade emotional states, AudioStreamPlayer with bus routing for dynamic music.
- **Physics at 60Hz, render at 30fps:** Godot's `_physics_process` at 60Hz provides 16ms parry detection granularity. Rendering at 30fps via Engine.max_fps or project settings. Physics tick rate and render frame rate are independent in Godot.
- **Controller-first:** Input abstraction layer required to support remapping and decouple input from game logic.
- **Solo developer, AI-assisted:** Architecture must be simple enough to implement incrementally. No over-engineering. Each component buildable and testable independently before integration.
- **Art pipeline undefined:** All visual systems must support placeholder/grey-box assets swappable with final art. Scene structure must separate logic from presentation.
- **Level architecture for MVP:** Simple scene transitions or single large scene with camera bounds. No streaming architecture. Zone data is modular (not hardcoded) to support future expansion without needing a streaming system.

### Cross-Cutting Concerns Identified

1. **Blade state propagation:** Blade's current state (thrown, embedded, recalled, trust stage, emotional state) must be observable by movement, combat, companion, audio, and UI systems. Composed blade nodes communicate via Godot signals — no tight coupling.
2. **Input system:** Input abstraction feeds into movement, combat (parry timing), blade throw direction, tool use, and menu navigation. Remapping must not break parry detection or any game-critical input. Must be tested independently.
3. **Tool presence awareness:** Combat encounters, boss AI, and level puzzles must query tool availability and adapt behavior. Graceful degradation is an architectural contract, not per-encounter logic.
4. **Trust stage as global modifier:** Blade parameters change with trust. Movement feel, audio, companion behavior, and range-gated exploration all read from trust stage. Single source of truth required.
5. **Persistent discovery state:** Rooms, recipes, paths, and trust stage must persist atomically. Multiple systems write to this state; save manager must serialize it safely.

### Component-to-Milestone Build Order

**v0.1 — Movement Prototype (3 components):**

| Component | Responsibility |
|-----------|---------------|
| ThrowPhysics | Blade trajectory, 8-directional throw, embedding in wood, clearance detection |
| TeleportExecutor | Dash-to-blade, momentum preservation, teleport failure feedback |
| MovementController | CharacterBody2D: run, jump, slide (i-frames), wall slide, wall jump, velocity chaining |

**v0.2 — Combat Mechanics (+4 components):**

| Component | Responsibility |
|-----------|---------------|
| InputManager | Controller abstraction, remappable bindings, input buffering |
| ParrySubsystem | Frame-precise detection at 60Hz physics, slow-mo trigger, magic stocking, combo multiplier |
| ToolManager | Tool pickup, multi-use (combat/traversal/puzzle), durability/break lifecycle |
| EnemyBase | Basic enemy with set attack patterns, tool-aware behavior |

**v0.3 — Complete World (+5 components):**

| Component | Responsibility |
|-----------|---------------|
| CompanionState | Blade emotional state machine, gameplay context observation, trust stage parameters |
| SaveManager | Atomic persistence: zone progress, rooms, recipes, trust, inventory |
| AudioManager | GBA soundfont playback, combat music layering with bus routing, blade audio identity |
| DialogueSystem | Text-based NPC dialogue, faction character interactions |
| BossFramework | Multi-phase encounters, tool interaction/destruction, graceful degradation, pre-set tool rotations |

**v0.4 — Polish (+2 components):**

| Component | Responsibility |
|-----------|---------------|
| CraftingInterface | Save point UI: recipe browsing, tool crafting, zone map/progress display |
| DiscoveryTracker | Persistent room/path/recipe tracking, range-gated access state |

## Starter Template Evaluation

### Primary Technology Domain

Godot 4.x, GDScript, 2D — based on PRD requirements. Single-player offline game with no web, database, or cloud infrastructure.

### Starter Options Considered

| Option | Source | Verdict |
|--------|--------|---------|
| G2P Studios 2D Platformer Starter Kit | Godot Asset Library (May 2025, Godot 4.4) | Beginner-friendly but standard platformer controller — blade-teleport mechanic makes this irrelevant |
| EladKarni's godot4-2d-platformer-template | GitHub (Aug 2023, Godot 4.1) | Good coyote time / jump buffering patterns to study, but dated and not maintained |
| Chroma Dave's Minimal Platformer | itch.io (Godot 4) | Most feature-complete platformer template, but still standard movement — not blade-teleport |
| Godot 4.4.1 Starter Kit (redflare) | Godot Forum (Aug 2025) | Excellent game shell (menus, settings, save/load, i18n, controller support). Reference for v0.3-v0.4 |
| TakinGodotTemplate | GitHub (440 stars, actively maintained) | Mature project structure with CI/CD. Overwhelming for first-time Godot but good reference |
| Blank Godot 4.x project | Built-in | **Selected** — deepest learning, no irrelevant code to rip out |

### Selected Starter: Blank Godot 4.x Project

**Rationale:** Existing platformer templates include standard movement controllers that would need to be replaced entirely for the blade-throw teleport mechanic. Starting blank ensures every system is understood by the developer — critical for a first Godot project where debugging requires understanding the foundation. Reference templates above for specific patterns (coyote time, save/load, menus) when those systems are needed.

**Initialization:**

```bash
# Godot 4.x new project, then configure Project Settings:
# Display/Window: 480x270 (16:9 GBA-ish resolution, scaled up)
# Physics/Common: Physics Ticks Per Second = 60
# Application/Run: Max FPS = 30
# Rendering/Textures: Default Texture Filter = Nearest (pixel art)
# Rendering/2D: Snap 2D Transforms to Pixel = On
```

### Architectural Decisions Provided by Setup

**Language & Runtime:** GDScript — fastest iteration, best Godot 4 community support, AI tools most knowledgeable about GDScript patterns.

**Project Structure:** Scene-based organization by game feature — each system is self-contained with its scenes, scripts, and assets together.

```
ProjectLegend/
  project.godot
  assets/
    sprites/                 # Placeholder → final art (swappable)
    audio/music/             # GBA soundfont tracks
    audio/sfx/               # Blade, environment, UI sounds
    fonts/
    shaders/
  scenes/
    player/
      player.tscn            # Elf CharacterBody2D
      player.gd              # MovementController
      blade/
        blade.tscn           # Composed: ThrowPhysics + TeleportExecutor + CompanionState
        throw_physics.gd
        teleport_executor.gd
        companion_state.gd
    enemies/                 # EnemyBase + faction-specific
    bosses/                  # BossFramework + specific bosses
    tools/                   # ToolBase + specific tools
    levels/golden_glade/     # Zone levels
    npcs/                    # DialogueSystem + faction NPCs
    ui/                      # Menus, HUD, crafting, save point
  autoloads/
    game_manager.gd          # Global state, trust stage (single source of truth)
    input_manager.gd         # Controller abstraction, remapping
    audio_manager.gd         # Music layering, bus routing
    save_manager.gd          # Atomic persistence
    discovery_tracker.gd     # Room/recipe/path tracking
  resources/
    trust_stages.tres        # Trust stage parameter data
    tool_definitions.tres    # Tool data (durability, tier, recipes)
    enemy_patterns.tres      # Enemy attack pattern data
```

**Autoloads (5 singletons):** game_manager, input_manager, audio_manager, save_manager, discovery_tracker. Used sparingly for truly global state only.

**Data-driven design:** Trust stages, tool definitions, and enemy patterns stored as Godot Resource files (.tres) — editable without code changes, version-control-friendly.

**Reference templates for later milestones:**
- EladKarni's template → coyote time, jump buffering patterns (study for v0.1 MovementController)
- Godot 4.4.1 Starter Kit → menus, settings, save/load patterns (reference at v0.3-v0.4)
- TakinGodotTemplate → CI/CD and export automation (reference when preparing Steam build)

**Note:** Project initialization and folder structure setup should be the first implementation task.

## Core Architectural Decisions

### Decision Priority Analysis

**Critical Decisions (Block Implementation):**
- Node communication pattern (signals + shared resources + autoloads)
- Save data format (JSON for game state, ConfigFile for settings)
- Animation approach (AnimationPlayer + AnimationTree for player, code-driven for blade)
- Level architecture (single TileMap scene per zone with Area2D regions)

**Important Decisions (Shape Architecture):**
- Testing approach (manual primary, GUT for critical systems)
- TileMap as prototyping tool, not final art delivery

**Deferred Decisions (Post-MVP):**
- Final art pipeline and scene composition approach
- Zone-to-zone transition effects
- Steam integration specifics (achievements, cloud saves)
- CI/CD and export automation

### Node Communication Pattern

| Context | Pattern | Example |
|---------|---------|---------|
| Within composed scenes (siblings) | Direct calls | ThrowPhysics calls TeleportExecutor.execute_dash() |
| Between separate scenes (events) | Signals | Blade emits `blade_embedded`, enemy connects and reacts |
| Between separate scenes (state) | Shared Resources | BladeState resource read by CompanionState, AudioManager, and HUD |
| Global systems | Autoloads | SaveManager, InputManager, AudioManager, GameManager, DiscoveryTracker |

**Signal naming convention:** past tense for events (`parry_succeeded`, `tool_broke`, `enemy_died`), present tense for state changes (`trust_stage_changed`, `health_updated`).

**Shared Resource pattern:** Define custom Resource classes (e.g., `BladeStateResource`) with exported properties. Instantiate once in GameManager, pass references to scenes that need it. Multiple readers, single writer (GameManager owns trust stage mutations).

### Save Data Architecture

- **Game state:** JSON file via SaveManager. Dictionary serialized to `user://save_game.json`. Atomic writes via temp file + rename pattern.
- **Settings:** ConfigFile at `user://settings.cfg`. Volume levels, controller bindings, display preferences.
- **Save data schema:**

```json
{
  "version": 1,
  "trust_stage": "reluctant",
  "player_position": {"x": 0, "y": 0},
  "current_zone": "golden_glade",
  "discovered_rooms": ["room_01", "room_02"],
  "unlocked_recipes": ["thumbtack", "yarn"],
  "tool_inventory": [
    {"type": "thumbtack", "tier": 1, "durability": 3}
  ],
  "quest_flags": {"beetle_relic_quest": "complete"},
  "play_time_seconds": 3600
}
```

- **Atomic write pattern:** Write to `save_game.tmp` → verify write completed → rename to `save_game.json`. If crash occurs during write, `.tmp` is discarded on next load and `.json` remains intact (NFR11).

### Animation Architecture

| Target | Approach | Rationale |
|--------|----------|-----------|
| Player (elf) | AnimationPlayer clips + AnimationTree state machine | Snappy 2-frame attacks, held poses, smooth transitions between run/jump/slide/attack/parry states |
| Blade visuals | Code-driven (CompanionState) | Glow color, vibration offset, particle emission change dynamically based on emotional state — too context-dependent for timeline animation |
| Enemies | AnimationPlayer clips + code-driven state | Set attack patterns don't need AnimationTree complexity. Code selects which clip to play based on AI state |
| Bosses | AnimationPlayer clips + code-driven phase state | Multi-phase encounters need code control over which animations play when. Phase transitions trigger specific clips |
| Environment | AnimationPlayer | Grass sway, particle loops, ambient animation on timelines. Fire-and-forget |
| Impact effects | AnimationPlayer + one-shot scenes | Freezeframes, slow-mo on parry, hit sparks — instantiated as temporary scenes |

**Freezeframe pattern for parry:** On successful parry, set `Engine.time_scale = 0.1` for N physics frames, then restore. AnimationPlayer handles the slow-mo blade glow, code handles the time scale.

### Level Architecture

- **Prototyping (v0.1-v0.3):** One TileMap scene per zone. Golden Glade = `golden_glade.tscn` with TileMap layers for terrain, decorative tiles, collision.
- **Area2D regions** within the scene define: room boundaries (for DiscoveryTracker), enemy spawn triggers, NPC interaction zones, save point locations, hidden path entrances.
- **Camera:** Camera2D attached to player, centered, with optional soft limits per Area2D region if needed.
- **Final art (post-prototype):** Replace TileMap visual layers with hand-crafted scene compositions and layered sprites. Collision shapes, Area2D regions, and spawn logic remain unchanged. Logic and presentation are separated by design.
- **Zone transitions (Growth):** Simple `SceneTree.change_scene_to_packed()` with a fade shader. Each zone is its own .tscn file.

### Testing Strategy

- **Primary:** Manual playtesting at every milestone. Play the game. Feel the game. This validates flow, feel, and fun — no automated test can measure that.
- **GUT automated tests for:**
  - SaveManager: write/read integrity, atomic write behavior, schema migration
  - Trust stage calculations: parameter values per stage match design spec
  - Blade clearance checking: edge cases that could cause softlocks
  - Tool durability: break-at-zero, inventory updates correctly
- **Not tested automatically:** Movement feel, animation timing, emotional blade states, level design, combat flow. These are playtested.

### Decision Impact Analysis

**Implementation Sequence:**
1. Project setup + folder structure + autoload stubs
2. MovementController (CharacterBody2D + AnimationTree)
3. ThrowPhysics + TeleportExecutor (signals for blade events)
4. BladeStateResource (shared resource for state propagation)
5. InputManager (controller abstraction)
6. ParrySubsystem (uses Engine.time_scale for freezeframes)
7. ToolManager + ToolBase
8. EnemyBase (connects to blade/combat signals)
9. SaveManager + JSON persistence
10. CompanionState (observes blade signals, reads/writes BladeStateResource)
11. AudioManager (connects to blade/combat/zone signals)
12. Level scene with TileMap + Area2D regions
13. DialogueSystem
14. BossFramework
15. CraftingInterface + DiscoveryTracker

**Cross-Component Dependencies:**

```
GameManager (trust stage, global state)
    ├── BladeStateResource ← read by CompanionState, AudioManager, HUD
    ├── InputManager ← read by MovementController, ParrySubsystem, UI
    └── DiscoveryTracker ← written by Area2D triggers, read by SaveManager

Blade signals (blade_thrown, blade_embedded, blade_recalled, parry_succeeded)
    ├── CompanionState listens → updates BladeStateResource
    ├── AudioManager listens → plays blade sounds
    ├── EnemyBase listens → reacts to parry
    └── BossFramework listens → tool interaction logic

ToolManager signals (tool_picked_up, tool_used, tool_broke)
    ├── HUD listens → updates tool display
    ├── BossFramework listens → graceful degradation check
    └── SaveManager listens → updates inventory
```

## Implementation Patterns & Consistency Rules

### Critical Conflict Points

Where AI agents could make different choices when writing GDScript for this project:

1. Naming (files, nodes, signals, variables)
2. Scene/script organization (where things go)
3. Signal patterns (how events flow)
4. Resource data formats (how .tres and JSON are structured)
5. Error handling (what happens when something fails)
6. State machine patterns (how states are structured)

### Naming Patterns

**File & Directory Naming:**
- All files and folders: `snake_case` (Godot convention, avoids cross-platform issues)
- Scene files: `player.tscn`, `beetle_king.tscn`, `golden_glade.tscn`
- Script files: `movement_controller.gd`, `throw_physics.gd`
- Resource files: `trust_stages.tres`, `thumbtack_data.tres`

**Node Naming:**
- Nodes in scene tree: `PascalCase` (Godot convention)
- `Player`, `Blade`, `ThrowPhysics`, `TeleportExecutor`, `CompanionState`
- Descriptive, no abbreviations: `EnemySpawnZone` not `ESZ`

**GDScript Naming:**
- Classes: `class_name PascalCase` — `class_name BladeStateResource`
- Functions: `snake_case` — `execute_dash()`, `on_blade_embedded()`
- Variables: `snake_case` — `throw_speed`, `trust_stage`
- Constants: `SCREAMING_SNAKE` — `MAX_THROW_RANGE`, `PARRY_WINDOW_FRAMES`
- Private (internal): prefix `_` — `_current_state`, `_update_emotional_state()`
- Signal handlers: prefix `_on_` — `_on_blade_embedded()`, `_on_parry_succeeded()`

**Signal Naming:**
- Past tense for events: `blade_thrown`, `blade_embedded`, `parry_succeeded`, `tool_broke`, `enemy_died`
- Present tense for state changes: `trust_stage_changed`, `emotional_state_updated`, `health_changed`
- No verbs like "handle" or "process" in signal names

### Structure Patterns

**Scene Composition Rules:**
- One root script per scene (the scene's "controller")
- Child nodes can have scripts for subsystem behavior (blade composition)
- Exported variables (`@export`) for tunable parameters — never hardcode game feel values
- All tunable values (speeds, durations, distances) as exported vars or Resource properties

**Script Organization Order:**
```gdscript
# 1. class_name declaration (if needed)
class_name MovementController

# 2. Signals
signal jumped
signal landed
signal slide_started

# 3. Constants
const MAX_SPEED := 200.0
const COYOTE_FRAMES := 6

# 4. Exported variables (tunable in editor)
@export var gravity: float = 980.0
@export var jump_force: float = -350.0

# 5. @onready node references
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var sprite: Sprite2D = $Sprite2D

# 6. Private variables
var _velocity: Vector2 = Vector2.ZERO
var _is_sliding: bool = false

# 7. Godot lifecycle (_ready, _process, _physics_process)
func _ready() -> void:
    pass

func _physics_process(delta: float) -> void:
    pass

# 8. Public methods
func apply_momentum(velocity: Vector2) -> void:
    pass

# 9. Private methods
func _handle_gravity(delta: float) -> void:
    pass

# 10. Signal handlers
func _on_blade_embedded() -> void:
    pass
```

### Signal & Communication Patterns

**Signal connection rules:**
- Connect signals in `_ready()` via code, or in editor for static connections
- Prefer code connections for dynamic relationships (enemies connecting to blade)
- Always disconnect signals when a node is freed (`queue_free()`)

**Signal payload pattern:**
```gdscript
# Signals carry minimal, typed data
signal blade_embedded(position: Vector2, surface_type: StringName)
signal parry_succeeded(magic_gained: float, combo_count: int)
signal tool_broke(tool_type: StringName)

# NOT this — don't pass dictionaries through signals
signal blade_embedded(data: Dictionary)  # Anti-pattern
```

**Shared Resource pattern:**
```gdscript
# Define as custom Resource
class_name BladeStateResource extends Resource

@export var trust_stage: StringName = &"reluctant"
@export var throw_speed: float = 150.0
@export var teleport_speed: float = 300.0
@export var landing_lag_frames: int = 12
@export var max_range: float = 200.0
@export var emotional_state: StringName = &"neutral"

# Readers access properties directly
# Only GameManager writes to trust_stage properties
```

### State Machine Pattern

**All state machines use the same structure:**
```gdscript
# States as StringName constants
const STATE_IDLE := &"idle"
const STATE_RUNNING := &"running"
const STATE_SLIDING := &"sliding"

var _current_state: StringName = STATE_IDLE

func _physics_process(delta: float) -> void:
    match _current_state:
        STATE_IDLE:
            _state_idle(delta)
        STATE_RUNNING:
            _state_running(delta)
        STATE_SLIDING:
            _state_sliding(delta)

func _change_state(new_state: StringName) -> void:
    _exit_state(_current_state)
    _current_state = new_state
    _enter_state(new_state)
```

- Every state machine uses `StringName` constants (not enums, not strings)
- Every state machine has `_enter_state()`, `_exit_state()`, and per-state `_state_X()` functions
- State transitions go through `_change_state()` — never set `_current_state` directly

### Error Handling & Safety

**Physics fail-safe pattern:**
- Blade clearance check returns `false` if ANY doubt — fail safe, not fail open
- If teleport destination is invalid, blade stays embedded, player receives feedback (FR7)
- If player falls out of world bounds, respawn at last safe position (not crash)

**Null safety:**
- Always check `is_instance_valid(node)` before accessing freed nodes
- Use `@onready` for node references — never `get_node()` in `_process()`
- Tool references can be null (blade-only play) — all tool consumers check before access

**Save safety:**
- SaveManager validates JSON schema on load — corrupt data triggers "new game" not crash
- Version field in save data enables migration when schema changes

### Resource Data Patterns

**Trust stage data (trust_stages.tres):**
```
{
  "reluctant":  {"throw_speed": 150, "landing_lag": 12, "teleport_speed": 300, "max_range": 200},
  "willing":    {"throw_speed": 200, "landing_lag": 8,  "teleport_speed": 400, "max_range": 280},
  "partnered":  {"throw_speed": 250, "landing_lag": 5,  "teleport_speed": 500, "max_range": 360}
}
```

**Tool definitions (tool_definitions.tres):**
```
{
  "thumbtack": {"tier": 1, "durability": 5, "uses": ["stab", "springboard", "wall_anchor"]},
  "penny":     {"tier": 1, "durability": 3, "uses": ["shield", "slide_platform"]},
  "yarn":      {"tier": 1, "durability": 4, "uses": ["tripwire", "grapple", "lasso"]}
}
```

All game data in Resource files — never hardcoded in scripts.

### Enforcement Guidelines

**All AI agents implementing ProjectLegend MUST:**

1. Follow `snake_case` for files/variables, `PascalCase` for nodes/classes, `SCREAMING_SNAKE` for constants
2. Use the script organization order (signals → constants → exports → onready → private vars → lifecycle → public → private → handlers)
3. Use signals for inter-scene communication, never direct node references across scene boundaries
4. Use `StringName` state machines with `_change_state()` transitions
5. Put all tunable values in `@export` vars or Resource files — zero magic numbers in logic
6. Check `is_instance_valid()` before accessing potentially freed nodes
7. Write signal payloads as typed parameters, not dictionaries

### Anti-Patterns (Never Do These)

```gdscript
# BAD: Magic numbers in code
velocity.x = 200  # What is 200? Why 200?

# GOOD: Named exported constant
@export var max_speed: float = 200.0
velocity.x = max_speed

# BAD: Direct node reference across scene boundaries
var enemy = get_node("/root/Level/Enemies/Beetle01")

# GOOD: Signals or group queries
get_tree().get_nodes_in_group("enemies")

# BAD: String-based state
if state == "running":  # Typo-prone, no autocomplete

# GOOD: StringName constant
if _current_state == STATE_RUNNING:  # Typo = compile error
```

## Project Structure & Boundaries

### Complete Project Directory Structure

```
ProjectLegend/
├── project.godot                          # Engine config: 30fps, 60Hz physics, pixel snap
├── .gitignore                             # .godot/, *.import, export builds
├── .gdignore                              # Folders Godot should skip
│
├── autoloads/
│   ├── game_manager.gd                    # Trust stage (single source of truth), game state
│   ├── input_manager.gd                   # Controller abstraction, remapping, input buffering
│   ├── audio_manager.gd                   # Music layering, bus routing, blade audio
│   ├── save_manager.gd                    # JSON persistence, atomic writes
│   └── discovery_tracker.gd               # Room/recipe/path tracking
│
├── resources/
│   ├── blade_state_resource.gd            # BladeStateResource class definition
│   ├── blade_state.tres                   # Runtime blade state instance
│   ├── trust_stages.tres                  # Trust stage parameter table
│   ├── tool_definitions.tres              # Tool data (durability, tier, uses, recipes)
│   └── enemy_patterns.tres                # Enemy attack pattern data
│
├── scenes/
│   ├── player/
│   │   ├── player.tscn                    # Elf CharacterBody2D root scene
│   │   ├── movement_controller.gd         # Run, jump, slide, wall mechanics
│   │   ├── player_health.gd              # HP, damage, i-frames, death/respawn
│   │   └── blade/
│   │       ├── blade.tscn                 # Composed blade scene
│   │       ├── throw_physics.gd           # Trajectory, 8-dir throw, embedding, clearance
│   │       ├── teleport_executor.gd       # Dash-to-blade, momentum, failure feedback
│   │       └── companion_state.gd         # Emotional state machine, context observation
│   │
│   ├── combat/
│   │   ├── parry_subsystem.tscn           # Parry detection area + logic
│   │   ├── parry_subsystem.gd             # Frame-precise timing, slow-mo, magic stocking
│   │   ├── hitbox.tscn                    # Reusable hitbox component
│   │   └── hurtbox.tscn                   # Reusable hurtbox component
│   │
│   ├── tools/
│   │   ├── tool_manager.gd               # Tool inventory, pickup, durability
│   │   ├── tool_base.tscn                # Base breakable tool scene
│   │   ├── tool_base.gd                  # Shared tool behavior
│   │   ├── thumbtack/
│   │   │   ├── thumbtack.tscn            # Thumbtack-specific scene
│   │   │   └── thumbtack.gd              # Stab, springboard, wall anchor
│   │   ├── penny/
│   │   │   ├── penny.tscn
│   │   │   └── penny.gd                  # Shield, slide platform
│   │   └── yarn/
│   │       ├── yarn.tscn
│   │       └── yarn.gd                   # Tripwire, grapple, lasso
│   │
│   ├── enemies/
│   │   ├── enemy_base.tscn               # Base enemy with set patterns
│   │   ├── enemy_base.gd                 # Shared enemy behavior, tool-awareness
│   │   └── beetle/
│   │       ├── beetle_soldier.tscn       # Beetle faction basic enemy
│   │       └── beetle_soldier.gd
│   │
│   ├── bosses/
│   │   ├── boss_framework.gd             # Multi-phase, tool interaction, graceful degradation
│   │   └── beetle_king/
│   │       ├── beetle_king.tscn          # Beetle King boss scene
│   │       ├── beetle_king.gd            # Phase logic, tool rotations
│   │       └── beetle_king_phases.tres   # Phase data (attacks, tool spawns per rotation)
│   │
│   ├── npcs/
│   │   ├── dialogue_system.gd            # Text dialogue framework
│   │   ├── dialogue_box.tscn             # UI dialogue display
│   │   └── beetle_npcs/
│   │       ├── beetle_elder.tscn
│   │       └── beetle_elder.gd
│   │
│   ├── levels/
│   │   ├── golden_glade/
│   │   │   ├── golden_glade.tscn         # Full zone: TileMap + Area2D regions
│   │   │   ├── save_points.gd            # Save point placement and behavior
│   │   │   └── environment/
│   │   │       ├── human_artifacts.tscn   # Penny altar, fork-in-ground, etc.
│   │   │       └── interactive_props.gd   # Grass sway, particles, scale elements
│   │   └── prologue/
│   │       ├── prologue.tscn             # Scripted intro sequence
│   │       └── prologue.gd              # Blade defiance scripting
│   │
│   └── ui/
│       ├── main_menu.tscn
│       ├── main_menu.gd
│       ├── pause_menu.tscn
│       ├── pause_menu.gd
│       ├── hud.tscn                      # In-game HUD (tools, magic, blade state)
│       ├── hud.gd
│       ├── crafting_interface.tscn       # Save point crafting UI
│       ├── crafting_interface.gd
│       ├── save_point_hub.tscn           # Zone map, progress, recipes display
│       └── settings_menu.tscn            # Volume, controller bindings
│
├── assets/
│   ├── sprites/
│   │   ├── player/                       # Elf sprite sheets (placeholder → final)
│   │   ├── blade/                        # Blade sprites + glow effects
│   │   ├── enemies/beetle/               # Beetle faction sprites
│   │   ├── bosses/beetle_king/           # Beetle King sprites per phase
│   │   ├── tools/                        # Tool sprites (thumbtack, penny, yarn)
│   │   ├── npcs/                         # NPC sprites
│   │   ├── environment/                  # Tiles, props, human artifacts
│   │   └── ui/                           # Menu elements, HUD icons
│   ├── audio/
│   │   ├── music/
│   │   │   ├── golden_glade_theme.ogg    # Zone theme (GBA soundfont)
│   │   │   ├── golden_glade_combat.ogg   # Combat layer
│   │   │   └── boss_beetle_king.ogg      # Boss music
│   │   └── sfx/
│   │       ├── blade/                    # Throw, embed, recall, parry sounds per trust
│   │       ├── player/                   # Jump, land, slide, footsteps
│   │       ├── combat/                   # Hit, parry success, magic charge
│   │       ├── tools/                    # Tool pickup, use, break sounds
│   │       ├── environment/              # Ambient, grass, wind, insects
│   │       └── ui/                       # Menu select, confirm, cancel
│   ├── fonts/                            # Pixel font for dialogue and UI
│   └── shaders/
│       ├── scene_transition.gdshader     # Fade between zones
│       └── blade_glow.gdshader           # Blade emotional glow effect
│
└── tests/
    ├── gut_config.cfg                    # GUT test framework config
    ├── test_save_manager.gd              # Save/load integrity, atomic writes
    ├── test_trust_stages.gd              # Parameter values match design spec
    ├── test_blade_clearance.gd           # Teleport edge cases
    └── test_tool_durability.gd           # Break-at-zero, inventory updates
```

### Architectural Boundaries

**Scene Boundaries (never cross directly):**

| Boundary | Who's Inside | Communicates Out Via |
|----------|-------------|---------------------|
| Player scene | MovementController, PlayerHealth, Blade (composed) | Signals: `player_damaged`, `player_died`, `player_respawned` |
| Blade scene | ThrowPhysics, TeleportExecutor, CompanionState | Signals: `blade_thrown`, `blade_embedded`, `blade_recalled`, `parry_succeeded` |
| Enemy scenes | EnemyBase, faction-specific logic | Signals: `enemy_died`, `enemy_attack_started` |
| Boss scenes | BossFramework, phase logic | Signals: `phase_changed`, `tool_destroyed`, `boss_defeated` |
| Tool scenes | ToolBase, tool-specific behavior | Signals: `tool_used`, `tool_broke` |
| UI scenes | Menu/HUD logic | Reads BladeStateResource, connects to autoload signals |

**Autoload Boundaries (global, accessible by all):**

| Autoload | Owns | Read By | Written By |
|----------|------|---------|-----------|
| GameManager | Trust stage, game state, BladeStateResource | All gameplay scenes, UI | Only GameManager mutates trust; boss_defeated triggers trust change |
| InputManager | Controller state, bindings | MovementController, ParrySubsystem, UI | Player settings menu |
| AudioManager | Music state, audio buses | Nobody reads — fire-and-forget | Listens to blade/combat/zone signals |
| SaveManager | Save file I/O | Load screen | Zone transitions, save points, auto-save triggers |
| DiscoveryTracker | Room/recipe/path state | SaveManager, CraftingInterface, save point hub | Area2D room triggers, recipe pickup events |

### FR-to-Structure Mapping

| FR Range | Capability | Primary Location |
|----------|-----------|-----------------|
| FR1-FR8 | Blade traversal & teleportation | `scenes/player/blade/` |
| FR9-FR12 | Core movement | `scenes/player/movement_controller.gd` |
| FR13-FR18 | Combat system | `scenes/combat/`, `scenes/player/blade/` |
| FR19-FR25 | Tool system | `scenes/tools/`, `autoloads/game_manager.gd` |
| FR26-FR30 | Blade companion | `scenes/player/blade/companion_state.gd`, `resources/blade_state*.tres` |
| FR31-FR32 | Prologue | `scenes/levels/prologue/` |
| FR33-FR37 | World & level design | `scenes/levels/golden_glade/` |
| FR38-FR40 | Faction & NPC | `scenes/npcs/` |
| FR41-FR44 | Boss encounters | `scenes/bosses/` |
| FR45-FR48 | Save & progression | `autoloads/save_manager.gd`, `autoloads/discovery_tracker.gd` |
| FR49-FR52 | Audio & music | `autoloads/audio_manager.gd`, `assets/audio/` |
| FR53-FR56 | System & settings | `scenes/ui/`, `autoloads/input_manager.gd` |

### Data Flow

```
Controller Input
    → InputManager (abstracts device)
    → MovementController (movement state machine)
    → ThrowPhysics (blade throw on button press)
    → TeleportExecutor (teleport on button press, reads blade position)
    → ParrySubsystem (parry on button press, checks enemy hitbox timing)

Blade Events (signals)
    → CompanionState (updates emotional state)
    → BladeStateResource (shared state for readers)
    → AudioManager (plays contextual blade sounds)
    → HUD (updates blade status display)

Trust Progression
    → Boss defeated signal → GameManager
    → GameManager updates BladeStateResource with new trust stage parameters
    → All readers see new values next frame

Save Flow
    → Save point interaction → SaveManager.save_game()
    → SaveManager reads: GameManager (trust), DiscoveryTracker (rooms/recipes), ToolManager (inventory)
    → Writes JSON to user://save_game.tmp → renames to user://save_game.json
```

## Architecture Validation Results

### Coherence Validation

**Decision Compatibility:** All decisions align. GDScript + Godot 4.x signals + shared Resources + autoloads is the standard Godot architecture pattern. Physics at 60Hz with 30fps render is well-supported. JSON save format works with GDScript's built-in `JSON.stringify()`/`JSON.parse()`. No conflicts between choices.

**Pattern Consistency:** Naming conventions (snake_case files, PascalCase nodes, StringName states) follow Godot community standards throughout. Script organization order, signal patterns, and state machine templates are applied uniformly.

**Structure Alignment:** Project structure directly supports composed blade pattern, autoload-based globals, and scene-based feature organization. No structural conflicts.

### Requirements Coverage

**All 56 Functional Requirements covered.** Every FR maps to a specific component and file location (see FR-to-Structure Mapping above).

**All 12 Non-Functional Requirements covered:**
- NFR1-3 (Performance): 60Hz physics, 30fps render, deterministic timing
- NFR4-5 (Seamless): Single scene per zone, AudioManager bus routing
- NFR7-10 (Accessibility): InputManager remapping, multi-channel blade feedback
- NFR11-12 (Reliability): Atomic JSON saves, clearance fail-safes, is_instance_valid checks
- NFR9 (Text readability): Partially covered — specific font sizing deferred to v0.3 UI implementation

### Testability

Signal-based architecture supports isolated GUT testing from v0.1. ThrowPhysics, TeleportExecutor, ParrySubsystem, and PlayerHealth can each be instantiated and tested individually without loading the full player scene — emit fake signals, verify behavior. This is an architectural strength that enables automated testing from day one.

### Gap Analysis

**No critical gaps.**

**Minor gaps (non-blocking, deferred):**
- **NFR9 font sizing:** Specific pixel font size for couch-distance readability — address during v0.3 UI implementation
- **Blade range indicator UX (FR8):** Architecture supports it via CompanionState, but specific visual pattern (arc preview, glow radius) is a design decision for implementation

### Architecture Completeness Checklist

**Requirements Analysis**
- [x] Project context thoroughly analyzed
- [x] Scale and complexity assessed (medium-high)
- [x] Technical constraints identified (Godot 4.x, solo dev, controller-first)
- [x] Cross-cutting concerns mapped (blade state, input, tools, trust, discovery)

**Architectural Decisions**
- [x] Critical decisions documented (communication, save format, animation, level arch)
- [x] Technology stack fully specified (Godot 4.x, GDScript, 60Hz/30fps)
- [x] Integration patterns defined (signals, shared resources, autoloads)
- [x] Performance considerations addressed (physics tick rate, deterministic timing)

**Implementation Patterns**
- [x] Naming conventions established (file, node, GDScript, signal)
- [x] Structure patterns defined (script organization, scene composition)
- [x] Communication patterns specified (signals, resources, autoloads, direct calls)
- [x] Process patterns documented (state machines, error handling, save safety)

**Project Structure**
- [x] Complete directory structure defined (~50 files)
- [x] Component boundaries established (scene boundaries, autoload boundaries)
- [x] Integration points mapped (signal flow, data flow, save flow)
- [x] Requirements to structure mapping complete (all 56 FRs mapped)

### Architecture Readiness Assessment

**Overall Status:** READY FOR IMPLEMENTATION

**Confidence Level:** High

**Key Strengths:**
- Blade decomposition into 3 composed nodes prevents god-object risk
- Signal-based communication enables independent component development and testing
- Data-driven design (Resource files) means game feel can be tuned without code changes
- Component-to-milestone mapping gives clear build order for solo dev
- Graceful degradation is an architectural pattern, not per-feature logic
- Testable from v0.1 — signal isolation supports GUT testing without full scene loads

**Areas for Future Enhancement:**
- Level streaming architecture when zone sizes exceed single-scene performance (post-MVP)
- CI/CD pipeline for automated Steam builds (v0.4+)
- Art pipeline tooling once art production strategy is determined

### Implementation Handoff

**AI Agent Guidelines:**
- Follow all architectural decisions exactly as documented
- Use implementation patterns consistently across all components
- Respect project structure and scene boundaries
- Refer to this document for all architectural questions
- Use signals between scenes, never direct node references across boundaries
- All tunable values in @export or Resource files — zero magic numbers

**First Implementation Steps:**
1. Create new Godot 4.x project — run it, explore the editor, add a Sprite2D, move it with input. Engine familiarization first.
2. Set up folder structure per the project directory tree above
3. Configure project.godot (30fps max, 60Hz physics, pixel snap, nearest texture filter)
4. Create autoload stubs (5 empty scripts registered as autoloads in Project Settings)
5. Build MovementController with grey-box CharacterBody2D
6. Build ThrowPhysics + TeleportExecutor with placeholder blade sprite

**v0.2 adds:** InputManager, ParrySubsystem, PlayerHealth, ToolManager, EnemyBase
**v0.3 adds:** CompanionState, SaveManager, AudioManager, DialogueSystem, BossFramework
**v0.4 adds:** CraftingInterface, DiscoveryTracker, polish all systems
