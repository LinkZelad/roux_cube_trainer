# Roux Flutter WebView MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Flutter app shell that embeds a self-contained Roux bridge trainer web experience through WebView.

**Architecture:** Flutter owns the app lifecycle, native navigation shell, and future mobile integrations. The training surface is a static HTML/CSS/JS asset loaded from Flutter assets into `webview_flutter`, so the 3D cube layer can later use Web cubing libraries without rewriting Flutter 3D rendering. MVP keeps the web asset self-contained and offline-friendly.

**Tech Stack:** Flutter 3.41, Dart 3.11, Material 3, webview_flutter, flutter_test, local HTML/CSS/JavaScript assets.

---

## File Structure

- `pubspec.yaml`: Flutter metadata, dependencies, and bundled web assets.
- `lib/main.dart`: Material app entry point and WebView trainer screen.
- `assets/trainer/index.html`: embedded trainer UI, examples, playback logic, and 3D placeholder surface.
- `test/widget_test.dart`: verifies app shell renders and creates the trainer route.
- `docs/superpowers/plans/2026-04-28-roux-flutter-webview-mvp.md`: this implementation plan.

## Tasks

### Task 1: Flutter Scaffold

**Files:**
- Create/modify generated Flutter project files.

- [ ] Run `flutter create --project-name roux_cube --platforms=android,ios,linux,web .`.
- [ ] Confirm `lib/main.dart`, `pubspec.yaml`, and platform folders exist.

### Task 2: Dependency and Assets

**Files:**
- Modify: `pubspec.yaml`
- Create: `assets/trainer/index.html`

- [ ] Add `webview_flutter` as a dependency.
- [ ] Add `assets/trainer/` to Flutter assets.
- [ ] Create the trainer HTML asset with FB/SB cases, step controls, practice input, and an obvious placeholder where cubing.js integration will attach.

### Task 3: Flutter Shell

**Files:**
- Modify: `lib/main.dart`

- [ ] Replace the generated counter app with `RouxTrainerApp`.
- [ ] Load `assets/trainer/index.html` through `WebViewController.loadFlutterAsset`.
- [ ] Enable unrestricted JavaScript.
- [ ] Provide a loading overlay and error message for WebView failures.

### Task 4: Tests

**Files:**
- Modify: `test/widget_test.dart`

- [ ] Verify the app title renders.
- [ ] Verify the WebView container route exists without depending on native WebView internals in widget tests.

### Task 5: Verification

**Files:**
- Modify as needed based on verification failures.

- [ ] Run `dart format lib test`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Run `flutter build web`.
- [ ] Report verification results and how to run the app locally.

## Self-Review

- Spec coverage: The plan preserves the requested mobile direction while keeping the 3D cube and formula playback path compatible with Web cubing libraries.
- Placeholder scan: The MVP WebView asset includes an explicit cube surface and training workflow; full cubing.js animation can be added once package/network installation is stable.
- Type consistency: Flutter app and tests use the same `RouxTrainerApp` entry point.
