#!/usr/bin/env python3
import os

new_50_apps = [
    # Cluster A: Interactive Desktop Pets & Gamified Productivity
    {
        "dir": "31-petpals-desktop", "name": "PetPalsDesktop", "icon": "pawprint.fill", "title": "PetPal (Happy)",
        "gradient": "DSTheme.amberGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "On Desktop",
        "desc": "Interactive desktop pet that walks on windows, sleeps during focus sessions, and nudges hydration.",
        "state_vars": """
    @Published var petName: String = "Mochi"
    @Published var petMood: String = "Joyful & Energetic"
    @Published var hungerLevel: Int = 85
    @Published var focusStreakMins: Int = 45
    @Published var petAction: String = "Walking along Xcode title bar"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "pawprint.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PetPals Desktop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Lv. 4 Companion")
                    .font(.system(size: 10, weight: .bold))
                    .padding(4)
                    .background(Color.orange.opacity(0.15))
                    .cornerRadius(4)
            }
            
            VStack(spacing: 8) {
                HStack {
                    Text("🐱")
                        .font(.system(size: 36))
                    VStack(alignment: .leading, spacing: 2) {
                        Text(state.petName)
                            .font(.system(size: 13, weight: .bold))
                        Text(state.petMood)
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button("Feed Fish 🐟") {
                        state.hungerLevel = min(100, state.hungerLevel + 10)
                    }
                    .buttonStyle(.plain)
                    .font(.system(size: 10, weight: .semibold))
                    .padding(6)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(6)
                }
                
                HStack(spacing: 8) {
                    MetricBadge(title: "Hydration Nudge", value: "Every 45m", icon: "drop.fill", tint: .blue)
                    MetricBadge(title: "Focus Time", value: "\(state.focusStreakMins)m", icon: "timer", tint: .green)
                }
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
"""
    },
    {
        "dir": "32-bonsaigrow", "name": "BonsaiGrow", "icon": "leaf.fill", "title": "Bonsai (Lush)",
        "gradient": "DSTheme.emeraldGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Menu Bar",
        "desc": "Virtual Zen Bonsai tree that grows lush leaves with completed focus sessions and withers if distracted.",
        "state_vars": """
    @Published var treeAgeDays: Int = 18
    @Published var leafCount: Int = 142
    @Published var healthPercentage: Int = 96
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BonsaiGrow")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Day \(state.treeAgeDays)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            VStack(spacing: 6) {
                Text("🪴")
                    .font(.system(size: 42))
                Text("Juniper Zen Bonsai")
                    .font(.system(size: 12, weight: .bold))
                Text("\(state.leafCount) healthy leaves grown across 36 deep-work sessions")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .glassCard(cornerRadius: 10)
"""
    },
    {
        "dir": "33-deskfish-aquarium", "name": "DeskFishAquarium", "icon": "drop.circle.fill", "title": "Aquarium (3 Fish)",
        "gradient": "DSTheme.cyanGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Floating HUD",
        "desc": "Floating translucent mini-aquarium HUD with fish whose health depends on daily habit streaks.",
        "state_vars": """
    @Published var fishCount: Int = 3
    @Published var tankCleanliness: Int = 98
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "drop.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DeskFish Aquarium")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐠 🐡 🐟")
            }
            
            Text("Translucent floating desk aquarium. Keeps swimming as you maintain your workflow habits.")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "34-pomodorodragon", "name": "PomodoroDragon", "icon": "flame.circle.fill", "title": "Dragon (Lv. 6)",
        "gradient": "DSTheme.roseGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "25m Cycle",
        "desc": "RPG Pomodoro egg that hatches into unique elemental dragons as you complete 25-minute focus cycles.",
        "state_vars": """
    @Published var dragonLevel: Int = 6
    @Published var pomodorosCompleted: Int = 24
    @Published var currentStreak: Int = 5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "flame.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("PomodoroDragon")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🔥 Ignis Dragon")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Pomodoros", value: "\(state.pomodorosCompleted)", icon: "timer", tint: .red)
                MetricBadge(title: "Dragon Level", value: "Lv. \(state.dragonLevel)", icon: "sparkles", tint: .orange)
            }
"""
    },
    {
        "dir": "35-codecat", "name": "CodeCat", "icon": "cat.fill", "title": "CodeCat (Purring)",
        "gradient": "DSTheme.primaryGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Window Edge",
        "desc": "Animated cat sitting on your active terminal or Xcode window edge, purring on Git commits and test passes.",
        "state_vars": """
    @Published var purrOnCommit: Bool = true
    @Published var meowOnBuildFail: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cat.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CodeCat")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐱 Code Companion")
                    .font(.system(size: 10))
            }
            
            VStack(spacing: 6) {
                Toggle("Purr on successful Git commit", isOn: $state.purrOnCommit)
                    .font(.system(size: 11))
                Toggle("Meow on test or build failure", isOn: $state.meowOnBuildFail)
                    .font(.system(size: 11))
            }
            .padding(10)
            .glassCard(cornerRadius: 10)
"""
    },
    # Cluster B: Focus, Deep Work & Anti-Distraction
    {
        "dir": "36-deepflow-blocker", "name": "DeepFlowBlocker", "icon": "shield.lefthalf.filled", "title": "Shield (Active)",
        "gradient": "DSTheme.roseGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "⌥ F",
        "desc": "Host and process-level distraction website & social app killer with emergency unblock math friction puzzles.",
        "state_vars": """
    @Published var isShieldActive: Bool = true
    @Published var blockedSites: [String] = ["x.com", "reddit.com", "youtube.com", "instagram.com"]
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shield.lefthalf.filled")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DeepFlow Blocker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isShieldActive ? "SHIELD ON" : "PAUSED")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(state.isShieldActive ? .green : .secondary)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Blocked Domains")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.secondary)
                Text(state.blockedSites.joined(separator: " • "))
                    .font(.system(size: 11, design: .monospaced))
                    .padding(8)
                    .glassCard(cornerRadius: 8)
            }
"""
    },
    {
        "dir": "37-zenaudio-ambience", "name": "ZenAudioAmbience", "icon": "headphones", "title": "Zen (Rain)",
        "gradient": "DSTheme.cyanGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Menu Bar",
        "desc": "Binaural beats, brown noise, lo-fi coffee shop, and rain generator with 432Hz focus frequencies.",
        "state_vars": """
    @Published var soundTrack: String = "Nordic Rain & Brown Noise"
    @Published var volume: Double = 0.7
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "headphones")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("ZenAudio Ambience")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("432Hz Focus")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.cyan)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Soundscape: \(state.soundTrack)")
                    .font(.system(size: 11, weight: .semibold))
                Slider(value: $state.volume, in: 0...1)
            }
            .padding(8)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "38-screendimmer-focus", "name": "ScreenDimmerFocus", "icon": "sun.min.fill", "title": "Dimmer",
        "gradient": "DSTheme.primaryGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "⌥ D",
        "desc": "Spotlights your active window and dims/blurs background windows on all connected displays.",
        "state_vars": """
    @Published var dimOpacity: Double = 0.65
    @Published var blurBackground: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sun.min.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("ScreenDimmer Focus")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(Int(state.dimOpacity * 100))% Dim")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Slider(value: $state.dimOpacity, in: 0.2...0.9)
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "39-breakreminder", "name": "BreakReminder", "icon": "eye.fill", "title": "20-20-20 (14m)",
        "gradient": "DSTheme.emeraldGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Timer",
        "desc": "20-20-20 eye strain rule & ergonomic stretch coach with screen fade micro-pauses.",
        "state_vars": """
    @Published var nextBreakMins: Int = 14
    @Published var breaksCompletedToday: Int = 8
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BreakReminder 20-20-20")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Next in \(state.nextBreakMins)m")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Look at an object 20 feet away for 20 seconds every 20 minutes to eliminate eye fatigue.")
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "40-monospace-flow", "name": "MonoSpaceFlow", "icon": "character.cursor.ibeam", "title": "Typewriter",
        "gradient": "DSTheme.amberGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "⌥ T",
        "desc": "Full-screen minimalist typewriter mode with mechanical keyboard audio feedback.",
        "state_vars": """
    @Published var wordCount: Int = 412
    @Published var clickSound: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("MonoSpace Flow")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.wordCount) Words")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Toggle("Mechanical Switch Audio Cues", isOn: $state.clickSound)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster C: Daily Routine, Habit Tracking & Wellness
    {
        "dir": "41-habitgrid", "name": "HabitGrid", "icon": "calendar.day.timeline.left", "title": "Habits (365d)",
        "gradient": "DSTheme.emeraldGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Menu Bar",
        "desc": "GitHub-style 365-day contribution heatmaps for personal daily habits in the menu bar.",
        "state_vars": """
    @Published var streakDays: Int = 42
    @Published var habitsTracked: Int = 4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar.day.timeline.left")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("HabitGrid")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.streakDays) Day Streak 🔥")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 (100% Habit Completion)")
                .font(.system(size: 11, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "42-waterdrop-hud", "name": "WaterDropHUD", "icon": "drop.fill", "title": "1.8L / 2.5L",
        "gradient": "DSTheme.cyanGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "1-Click",
        "desc": "Smart hydration tracker with 1-click water logging, reminders, and daily goal telemetry.",
        "state_vars": """
    @Published var currentLiters: Double = 1.8
    @Published var targetLiters: Double = 2.5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "drop.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WaterDrop HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("72% Goal")
                    .font(.system(size: 10, weight: .bold))
            }
            
            HStack {
                Button("+250ml Glass 💧") { state.currentLiters += 0.25 }
                    .buttonStyle(.plain)
                    .font(.system(size: 11, weight: .bold))
                    .padding(8)
                    .background(Color.cyan.opacity(0.2))
                    .cornerRadius(6)
                Spacer()
                Text(String(format: "%.1fL / %.1fL", state.currentLiters, state.targetLiters))
                    .font(.system(size: 11, weight: .bold, design: .monospaced))
            }
            .padding(6)
            .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "43-postureguard", "name": "PostureGuard", "icon": "figure.stand", "title": "Posture (Good)",
        "gradient": "DSTheme.primaryGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Camera",
        "desc": "Uses local Apple Vision pose estimation to alert when slouching without storing or streaming any video.",
        "state_vars": """
    @Published var isGoodPosture: Bool = true
    @Published var postureScore: Int = 94
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.stand")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PostureGuard")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline Vision")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            
            Text(state.isGoodPosture ? "✓ Ergonomic Spine Alignment Detected" : "⚠️ Slouching detected - adjust chair & monitor")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(state.isGoodPosture ? .green : .red)
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "44-standup-timer", "name": "StandUpTimer", "icon": "arrow.up.circle.fill", "title": "Stand (22m)",
        "gradient": "DSTheme.amberGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Timer",
        "desc": "Standing desk timer with posture intervals and smart desk Bluetooth auto-sync.",
        "state_vars": """
    @Published var standIntervalMins: Int = 45
    @Published var sitIntervalMins: Int = 15
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("StandUp Timer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Standing Time")
                    .font(.system(size: 10))
            }
            
            HStack(spacing: 8) {
                MetricBadge(title: "Sit Interval", value: "45 min", icon: "chair.fill", tint: .blue)
                MetricBadge(title: "Stand Interval", value: "15 min", icon: "figure.stand", tint: .orange)
            }
"""
    },
    {
        "dir": "45-dayplanner-notch", "name": "DayPlannerNotch", "icon": "calendar.badge.clock", "title": "Schedule (Notch)",
        "gradient": "DSTheme.roseGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Notch",
        "desc": "Visual timeline of today's calendar events & time-blocks rendered directly in the MacBook notch.",
        "state_vars": """
    @Published var nextMeeting: String = "Sprint Review @ 3:00 PM"
    @Published var eventsLeftToday: Int = 3
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "calendar.badge.clock")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DayPlanner Notch")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.eventsLeftToday) Events Left")
                    .font(.system(size: 10))
            }
            
            Text("Upcoming: \(state.nextMeeting)")
                .font(.system(size: 11, weight: .semibold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster D: Social, Communication & Creator Presence
    {
        "dir": "46-statussync", "name": "StatusSync", "icon": "bubble.left.and.bubble.right.fill", "title": "Status (Sync)",
        "gradient": "DSTheme.primaryGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Auto",
        "desc": "Auto-syncs Slack, Discord, and Teams status based on active app or calendar event.",
        "state_vars": """
    @Published var currentStatus: String = "🎧 Deep Coding (Do Not Disturb)"
    @Published var activePlatforms: [String] = ["Slack", "Discord", "Teams"]
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("StatusSync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Apps Synced")
                    .font(.system(size: 10))
            }
            
            Text(state.currentStatus)
                .font(.system(size: 11, weight: .bold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "47-quicktweet-x", "name": "QuickTweetX", "icon": "paperplane.fill", "title": "Post Hub",
        "gradient": "DSTheme.cyanGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "⌥ X",
        "desc": "Floating HUD to draft and schedule posts to X, Bluesky, Threads, and Mastodon in one shot.",
        "state_vars": """
    @Published var tweetDraft: String = "Shipping 50 more native macOS apps today! 🚀 #buildinpublic"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("QuickTweet / Post Hub")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ X")
            }
            
            TextEditor(text: $state.tweetDraft)
                .font(.system(size: 11))
                .frame(height: 70)
                .padding(4)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "48-dminbox-unified", "name": "DMInboxUnified", "icon": "tray.full.fill", "title": "DMs (2)",
        "gradient": "DSTheme.amberGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Menu Bar",
        "desc": "Unified menu bar badge & preview for Slack, Discord, Telegram, and WhatsApp messages.",
        "state_vars": """
    @Published var unreadCount: Int = 2
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "tray.full.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DMInbox Unified")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.unreadCount) Unread DMs")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Slack: Team lead mentioned you in #deployments")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "49-streamerbanner", "name": "StreamerBanner", "icon": "sparkles.tv.fill", "title": "Banner",
        "gradient": "DSTheme.roseGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "HUD",
        "desc": "Animated lower-thirds, watermark, and ticker for screen recordings and live streaming.",
        "state_vars": """
    @Published var bannerText: String = "@IndieDev • Shipping 80 Native macOS Apps"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sparkles.tv.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("StreamerBanner")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Overlay Active")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text(state.bannerText)
                .font(.system(size: 11, weight: .bold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "50-emojiforge", "name": "EmojiForge", "icon": "face.smiling.fill", "title": "Emoji",
        "gradient": "DSTheme.emeraldGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "⌘ .",
        "desc": "Floating emoji & kaomoji picker with custom Slack/Discord emoji batch uploader & resizer.",
        "state_vars": """
    @Published var kaomoji: String = "(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "face.smiling.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("EmojiForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ .")
            }
            
            Text("Quick Kaomoji: (╯°□°)╯︵ ┻━┻ • ¯\\_(ツ)_/¯ • (•‿•)")
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster E: Advanced AI & Local Intelligence
    {
        "dir": "51-pdfwhisper-ai", "name": "PDFWhisperAI", "icon": "doc.text.magnifyingglass", "title": "PDF AI",
        "gradient": "DSTheme.primaryGradient", "category": "ai", "categoryName": "AI & Vision", "hotkey": "Drop PDF",
        "desc": "Instant local Q&A with PDFs via Apple Silicon embeddings & CoreML (100% offline).",
        "state_vars": """
    @Published var pdfDocName: String = "quarterly_earnings_report.pdf"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PDFWhisper AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Offline Embeddings")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
            }
            
            Text("Drop any PDF to ask questions, extract tables, and summarize key insights locally.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "52-gitcommit-ai", "name": "GitCommitAI", "icon": "arrow.triangle.branch", "title": "Commit AI",
        "gradient": "DSTheme.emeraldGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "⌥ C",
        "desc": "1-click conventional git commit message generator from active unstaged/staged diffs.",
        "state_vars": """
    @Published var generatedCommit: String = "feat(core): add 50 new apps across focus, routine, pets & AI"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.branch")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("GitCommit AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Diff Parsed")
                    .font(.system(size: 10))
            }
            
            Text(state.generatedCommit)
                .font(.system(size: 11, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "53-codeexplainer-hud", "name": "CodeExplainerHUD", "icon": "questionmark.circle.fill", "title": "Explain",
        "gradient": "DSTheme.cyanGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "Highlight",
        "desc": "Highlight any cryptic code, regex, or error on screen and get an instant plain-English breakdown.",
        "state_vars": """
    @Published var explanation: String = "This regex validates RFC 5322 email addresses with domain extensions."
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CodeExplainer HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Instant Decrypt")
                    .font(.system(size: 10))
            }
            
            Text(state.explanation)
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "54-voicetranscribe-batch", "name": "VoiceTranscribeBatch", "icon": "mic.badge.plus", "title": "Batch Audio",
        "gradient": "DSTheme.roseGradient", "category": "ai", "categoryName": "AI & Voice", "hotkey": "Drop Audio",
        "desc": "Drop long-form podcasts and meetings to generate speaker-diarized timestamped transcripts.",
        "state_vars": """
    @Published var filesProcessed: Int = 12
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "mic.badge.plus")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("VoiceTranscribe Batch")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("WhisperKit MLX")
                    .font(.system(size: 10))
            }
            
            Text("Drop .mp3 / .wav / .m4a files for batch background transcription with timestamps.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "55-aiwallpaper-generator", "name": "AIWallpaperGenerator", "icon": "photo.artframe", "title": "Wallpapers",
        "gradient": "DSTheme.amberGradient", "category": "ai", "categoryName": "AI & Creative", "hotkey": "4K Gen",
        "desc": "Generates 4K dynamic desktop wallpapers using local Stable Diffusion / CoreML models.",
        "state_vars": """
    @Published var prompt: String = "Futuristic neon cyberpunk Tokyo rain 4K"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "photo.artframe")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AIWallpaper Generator")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("CoreML 4K")
                    .font(.system(size: 10))
            }
            
            Text("Prompt: \(state.prompt)")
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster F: Developer & System Engineering Power Tools
    {
        "dir": "56-jsonmaster-pro", "name": "JSONMasterPro", "icon": "curlybraces", "title": "JSON Pro",
        "gradient": "DSTheme.cyanGradient", "category": "dev", "categoryName": "Developer", "hotkey": "HUD",
        "desc": "Instant JSON/YAML/TOML viewer, formatter, path extractor, and TypeScript type generator.",
        "state_vars": """
    @Published var isValidJSON: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "curlybraces")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("JSONMaster Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Valid JSON ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Tree inspector, YAML/TOML converter, and TypeScript interface generator.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "57-cronvisualizer", "name": "CronVisualizer", "icon": "clock.arrow.circlepath", "title": "Cron (*/5)",
        "gradient": "DSTheme.amberGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "Visual cron expression builder, human-readable explainer, and next-runs schedule debugger.",
        "state_vars": """
    @Published var cronExpr: String = "*/15 * * * *"
    @Published var humanMeaning: String = "Every 15 minutes"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "clock.arrow.circlepath")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CronVisualizer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.cronExpr)
                    .font(.system(size: 10, design: .monospaced))
            }
            
            Text("Meaning: \(state.humanMeaning)")
                .font(.system(size: 11, weight: .bold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "58-dockerquick-hud", "name": "DockerQuickHUD", "icon": "shippingbox.fill", "title": "Docker (4)",
        "gradient": "DSTheme.primaryGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "Lightweight container viewer, start/stop/restart, log stream, and volume cleanup.",
        "state_vars": """
    @Published var runningContainers: Int = 4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DockerQuick HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.runningContainers) Running")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("redis:latest • postgres:16 • nextjs-app • api-gateway")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "59-hostsmanager", "name": "HostsManager", "icon": "server.rack", "title": "Hosts (Dev)",
        "gradient": "DSTheme.emeraldGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "1-click /etc/hosts profile switcher for staging, dev, testing, and production domains.",
        "state_vars": """
    @Published var activeProfile: String = "Local Dev (127.0.0.1)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("HostsManager")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.activeProfile)
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("1-click switch between Staging, Dev, QA, and Production DNS entries.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "60-certsentry", "name": "CertSentry", "icon": "lock.badge.clock.fill", "title": "SSL (34d)",
        "gradient": "DSTheme.roseGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "SSL/TLS certificate expiration tracker for your domains with 30/14/7-day alerts.",
        "state_vars": """
    @Published var domainsTracked: Int = 8
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.badge.clock.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("CertSentry")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("8 Domains Valid")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("indiesuite.app (Expires in 84 days) • api.indiesuite.app (Expires in 34 days)")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "61-keychainquick", "name": "KeyChainQuick", "icon": "key.fill", "title": "SSH Keys",
        "gradient": "DSTheme.amberGradient", "category": "dev", "categoryName": "Developer", "hotkey": "⌥ K",
        "desc": "Fast search and copy for developer SSH keys, GPG fingerprints, and access tokens.",
        "state_vars": """
    @Published var keyCount: Int = 5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "key.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("KeyChainQuick")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌥ K")
            }
            
            Text("id_ed25519.pub • github_deploy_key • aws_s3_read_token")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "62-curlcraft", "name": "CurlCraft", "icon": "bolt.horizontal.fill", "title": "CurlCraft",
        "gradient": "DSTheme.cyanGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Convert",
        "desc": "Converts network cURL commands to Swift, Python, Node, Go, Rust code snippets instantly.",
        "state_vars": """
    @Published var targetLang: String = "Swift (URLSession)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bolt.horizontal.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("CurlCraft")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.targetLang)
                    .font(.system(size: 10))
            }
            
            Text("Paste any cURL command to generate typesafe Swift URLSession / Python requests code.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "63-sqlitelens", "name": "SqliteLens", "icon": "cylinder.split.1x2.fill", "title": "SQLite",
        "gradient": "DSTheme.primaryGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Drop .db",
        "desc": "Instant SQLite database file inspector, query runner, and table exporter.",
        "state_vars": """
    @Published var tablesCount: Int = 14
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cylinder.split.1x2.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SqliteLens")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.tablesCount) Tables")
                    .font(.system(size: 10))
            }
            
            Text("Drop any .db / .sqlite file to browse rows, run queries, and export CSVs.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "64-npmoutdated-hud", "name": "NpmOutdatedHUD", "icon": "exclamationmark.shield.fill", "title": "NPM Radar",
        "gradient": "DSTheme.roseGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "Watches package.json across local repos and alerts when dependencies have security patches.",
        "state_vars": """
    @Published var outdatedPackages: Int = 3
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("NpmOutdated HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Patches Available")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("next@15.1.0 (Security Patch) • axios@1.7.9 • tailwindcss@4.0")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "65-taillogs", "name": "TailLogs", "icon": "doc.text.fill", "title": "Logs (Live)",
        "gradient": "DSTheme.emeraldGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Tail -f",
        "desc": "Menu bar multi-file live log tailer with regex color highlighting.",
        "state_vars": """
    @Published var logLines: Int = 1420
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("TailLogs")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Tailing 3 Files")
                    .font(.system(size: 10))
            }
            
            Text("[200 OK] GET /api/v1/auth - 12ms • [500 ERR] POST /webhook - timeout")
                .font(.system(size: 9, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster G: Creative, Graphic & Design Assets
    {
        "dir": "66-mockupsnap", "name": "MockupSnap", "icon": "display", "title": "MockupSnap",
        "gradient": "DSTheme.primaryGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "1-Click",
        "desc": "1-click wraps screenshots inside realistic 3D MacBook Pro, iPhone, and iPad frames.",
        "state_vars": """
    @Published var selectedFrame: String = "MacBook Pro 16\\" Space Black"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "display")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MockupSnap")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.selectedFrame)
                    .font(.system(size: 10))
            }
            
            Text("Drop screenshot to render instant 4K marketing device frames with reflections.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "67-appiconforge", "name": "AppIconForge", "icon": "app.badge.fill", "title": "IconForge",
        "gradient": "DSTheme.amberGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "Drop PNG",
        "desc": "Drag a 1024x1024 PNG to automatically generate all iOS, macOS, watchOS, and Web icon sizes.",
        "state_vars": """
    @Published var iconsGenerated: Int = 24
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "app.badge.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AppIconForge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("24 Icons")
                    .font(.system(size: 10))
            }
            
            Text("Generates complete AppIcon.appiconset with Contents.json in 1 second.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "68-lottiepreview", "name": "LottiePreview", "icon": "play.circle.fill", "title": "Lottie (60fps)",
        "gradient": "DSTheme.cyanGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "Scrubber",
        "desc": "Native dotLottie and JSON animation player, frame scrubber, and GIF/MP4 exporter.",
        "state_vars": """
    @Published var fps: Int = 60
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "play.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("LottiePreview")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("60 FPS")
                    .font(.system(size: 10))
            }
            
            Text("Drop .lottie or .json to inspect vector animation frames and export transparent GIFs.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "69-aspectratio-calc", "name": "AspectRatioCalc", "icon": "aspectratio.fill", "title": "Ratio (16:9)",
        "gradient": "DSTheme.roseGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "Calc",
        "desc": "Instant aspect ratio, DPI, points-to-pixels, and responsive viewport sizing calculator.",
        "state_vars": """
    @Published var ratio: String = "16:9 (1920x1080)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "aspectratio.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AspectRatio Calc")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.ratio)
                    .font(.system(size: 10, design: .monospaced))
            }
            
            Text("Calculate Retina 2x/3x scaling, fluid font rem sizes, and video dimensions.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "70-shadowstudio", "name": "ShadowStudio", "icon": "shadow", "title": "Shadows",
        "gradient": "DSTheme.emeraldGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "CSS/SwiftUI",
        "desc": "Visual realistic multi-layer shadow designer with CSS box-shadow and SwiftUI code export.",
        "state_vars": """
    @Published var layers: Int = 4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shadow")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ShadowStudio")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("4-Layer Shadow")
                    .font(.system(size: 10))
            }
            
            Text("Multi-layer diffused lighting shadows with 1-click SwiftUI .shadow() export.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # Cluster H: Utility, Filesystem & Battery Care
    {
        "dir": "71-duplicatefinder", "name": "DuplicateFinder", "icon": "doc.on.doc.fill", "title": "Duplicates",
        "gradient": "DSTheme.roseGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Scan",
        "desc": "Blazing-fast hashing-based duplicate file scanner to reclaim disk space.",
        "state_vars": """
    @Published var dupesFound: Int = 38
    @Published var reclaimableMB: Double = 840.0
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.on.doc.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DuplicateFinder")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("840 MB Duplicates")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("SHA-256 binary hash detection finds duplicate photos, downloads, and videos safely.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "72-caffeinebar", "name": "CaffeineBar", "icon": "cup.and.saucer.fill", "title": "Awake (∞)",
        "gradient": "DSTheme.amberGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "1-Click",
        "desc": "Keeps Mac awake indefinitely or on a timer with custom display sleep rules.",
        "state_vars": """
    @Published var isAwake: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CaffeineBar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isAwake ? "AWAKE FOREVER ☕️" : "SYSTEM SLEEP ON")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(state.isAwake ? .green : .secondary)
            }
            
            Toggle("Prevent display and system idle sleep", isOn: $state.isAwake)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "73-hiddenfiles-toggle", "name": "HiddenFilesToggle", "icon": "eye.circle.fill", "title": "Dotfiles",
        "gradient": "DSTheme.cyanGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "⌘ ⇧ .",
        "desc": "1-click menu bar toggle to show/hide hidden dotfiles and system files in Finder.",
        "state_vars": """
    @Published var showHidden: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("HiddenFiles Toggle")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                HotkeyPill(keyCombination: "⌘ ⇧ .")
            }
            
            Toggle("Show hidden dotfiles (.git, .env, .zshrc) in Finder", isOn: $state.showHidden)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "74-archiveextractor", "name": "ArchiveExtractor", "icon": "archivebox.fill", "title": "Unarchiver",
        "gradient": "DSTheme.primaryGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Drop Zip",
        "desc": "Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO with auto-delete zip option.",
        "state_vars": """
    @Published var autoDeleteArchive: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "archivebox.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("ArchiveExtractor")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("7z • RAR • TAR")
                    .font(.system(size: 10))
            }
            
            Toggle("Auto-delete archive after successful extraction", isOn: $state.autoDeleteArchive)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "75-clipboarddiff", "name": "ClipboardDiff", "icon": "doc.text.below.ecg.fill", "title": "Clip Diff",
        "gradient": "DSTheme.emeraldGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "⌥ V",
        "desc": "Compares current clipboard with previous clipboard and shows a visual side-by-side git diff.",
        "state_vars": """
    @Published var diffLines: String = "+ let newApp = 80\\n- let oldApp = 30"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.below.ecg.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ClipboardDiff")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Diff Detected")
                    .font(.system(size: 10))
            }
            
            Text(state.diffLines)
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "76-apppermission-auditor", "name": "AppPermissionAuditor", "icon": "lock.trianglebadge.exclamationmark.fill", "title": "Permissions",
        "gradient": "DSTheme.roseGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Audit",
        "desc": "Inspects all apps granted Camera, Mic, Accessibility, Screen Recording, or Full Disk permissions.",
        "state_vars": """
    @Published var appsWithAccess: Int = 12
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.trianglebadge.exclamationmark.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AppPermission Auditor")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("TCC Audit")
                    .font(.system(size: 10))
            }
            
            Text("12 apps have screen recording or accessibility access. 1-click revoke available.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "77-wifiradar", "name": "WiFiRadar", "icon": "wifi", "title": "WiFi (5GHz)",
        "gradient": "DSTheme.cyanGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Menu Bar",
        "desc": "Displays channel congestion, signal RSSI, interference, and speed test directly in the menu bar.",
        "state_vars": """
    @Published var signalRSSI: String = "-42 dBm (Excellent)"
    @Published var speedMbps: Int = 680
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "wifi")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WiFiRadar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("\(state.speedMbps) Mbps")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Signal: \(state.signalRSSI) • Channel 149 (5GHz 80MHz)")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "78-quickshare-local", "name": "QuickShareLocal", "icon": "bonjour", "title": "QuickShare",
        "gradient": "DSTheme.primaryGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "P2P Drop",
        "desc": "AirDrop-like local network file dropper between Macs and PCs via browser URL.",
        "state_vars": """
    @Published var localUrl: String = "http://192.168.1.14:8080/share"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bonjour")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("QuickShare Local")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("P2P Web Server")
                    .font(.system(size: 9))
            }
            
            Text("Share with any device on your Wi-Fi: \(state.localUrl)")
                .font(.system(size: 10, design: .monospaced))
                .foregroundColor(.blue)
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "79-audiorecord-hud", "name": "AudioRecordHUD", "icon": "record.circle.fill", "title": "Rec Audio",
        "gradient": "DSTheme.roseGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "1-Click",
        "desc": "1-click system audio + microphone recorder with instant MP3/M4A export.",
        "state_vars": """
    @Published var isRecording: Bool = false
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "record.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("AudioRecord HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.isRecording ? "RECORDING..." : "STANDBY")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Button(action: { state.isRecording.toggle() }) {
                HStack {
                    Image(systemName: state.isRecording ? "stop.fill" : "record.circle")
                    Text(state.isRecording ? "Stop & Save MP3" : "Record Internal Audio + Mic")
                }
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(state.isRecording ? Color.red : Color.accentColor)
                .cornerRadius(6)
            }
            .buttonStyle(.plain)
"""
    },
    {
        "dir": "80-memorypurge-pro", "name": "MemoryPurgePro", "icon": "memorychip.fill", "title": "RAM (2.1GB Free)",
        "gradient": "DSTheme.emeraldGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Purge",
        "desc": "Visual RAM pressure monitor with 1-click inactive memory purge and cache optimization.",
        "state_vars": """
    @Published var memoryPressure: String = "Normal (24% Used)"
    @Published var freeRAMGB: Double = 12.4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "memorychip.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("MemoryPurge Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.memoryPressure)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Button("Purge Inactive RAM & Flush Caches") {}
                .buttonStyle(.plain)
                .font(.system(size: 11, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(DSTheme.emeraldGradient)
                .cornerRadius(6)
"""
    }
]

# Scaffold the apps
for app in new_50_apps:
    app_dir = f"apps/{app['dir']}"
    src_dir = f"{app_dir}/Sources/{app['name']}"
    os.makedirs(src_dir, exist_ok=True)
    
    # Write Package.swift
    pkg_content = f"""// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "{app['name']}",
    platforms: [.macOS(.v13)],
    products: [.executable(name: "{app['name']}", targets: ["{app['name']}"])],
    dependencies: [
        .package(path: "../../shared/DesignSystem"),
        .package(path: "../../shared/AppKitKit"),
        .package(path: "../../shared/Licensing")
    ],
    targets: [
        .executableTarget(
            name: "{app['name']}",
            dependencies: ["DesignSystem", "AppKitKit", "Licensing"],
            path: "Sources/{app['name']}"
        )
    ]
)
"""
    with open(f"{app_dir}/Package.swift", "w") as f:
        f.write(pkg_content)
        
    # Write main.swift
    main_content = f"""import SwiftUI
import AppKit
import DesignSystem
import AppKitKit
import Licensing

class {app['name']}State: ObservableObject {{
{app['state_vars']}
}}

struct {app['name']}View: View {{
    @StateObject private var state = {app['name']}State()
    @StateObject private var license = LicenseManager.shared
    
    var body: some View {{
        VStack(spacing: 12) {{
{app['body_content']}
            
            HStack {{
                Text("Indie Suite Pro • 80 Apps")
                    .font(.system(size: 9))
                    .foregroundColor(.secondary)
                Spacer()
                Button("Quit") {{
                    NSApp.terminate(nil)
                }}
                .buttonStyle(.plain)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
            }}
        }}
        .padding(14)
        .frame(width: 340, height: 360)
    }}
}}

class AppDelegate: NSObject, NSApplicationDelegate {{
    var menuBarController: MenuBarController<{app['name']}View>?
    
    func applicationDidFinishLaunching(_ notification: Notification) {{
        let contentView = {app['name']}View()
        menuBarController = MenuBarController(
            rootView: contentView,
            systemIconName: "{app['icon']}",
            titleText: "{app['title']}",
            contentWidth: 340,
            contentHeight: 360
        )
    }}
}}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
"""
    with open(f"{src_dir}/main.swift", "w") as f:
        f.write(main_content)

print(f"✅ Successfully scaffolded {len(new_50_apps)} additional apps (Apps 31 through 80)!")
