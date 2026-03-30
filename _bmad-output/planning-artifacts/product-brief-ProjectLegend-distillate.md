---
title: "Product Brief Distillate: ProjectLegend"
type: llm-distillate
source: "product-brief-ProjectLegend.md"
created: "2026-03-25"
purpose: "Token-efficient context for downstream PRD creation"
---

# Product Brief Distillate: ProjectLegend

## Design Decisions (Confirmed by Creator)

### Blade Companion
- Blade is wordless — communicates through movement, glow, vibration, sound only (Pikachu model)
- Minimal dialogue exists in the world (faction NPCs, environmental text) but the blade itself never speaks
- Blade personality: Usopp archetype — coward who wants to be brave, core fear is incompetence, core desire is to fulfill its unknown legend
- Early defiance/refusal is a scripted prologue narrative beat ONLY — once gameplay begins, the blade is always reliable
- Trust is zone-gated, linear, never lost — NOT a player-managed mechanic
- Trust is narrative flavor on top of Zelda-style progressive ability unlocking
- Trust stages: Useless (Prologue) → Reluctant (Golden Glade) → Willing (Understory) → Partnered (Clearing) → Trusted (Fungal Depths) → Bonded (Root Hollows) → Perfect Duo (Temple)
- Four specific blade parameters improve with trust: throw speed, landing lag, teleport speed, teleport distance
- Tool parameters never change — only blade improves
- Blade emotional vocabulary should be kept to 3-4 clear visual/audio states to stay within solo dev capacity
- Pre-dev deliverable: one-page blade character document (arc beats, emotional states, key moments per zone)

### Teleport Mechanics
- Teleport is a DASH to the blade's position, not phase-through — elf needs physical clearance at destination
- Mental model: Megaman X slide but point-to-point in a flash
- Momentum carries through teleport (exit at entry velocity if space allows)
- Impossible to teleport into solid matter — space must exist for the elf's body
- Pre-dev deliverable: teleport physics design spec (dash rules, clearance requirements, edge cases)
- Architecture should use dash model, NOT true physics simulation — keep it simple for first Godot project

### Combat System
- Parrying is the skill ceiling — rewards combat power (harder hits, magic energy stocking), NOT trust progression
- Perfect parries: slow-mo blade glow, combo multipliers, stock magic for blade special attacks
- Bosses follow SET PATTERNS — no adaptive AI (explicitly rejected as overkill)
- Bosses interact dynamically with player tools: break them, use them against you, pick up your penny and throw it
- Slide is Megaman X evasion/repositioning tool with i-frames — dodge through attacks, reposition
- Blade-only combat is always viable (weakest approach) — enables minimalist challenge runs

### Tools and Crafting
- Tools found in the wild AND craftable at save points once recipe is learned
- Recipes are progression rewards discovered throughout the game
- Tools come in v1/v2/v3 tiers — stronger versions in deeper zones
- Tools are temporary and breakable — this is intentional, forces adaptation
- Without tools the player can always fight with blade alone — tools are a power layer, not a requirement
- Thematic significance: breakable tools from a vanished civilization embody impermanence — the elf can't keep anything

### World Design
- NOT Celeste single-screen format — scrolling connected levels like Super Mario Bros / Metroid
- Zones have interconnected areas with hidden routes, branching paths, side quest areas
- Previously inaccessible areas open up when blade trust/range increases (Zelda-style backtracking)
- Climbing plants, digging underground, alternating moving platforms — varied traversal within zones
- Human artifact world-building is environmental texture, not a gimmick that needs escalation — attentive players notice details, others just see a rich world
- World bible to be created AFTER v0.1 proves movement feel — build the world around what works

### Art Direction
- Primary visual references: Minish Cap (character/world art) + Yoshi's Island (color philosophy, vibrancy)
- GBA soundfont music — not chiptune, not orchestral, the specific GBA-era voice
- 30fps with strong keyframes, snappy animation, impact freezeframes, smear frames
- Art is the biggest production risk — creator is not an artist
- Art production strategy is open: AI tools, asset stores, potential collaborators to be explored
- Early artistic concepts are critical for feeling the vision even in prototype phase

## Rejected Ideas and Scope Decisions
- Adaptive boss AI that learns player patterns — rejected as overkill for solo dev
- Overly complex enemy AI — rejected during brainstorming (creator has strong scope instincts)
- Trust as a player-managed mechanic that can regress — rejected, trust only grows linearly
- Parry performance affecting trust/relationship — rejected, parry affects combat power only
- Single-screen Celeste-style room format — replaced with scrolling connected world
- Blade defiance as recurring gameplay mechanic — restricted to prologue scripted beat only
- Market-driven development — explicitly rejected, this is a creative passion project

## Technical Context
- Engine: Godot (first Godot project for the creator)
- AI-assisted development is part of the strategy — creator expects AI tools to help learn Godot and soften the technical learning curve
- Architecture should prioritize proven Godot patterns over experimental approaches
- Target platform: Steam/PC, local builds for testing
- Solo developer working in free time outside 9-5 job
- No budget for hiring — art collaboration would need to be found organically

## Competitive Intelligence
- Indie game market ~$11.1B (2025), projected $28.6B by 2033
- 300+ games launch on Steam per week — discoverability is the existential threat for any indie
- Platformers are one of the least performant genres by volume reaching 1K+ reviews on Steam, but breakout quality titles (Celeste, Hollow Knight) crush it — high floor, high ceiling genre
- Silksong (Sept 2025, 7M copies sold) has energized the 2D platformer audience and raised quality expectations
- Godot commercially proven: top titles generated $4-7M revenue (Buckshot Roulette $6.9M, Dome Keeper $6.1M)
- Closest competitors (Celeste, Silksong, Ori, Dead Cells, Bionic Bay) — none combine teleportation + emotional companion + faction system + miniature-world setting
- Blade-throw teleportation is highly streamable/clip-friendly — strong for TikTok/Twitch discovery
- Post-Silksong 2026-2027 window avoids direct collision with the genre's biggest recent release
- GBA-specific soundfont aesthetic is nearly untouched in modern indie releases — clear niche

## Open Questions (Unresolved)
- Art production pipeline: how will sprite art, animations, and environmental art be created? (AI tools? Asset stores? Collaborators?)
- Specific frame budget for vertical slice: how many animation frames per character, blade state, enemy, boss?
- Miniature-world physics contract: does the elf experience standard gravity scaled to tiny size, or human-scale gravity applied to small body? Cascades into jump arcs, fall speed, tool plausibility
- How does the dramatic irony of human objects deepen across later zones, or does it intentionally remain steady environmental texture?
- Tool crafting recipes: what gates recipe discovery? Zone progression? Faction interaction? Exploration?
- Save point design: how frequent? What else happens there beyond crafting?
- How do faction NPCs deliver minimal dialogue — text boxes? Environmental signs? Something else?

## Scope Signals for MVP (v0.3 / v0.4)
- **IN for v0.3:** Golden Glade as complete scrolling world, Beetle faction, full tool set with crafting, Beetle King boss, blade companion personality (Reluctant stage), initial art/music direction, branching paths with hidden routes
- **IN for v0.4:** Polish Golden Glade to release quality, blade emotional system, surface-material puzzle vocabulary, side quest paths, GBA art and music fully realized
- **OUT until post-v0.4:** Worlds 2-6, factions 2-5, full companion arc, philosophical ending choice, tool v2/v3 tiers (beyond what Golden Glade needs)
- **Creator's creative north star:** Flow-state combat where dodge/parry/teleport/tools blur together + atmosphere that sells the miniature world. Both done well in one world = "we got something here"

## Creator Profile
- Solo developer, works on ProjectLegend in free time outside 9-5 job
- Not an artist — art production is the biggest gap and risk
- Strong creative vision and scope instincts — naturally cuts complexity
- Deep Nintendo/GBA influence in every design decision
- Mechanics-first thinker who connects systems to emotional resonance
- Motivated by creative fulfillment, not commercial outcomes
- Iterative development mindset — prove the feel, then expand
- Wants playtesting at every milestone, not just polished versions
