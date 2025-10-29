# 🗺️ Benevis Life OS — Development Roadmap

## فازبندی توسعه

---

## 🚀 Phase 1: MVP (۲-۳ هفته)

### هدف
ساخت نسخه اولیه قابل استفاده با ماژول‌های اصلی

### تسک‌ها

#### ✅ Infrastructure (هفته ۱)
- [x] Setup Flutter project structure
- [x] Configure Riverpod
- [x] Setup Isar database
- [x] Create core models (UserProfile, Goal, Habit, JournalEntry)
- [x] Implement theme engine
- [x] Setup localization (fa + en)
- [x] Create shared widgets (GlassCard, GradientButton, etc.)

#### 🔄 Onboarding System (هفته ۱)
- [ ] Create onboarding flow screens (7 slides)
- [ ] Implement dialog-based wizard
- [ ] Save onboarding data to profile
- [ ] Add demo mode auto-bootstrap
- [ ] Add skip option

#### 📊 Core Modules (هفته ۲)

**Goals Module:**
- [ ] Goals list screen
- [ ] Goal detail screen
- [ ] Add/Edit goal dialog
- [ ] Progress tracking
- [ ] Goal completion animation

**Habits Module:**
- [ ] Habits list screen
- [ ] Habit detail with calendar view
- [ ] Add/Edit habit dialog
- [ ] Streak counter
- [ ] Daily check-in button

**Journal Module:**
- [ ] Journal list screen (timeline)
- [ ] Journal entry screen (rich text)
- [ ] Mood selector (emoji)
- [ ] Photo/audio attachment (optional)
- [ ] Search and filter

#### 🏠 Dashboard (هفته ۲)
- [ ] Dashboard layout
- [ ] Today's progress card
- [ ] Active goals widget
- [ ] Habits streak widget
- [ ] Quick add button
- [ ] AI Coach insight card (mock)

#### 🎨 Theme Engine (هفته ۲)
- [ ] Theme selector in settings
- [ ] 4 pre-built themes (Neon, Purple, Minimal, Light)
- [ ] Custom color picker
- [ ] Font selector
- [ ] Preview before apply

#### ⚙️ Settings (هفته ۳)
- [ ] Profile edit screen
- [ ] Theme settings
- [ ] Language switcher
- [ ] Export data to JSON
- [ ] Import from JSON
- [ ] Reset app data
- [ ] About screen

#### 🤖 AI Coach (Mock) (هفته ۳)
- [ ] Rule-based insights generator
- [ ] Daily motivational quotes
- [ ] Analyze journal keywords
- [ ] Suggest next goal
- [ ] Morning/evening notifications (optional)

#### 🏗️ Build & Deploy (هفته ۳)
- [x] GitHub Actions workflow
- [x] Demo mode with --dart-define
- [x] Build two APKs (Demo + Normal)
- [ ] Test on real devices
- [ ] Fix critical bugs

---

## 💰 Phase 2: Finance + AI Advanced (۲ هفته)

### تسک‌ها

#### Finance Module
- [ ] Budget setup wizard
- [ ] Transaction entry (income/expense)
- [ ] Category management
- [ ] Monthly summary chart
- [ ] Export to Excel

#### AI Coach Advanced
- [ ] Sentiment analysis (TFLite)
- [ ] Smart goal recommendations
- [ ] Progress predictions
- [ ] Weekly summary report
- [ ] Chat interface (mock conversation)

#### Statistics
- [ ] Goals statistics dashboard
- [ ] Habits heatmap
- [ ] Journal mood trends
- [ ] Weekly/Monthly reports
- [ ] Export report to PDF

#### Notifications
- [ ] Daily habit reminders
- [ ] Goal deadline alerts
- [ ] Morning/evening check-in
- [ ] Streak milestone celebration

---

## 🔐 Phase 3: Pro Features + Sync (۳ هفته)

### تسک‌ها

#### Security
- [ ] Biometric authentication setup
- [ ] PIN/Pattern lock
- [ ] AES encryption for sensitive data
- [ ] Auto-lock after inactivity

#### Cloud Sync
- [ ] Google Drive integration
- [ ] Auto backup
- [ ] Restore from backup
- [ ] Conflict resolution

#### In-App Purchase
- [ ] Setup IAP (Google Play)
- [ ] Pro subscription screen
- [ ] Payment flow
- [ ] License validation
- [ ] Restore purchases

#### Banking Integration (Optional)
- [ ] SMS permission flow
- [ ] Parse banking SMS
- [ ] Auto-categorize transactions
- [ ] Privacy policy update

#### Skills Module (Bonus)
- [ ] Skills list screen
- [ ] Learning path setup
- [ ] Time tracking
- [ ] Resources library
- [ ] Progress milestones

---

## 🎨 Phase 4: Polish + Launch (۲ هفته)

### تسک‌ها

#### UI Polish
- [ ] Animations (page transitions, celebrations)
- [ ] Micro-interactions
- [ ] Loading states
- [ ] Error states
- [ ] Empty states

#### Testing
- [ ] Unit tests for services
- [ ] Widget tests for screens
- [ ] Integration tests
- [ ] Beta testing (10 users)
- [ ] Bug fixes

#### Marketing Assets
- [ ] App icon (1024x1024)
- [ ] Screenshots (Persian + English)
- [ ] Promotional video (30sec)
- [ ] Landing page
- [ ] Social media posts

#### Store Submission
- [ ] Google Play listing
- [ ] Cafe Bazaar listing (Iran)
- [ ] Privacy policy page
- [ ] Terms of service
- [ ] Submit for review

---

## 📊 Timeline Overview

```
Week 1-3:  Phase 1 (MVP)                  ████████████
Week 4-5:  Phase 2 (Finance + AI)         ██████
Week 6-8:  Phase 3 (Pro + Sync)           ████████████
Week 9-10: Phase 4 (Polish + Launch)      ██████
```

**Total: 10 weeks (2.5 months)**

---

## 🎯 Milestones

| Milestone | Date | Deliverable |
|-----------|------|-------------|
| M1: MVP Complete | Week 3 | Working app with core features |
| M2: Beta Release | Week 5 | Public beta on TestFlight/Firebase |
| M3: Pro Ready | Week 8 | IAP working, cloud sync ready |
| M4: Public Launch | Week 10 | Live on Play Store + Bazaar |

---

## 🚧 Current Status

**Last Updated:** 2025-10-29

### Completed ✅
- [x] Project setup
- [x] Demo mode config
- [x] Profile service
- [x] Onboarding screen (basic)
- [x] Theme engine (basic)
- [x] GitHub Actions workflow

### In Progress 🔄
- [ ] Smart onboarding wizard
- [ ] Goals module
- [ ] Habits module
- [ ] Journal module

### Upcoming ⏳
- Dashboard
- AI Coach mock
- Theme customization

---

## 📝 Notes

- هر فیچر باید ابتدا در برنچ جدا توسعه یابد
- PR review قبل از merge به `main`
- هر فاز یک tag می‌گیرد (v0.1, v0.2, v1.0)
- Testing مداوم در هر commit
