# Roux Bridge Trainer MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Web/PWA MVP for practicing Roux first block and second block examples with a 3D cube player, step-by-step playback, and basic practice feedback.

**Architecture:** The app is a Vite React TypeScript PWA. Domain logic lives in small pure TypeScript modules under `src/core` and `src/data`; React components consume those modules and render the trainer UI. The 3D cube is provided by `cubing.js`'s `twisty-player` custom element, keeping cube rendering separate from trainer state.

**Tech Stack:** Vite, React, TypeScript, Vitest, Testing Library, cubing.js, vite-plugin-pwa.

---

## File Structure

- `package.json`: npm scripts and dependencies.
- `index.html`, `vite.config.ts`, `tsconfig*.json`: Vite, TypeScript, testing, and PWA configuration.
- `src/core/alg.ts`: normalize and compare move sequences.
- `src/core/trainer.ts`: session state, step navigation, answer checking.
- `src/core/rouxCheckers.ts`: MVP target validation hooks for FB/SB completion.
- `src/data/rouxCases.ts`: curated FB/SB example cases.
- `src/components/CubePlayer.tsx`: wraps `twisty-player`.
- `src/components/StepControls.tsx`: playback and step navigation controls.
- `src/components/CaseBrowser.tsx`: filters and selects cases.
- `src/components/PracticePanel.tsx`: answer input and feedback.
- `src/App.tsx`, `src/main.tsx`, `src/styles.css`: app shell and visual design.
- `src/**/*.test.ts`: focused Vitest coverage for core behavior and data validity.

## Tasks

### Task 1: Project Scaffold

**Files:**
- Create: `package.json`
- Create: `index.html`
- Create: `vite.config.ts`
- Create: `tsconfig.json`
- Create: `tsconfig.app.json`
- Create: `tsconfig.node.json`
- Create: `src/vite-env.d.ts`

- [ ] Create the Vite/React/TypeScript/PWA project configuration.
- [ ] Install dependencies with `npm install`.
- [ ] Run `npm test -- --run`; expected initial result is "No test files found" or a clean test startup after tests are added.

### Task 2: Core Tests First

**Files:**
- Create: `src/core/alg.test.ts`
- Create: `src/core/trainer.test.ts`
- Create: `src/data/rouxCases.test.ts`

- [ ] Write tests for alg normalization:
  - `U  R  U'` normalizes to `U R U'`.
  - parenthesized group spacing is removed for comparison.
  - empty whitespace normalizes to an empty string.
- [ ] Write tests for trainer sessions:
  - first step is active at index 0.
  - next/previous clamp at valid bounds.
  - current playback alg is the concatenation of steps through the active index.
  - answer comparison accepts equivalent whitespace and rejects different moves.
- [ ] Write tests for data:
  - at least one FB and one SB case exist.
  - every case has steps and a non-empty solution.
  - every step has a non-empty alg and note.
- [ ] Run `npm test -- --run` and confirm these tests fail because modules do not exist.

### Task 3: Core Implementation

**Files:**
- Create: `src/core/types.ts`
- Create: `src/core/alg.ts`
- Create: `src/core/trainer.ts`
- Create: `src/core/rouxCheckers.ts`
- Create: `src/data/rouxCases.ts`

- [ ] Implement shared types for phases, cases, steps, and feedback.
- [ ] Implement algorithm normalization and comparison.
- [ ] Implement trainer session creation, navigation, playback alg composition, and answer checking.
- [ ] Implement MVP target checker hooks that return structured "not yet automated" feedback while still enabling exact-answer practice.
- [ ] Add curated FB/SB examples from Rouxers/Scheopner-style categories with source links.
- [ ] Run `npm test -- --run` and confirm core tests pass.

### Task 4: UI Implementation

**Files:**
- Create: `src/components/CubePlayer.tsx`
- Create: `src/components/StepControls.tsx`
- Create: `src/components/CaseBrowser.tsx`
- Create: `src/components/PracticePanel.tsx`
- Create: `src/App.tsx`
- Create: `src/main.tsx`
- Create: `src/styles.css`

- [ ] Build the app shell with a dense trainer layout, not a marketing landing page.
- [ ] Render `twisty-player` with `experimental-setup-alg` from the case scramble and `alg` from the current playback alg.
- [ ] Provide case filters for all, FB, and SB.
- [ ] Provide icon-style step controls with accessible labels.
- [ ] Provide practice input, exact-answer feedback, and source/reference display.
- [ ] Keep layout responsive for desktop and mobile.

### Task 5: Verification and Run

**Files:**
- Modify as needed based on verification failures.

- [ ] Run `npm test -- --run`; expected: all tests pass.
- [ ] Run `npm run build`; expected: TypeScript and Vite build succeed.
- [ ] Start `npm run dev -- --host 0.0.0.0`; expected: dev server prints a local URL.
- [ ] Report changed files, verification output, and URL.

## Self-Review

- Spec coverage: The plan covers a working Web/PWA MVP with 3D cube display, FB/SB examples, step playback, case browsing, and basic practice feedback.
- Placeholder scan: The plan intentionally excludes full automatic optimal solving in MVP; no task depends on a hidden future implementation.
- Type consistency: Domain types are created first and then consumed by tests, data, and UI.
