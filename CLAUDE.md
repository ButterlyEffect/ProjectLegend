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
- **Implementation:** Epic 1 + Epic 2 complete. Epic 3 in progress — Stories 3.1, 3.2a, 3.2b done. Magic imbue interlude shipped.
- **Epic 3 restructure:** 3.2/3.3/3.4 split into 8 sub-stories per Epic 2 retro CP-1. Now 11 stories in Epic 3.
- **Tool input model:** Tap R2 = default action (stab); hold R2 past ~133ms = aim mode (yellow line); release with no aim = pin at feet; release with aim = throw (3.2c). Hold R2 + tap R1 = imbue (unchanged).
- **Next:** Story 3.2c (Thumbtack — Wall Anchor). Throw thumbtack at a wall, it sticks, becomes a standable platform.
- **Hold-to-aim throw:** E held = range indicator shows, release = blade throws (changed from tap-to-throw)

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
- When Simon says "park it" / "push up" / "done for now" → update CLAUDE.md status + sync Notion Sprint Tracker statuses before committing
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
