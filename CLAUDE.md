# ProjectLegend — Claude Context

## Project Summary
2D precision platformer in Godot 4.x. Tiny elf with a living teleportation blade companion in a post-human miniature forest world. Solo passion project by Simon.

## Key Documents (read these to get up to speed)
- Planning: `_bmad-output/planning-artifacts/prd.md` (56 FRs, 12 NFRs)
- Architecture: `_bmad-output/planning-artifacts/architecture.md` (Godot patterns, 14 components)
- Epics: `_bmad-output/planning-artifacts/epics.md` (9 epics, 50 stories)
- Product Brief: `_bmad-output/planning-artifacts/product-brief-ProjectLegend.md`

## Current Status
- **Planning:** Complete (brief, PRD, architecture, epics)
- **Implementation:** Epic 1 in progress. Stories 1.1-1.5 functional in prototype.
- **Next:** Stories 1.6 (blade recall), 1.7 (movement-teleport chaining), 1.8 (out-of-bounds respawn), 1.9 (range indicator)
- **After that:** Epic 2 (Combat & Parry)

## Game Code
- Located in `game/` subfolder (Godot 4.x project)
- Open Godot → import `game/project.godot`
- Run with Cmd+B (macOS)

## Simon's Preferences
- Creative-first, not market-driven — this is a passion project
- Likes Party Mode (P) for reviewing BMAD workflow sections
- Blade companion references: Amaterasu, Knight from Hollow Knight (not Usopp)
- The world has NPC dialogue — only the blade is wordless
- Controller-first input, 30fps render, 60Hz physics
- Iterative development — prove the feel, then expand

## Workflow: Multi-Laptop Sync
- **CLAUDE.md is the single source of truth** for session state
- When Simon says "park it" / "push up" / "done for now" → update CLAUDE.md status before committing
- When starting a new session → CLAUDE.md auto-loads, say "where did we leave off?" to confirm
- Always commit + push before switching laptops
- Always git pull when starting on the other laptop

## Architecture Quick Reference
- GDScript only, Godot 4.x
- Signals between scenes, direct calls within composed scenes, shared Resources for state
- 5 autoloads: GameManager, InputManager, AudioManager, SaveManager, DiscoveryTracker
- Blade decomposed into: ThrowPhysics, TeleportExecutor, CompanionState
- snake_case files, PascalCase nodes, StringName state machines
- All tunable values in @export vars — zero magic numbers
- JSON saves with atomic writes (temp file + rename)
