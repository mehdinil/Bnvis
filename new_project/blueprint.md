#  Blueprint: Benevis | Life OS

## 🧱 Project Overview

**Name:** Benevis | Life OS  
**Goal:** A progressive web app (PWA) and Android app that acts as a “digital life OS” — helping users manage learning, business goals, habits, and daily routines with AI-driven coaching.  
**Technology:** Flutter
**Design language:** Persian RTL, minimal, futuristic, dark violet theme with neon blue/pink gradients.  
**Main tagline:** “سیستم عامل زندگی شما”

---

## 🎨 Branding & Visual Identity

**Primary Colors**
- Deep Violet (Background): `#1B1335`
- Neon Blue (Accent): `#41C9E2`
- Electric Magenta (Accent): `#C94FF7`
- Accent Red (Logo/Error): `#F24C4C`
- Text/FG: `#FFFFFF`

**Logo Concept**
- Stylized letter “B” merging organic (growth) and digital (AI) shapes.
- Gradient: magenta → cyan.
- Typeface: bold futuristic sans serif.
- Text: `BENEVIS` above, `LIFE OS` below in uppercase.
- Works on dark mode backgrounds and app icons.

---

## 🧩 App Structure (Flutter)

The application is built with Flutter, ensuring a consistent experience on both Android and Web.

### 1. Core Architecture
- **State Management:** `flutter_riverpod` for scalable and maintainable state.
- **Data Persistence:** `hive` for fast, local, and offline database storage.
- **Code Generation:** `build_runner`, `hive_generator`, `freezed` for immutable models and boilerplate reduction.
- **Routing:** Flutter's built-in `Navigator` or potentially `go_router` for more complex needs.

### 2. UI Sections
- **Splash/Login Screen:** Biometric or PIN authentication.
- **Dashboard (`HomePage`):** Main overview of goals, streaks, and key stats.
- **Tabs:**
  - `HomePage` (Home)
  - `SkillsPage` (Skills)
  - `BusinessPage` (Business)
  - `JournalPage` (Journal - can evolve into AI Coach)
  - `SettingsPage` (Settings)
- Each tab will be designed with the minimal, animated, and futuristic look defined in the visual identity.
- **Typography:** Utilize `google_fonts` for easy access to modern, readable Persian fonts like Vazirmatn or IRANSansX.

---

## ⚙️ Current & Future Plan

### Current State (Version 1.0)
- The app is a functional Flutter application.
- It uses `hive` for local data storage.
- It has a basic structure with several pages for Journal, Business, etc.
- The build process is stable after migrating to a new Gradle structure and running code generation.

### Next Steps (The "Benevis" Transformation)

1.  **✅ Apply Theming (Current Task):**
    *   Integrate the `google_fonts` package.
    *   Update `main.dart` to use a `ThemeData` that reflects the Benevis color palette (Deep Violet, Neon Blue, Magenta).
    *   Set a suitable futuristic Persian font as the default.

2.  **Refine UI Components:**
    *   Update `Card` widgets, `AppBar`, `BottomNavigationBar` to match the futuristic design.
    *   Incorporate subtle neon glows and gradients.

3.  **Enhance Animations:**
    *   Add `animate_do` or a similar package for simple, elegant animations on page loads and widget entries.

4.  **Integrate AI Coach:**
    *   Create a new page for the AI Coach.
    *   Integrate a generative AI model (like Gemini via `firebase_ai`) for a chat-based coaching experience.

5.  **Improve Data Models:**
    *   Refactor existing Hive models using `freezed` for better immutability and data integrity.

6.  **Web & PWA Support:**
    *   Ensure the Flutter app runs smoothly as a web application.
    *   Configure the app to be a fully installable PWA from the web build.

---
This document will be updated as the project evolves.
