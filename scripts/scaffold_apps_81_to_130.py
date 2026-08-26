#!/usr/bin/env python3
import os

apps_81_to_130 = [
    # 🐾 1. Interactive Desktop Companions (Apps 81–87)
    {
        "dir": "81-pixelhamster-desktop", "name": "PixelHamsterDesktop", "icon": "circle.circle.fill", "title": "Hamster (Running)",
        "gradient": "DSTheme.amberGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Menu Bar",
        "desc": "Animated pixel hamster running on a wheel in your menu bar, speeding up with typing and commits.",
        "state_vars": """
    @Published var wheelSpeedRpm: Int = 120
    @Published var totalDistanceKm: Double = 4.2
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "circle.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("PixelHamster Desktop")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐹 120 RPM")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Runs faster as your typing speed and compilation activity increases.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "82-cybergochi", "name": "CyberGochi", "icon": "gamecontroller.fill", "title": "Gochi (Lv. 3)",
        "gradient": "DSTheme.primaryGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Menu Bar",
        "desc": "Retro Tamagotchi virtual pet that eats completed to-do items and evolves through productivity streaks.",
        "state_vars": """
    @Published var gochiLevel: Int = 3
    @Published var hunger: Int = 80
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "gamecontroller.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CyberGochi")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("👾 Cyber Pet")
            }
            
            Text("Check off tasks in Reminders or Linear to feed and evolve your CyberGochi.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "83-deskduck", "name": "DeskDuck", "icon": "questionmark.bubble.fill", "title": "DeskDuck",
        "gradient": "DSTheme.amberGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "⌥ D",
        "desc": "Floating rubber duck debugger that asks Socratic prompts when you're stuck coding or writing.",
        "state_vars": """
    @Published var socraticPrompt: String = "What did you expect the code to do versus what actually happened?"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "questionmark.bubble.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DeskDuck")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦆 Quack!")
            }
            
            Text(state.socraticPrompt)
                .font(.system(size: 11, weight: .semibold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "84-plantnursery-hud", "name": "PlantNurseryHUD", "icon": "leaf.circle.fill", "title": "Nursery (5 Plants)",
        "gradient": "DSTheme.emeraldGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "HUD",
        "desc": "Virtual greenhouse where rare succulents grow based on your hydration and focus check-ins.",
        "state_vars": """
    @Published var plantsGrown: Int = 5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "leaf.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("PlantNursery HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🌵 5 Succulents")
            }
            
            Text("Complete hydration and focus intervals to unlock exotic virtual desert flora.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "85-focussloth", "name": "FocusSloth", "icon": "figure.walk", "title": "Sloth (Notch)",
        "gradient": "DSTheme.roseGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Notch",
        "desc": "Animated sloth climbing a branch in the notch during continuous deep focus time.",
        "state_vars": """
    @Published var branchProgress: Int = 75
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.walk")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("FocusSloth")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦥 75% Climbed")
            }
            
            Text("The sloth climbs higher along your MacBook notch the longer you avoid tab switching.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "86-zenpanda", "name": "ZenPanda", "icon": "heart.circle.fill", "title": "ZenPanda",
        "gradient": "DSTheme.cyanGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Breathe",
        "desc": "Meditating panda companion guiding 60-second box-breathing exercises between meetings.",
        "state_vars": """
    @Published var breatheState: String = "Inhale (4s)..."
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "heart.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("ZenPanda")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🐼 Zen Mode")
            }
            
            Text(state.breatheState)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(.cyan)
                .padding(10)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "87-codeotter", "name": "CodeOtter", "icon": "water.waves", "title": "CodeOtter",
        "gradient": "DSTheme.primaryGradient", "category": "pets", "categoryName": "Pets & Habits", "hotkey": "Window Edge",
        "desc": "Playful otter swimming along window edges, catching fish on successful test runs.",
        "state_vars": """
    @Published var fishCaught: Int = 18
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "water.waves")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("CodeOtter")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("🦦 18 Fish")
            }
            
            Text("Otter companion celebrates when unit tests pass with celebratory swimming flips.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 🧘 2. Deep Focus & Brainwaves (Apps 88–94)
    {
        "dir": "88-brainwave-sync", "name": "BrainWaveSync", "icon": "waveform.path.ecg", "title": "40Hz Gamma",
        "gradient": "DSTheme.cyanGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Audio",
        "desc": "Binaural 40Hz Gamma and Alpha wave generator for memory consolidation and hyper-focus.",
        "state_vars": """
    @Published var frequency: String = "40Hz Gamma (Hyper-Focus)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BrainWave Sync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("40Hz Active")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.cyan)
            }
            
            Text("Scientific binaural beats proven to synchronize neural oscillations during deep problem solving.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "89-singletask-spotlight", "name": "SingleTaskSpotlight", "icon": "target", "title": "SingleTask",
        "gradient": "DSTheme.roseGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "⌥ S",
        "desc": "Forces 1 single active window, completely hiding dock and menu bar until current task is checked off.",
        "state_vars": """
    @Published var isHardLockActive: Bool = true
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "target")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("SingleTask Spotlight")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("LOCKED")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.red)
            }
            
            Text("Eliminates context-switching by hiding every other application until your timer expires.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "90-antiprocrastinate-friction", "name": "AntiProcrastinateFriction", "icon": "hourglass", "title": "Friction Gate",
        "gradient": "DSTheme.amberGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Auto",
        "desc": "Adds a 10-second deliberate breathing countdown before opening selected addictive URLs/apps.",
        "state_vars": """
    @Published var frictionSeconds: Int = 10
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "hourglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AntiProcrastinate Friction")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("10s Delay")
            }
            
            Text("Forces mindful pauses before social media tabs load, breaking subconscious dopamine loops.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "91-whitenoise-mixer", "name": "WhiteNoiseMixer", "icon": "slider.vertical.3", "title": "Noise Mixer",
        "gradient": "DSTheme.emeraldGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Audio",
        "desc": "Multi-track customizable soundscape mixer (Rain + Campfire + Ocean Waves + Wind Chimes).",
        "state_vars": """
    @Published var rainVol: Double = 0.8
    @Published var fireVol: Double = 0.4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "slider.vertical.3")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("WhiteNoise Mixer")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("4 Channels")
            }
            
            Text("Mix realistic ambient field recordings for deep coding and quiet environments.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "92-tablimiter-pro", "name": "TabLimiterPro", "icon": "square.stack.3d.down.right.fill", "title": "Tabs (Max 5)",
        "gradient": "DSTheme.primaryGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Safari/Chrome",
        "desc": "Restricts open tabs to max 5 per window, auto-archiving overflowing tabs to a reading list.",
        "state_vars": """
    @Published var maxTabsAllowed: Int = 5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.stack.3d.down.right.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("TabLimiter Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Max 5 Tabs")
            }
            
            Text("Maintains cognitive clarity by preventing 50+ tab hoarding in Safari and Chrome.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "93-eyeblink-coach", "name": "EyeBlinkCoach", "icon": "eye.circle", "title": "Blink Nudge",
        "gradient": "DSTheme.cyanGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Subtle Pulse",
        "desc": "Subtly flashes a soft screen border halo every 15 seconds to remind power users to blink.",
        "state_vars": """
    @Published var blinkIntervalSecs: Int = 15
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "eye.circle")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("EyeBlink Coach")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Every 15s")
            }
            
            Text("Prevents dry eyes and screen fatigue during intense programming and writing sessions.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "94-focusheatmap", "name": "FocusHeatmap", "icon": "flame.fill", "title": "Heatmap",
        "gradient": "DSTheme.roseGradient", "category": "focus", "categoryName": "Focus & Flow", "hotkey": "Overlay",
        "desc": "Live visual heatmap overlay showing which apps and windows consumed your attention today.",
        "state_vars": """
    @Published var topApp: String = "Xcode (4.2 hrs)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("FocusHeatmap")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.topApp)
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Visual breakdown of keyboard and mouse activity across development, browser, and chat apps.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 📅 3. Daily Routine & Wellness (Apps 95–101)
    {
        "dir": "95-morningkickoff-hud", "name": "MorningKickoffHUD", "icon": "sunrise.fill", "title": "Morning Kickoff",
        "gradient": "DSTheme.amberGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "9:00 AM",
        "desc": "3-minute morning launchpad popup showing today's top 3 MITs, calendar, and weather overview.",
        "state_vars": """
    @Published var topTask1: String = "Ship 50 new apps update"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "sunrise.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("MorningKickoff HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Daily Launchpad")
            }
            
            Text("Top MIT: \(state.topTask1)")
                .font(.system(size: 11, weight: .bold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "96-microjournal-bar", "name": "MicroJournalBar", "icon": "square.and.pencil", "title": "Journal",
        "gradient": "DSTheme.primaryGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Menu Bar",
        "desc": "1-line micro-journaling in the menu bar to log quick thoughts, gratitude, and wins.",
        "state_vars": """
    @Published var todayEntry: String = "Shipped 130 native macOS apps suite! Feeling great."
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("MicroJournal Bar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1-Line Log")
            }
            
            Text(state.todayEntry)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "97-sugar-fasting-tracker", "name": "SugarFastingTracker", "icon": "timer", "title": "Fasting (14h)",
        "gradient": "DSTheme.emeraldGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Status Bar",
        "desc": "Visual intermittent fasting timer in status bar with ketosis stage and metabolic alerts.",
        "state_vars": """
    @Published var fastingHours: Double = 14.5
    @Published var targetHours: Double = 16.0
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "timer")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("Sugar & Fasting Tracker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Ketosis Stage")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("14.5 hrs / 16 hrs completed (Autophagy stage activated).")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "98-sleephygiene-nudge", "name": "SleepHygieneNudge", "icon": "moon.stars.fill", "title": "Bedtime (11 PM)",
        "gradient": "DSTheme.primaryGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Night Shift",
        "desc": "Automatically warms screen temperature and locks distraction apps 1 hour before scheduled bedtime.",
        "state_vars": """
    @Published var bedtimeHour: String = "11:00 PM"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "moon.stars.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("SleepHygiene Nudge")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Warm Filter Active")
            }
            
            Text("Warms color temperature to 2400K and enforces screen wind-down 60m before bed.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "99-meetingprep-countdown", "name": "MeetingPrepCountdown", "icon": "bell.badge.fill", "title": "Meeting (2m)",
        "gradient": "DSTheme.roseGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Pre-Alarm",
        "desc": "Popover chime 2 minutes before Google Meet/Zoom calls with direct 1-click join link.",
        "state_vars": """
    @Published var upcomingCall: String = "Design Review @ 3:00 PM"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bell.badge.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("MeetingPrep Countdown")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("2m Warning")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Next: \(state.upcomingCall) (1-click auto join)")
                .font(.system(size: 11, weight: .semibold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "100-stepcounter-sync", "name": "StepCounterSync", "icon": "figure.walk.motion", "title": "7,420 Steps",
        "gradient": "DSTheme.emeraldGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Health Sync",
        "desc": "Apple Watch / Health synced step counter progress bar right in the menu bar.",
        "state_vars": """
    @Published var steps: Int = 7420
    @Published var goal: Int = 10000
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "figure.walk.motion")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("StepCounter Sync")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("74% Goal")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("7,420 / 10,000 daily steps completed from Apple Health.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "101-caffeinedecay-curve", "name": "CaffeineDecayCurve", "icon": "cup.and.saucer.fill", "title": "Caffeine (85mg)",
        "gradient": "DSTheme.amberGradient", "category": "routine", "categoryName": "Routine & Wellness", "hotkey": "Decay Model",
        "desc": "Calculates and plots active caffeine in bloodstream with sleep cutoff time warnings.",
        "state_vars": """
    @Published var activeMg: Int = 85
    @Published var cutoffHour: String = "2:00 PM"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cup.and.saucer.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("CaffeineDecay Curve")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("85mg Active")
            }
            
            Text("Based on 5.5hr half-life, caffeine will drop below sleep threshold by 10:30 PM.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 💬 4. Social & Creator Workflow (Apps 102–108)
    {
        "dir": "102-cliptomarkdown-thread", "name": "ClipToMarkdownThread", "icon": "doc.text.fill", "title": "ClipToMD",
        "gradient": "DSTheme.cyanGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "1-Click",
        "desc": "Converts X, Reddit, and LinkedIn posts into clean Obsidian/Notion markdown.",
        "state_vars": """
    @Published var formattedMD: String = "## Thread Summary\\n- Key takeaway 1\\n- Code snippet"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.text.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("ClipToMarkdown Thread")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Obsidian Ready")
            }
            
            Text("Formats social threads into clean markdown notes with author citations and links.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "103-podcastchapter-marker", "name": "PodcastChapterMarker", "icon": "waveform.and.magnifyingglass", "title": "Chapters",
        "gradient": "DSTheme.primaryGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "ID3 Tags",
        "desc": "Audio waveform scrubber to drop timestamped chapter markers and export ID3 tags.",
        "state_vars": """
    @Published var chapterCount: Int = 8
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "waveform.and.magnifyingglass")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("PodcastChapter Marker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("8 Chapters")
            }
            
            Text("00:00 Intro • 04:20 Architecture • 12:40 Live Demo • 22:10 Q&A")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "104-teleprompter-hud", "name": "TeleprompterHUD", "icon": "text.quote", "title": "Prompter",
        "gradient": "DSTheme.emeraldGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Transparent",
        "desc": "Translucent scrolling teleprompter for presentations and recorded video.",
        "state_vars": """
    @Published var scrollSpeed: Double = 1.2
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "text.quote")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("Teleprompter HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1.2x Speed")
            }
            
            Text("Place near webcam for natural eye contact during remote presentations and recordings.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "105-quickpoll-creator", "name": "QuickPollCreator", "icon": "chart.bar.fill", "title": "Poll Creator",
        "gradient": "DSTheme.amberGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "HUD",
        "desc": "Generates formatted poll layouts for Twitter, LinkedIn, and Slack with 1-click copy.",
        "state_vars": """
    @Published var question: String = "What is your favorite macOS utility category?"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("QuickPoll Creator")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Multi-Platform")
            }
            
            Text("1. Developer Tools • 2. Desktop Pets • 3. Focus & Flow • 4. Local AI")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "106-videothumbnail-tester", "name": "VideoThumbnailTester", "icon": "photo.fill", "title": "Thumbnail Test",
        "gradient": "DSTheme.roseGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Preview",
        "desc": "Previews YouTube and Twitter thumbnails on light/dark mode social feed mocks.",
        "state_vars": """
    @Published var ctrPrediction: String = "12.4% (High Contrast)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "photo.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("VideoThumbnail Tester")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.ctrPrediction)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Simulates YouTube homepage and mobile feed appearance before uploading.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "107-discordrole-autoping", "name": "DiscordRoleAutoPing", "icon": "bubble.left.fill", "title": "Discord Helper",
        "gradient": "DSTheme.primaryGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Embed",
        "desc": "Quick organizer for Discord markdown formatting, roles, and embed payloads.",
        "state_vars": """
    @Published var embedTitle: String = "🚀 Major Suite Release v2.0"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DiscordRole AutoPing")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Rich Embed")
            }
            
            Text("Generates formatted JSON payloads for webhooks and community announcements.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "108-watermarkmaster", "name": "WatermarkMaster", "icon": "signature", "title": "Watermark",
        "gradient": "DSTheme.cyanGradient", "category": "social", "categoryName": "Social & Creator", "hotkey": "Batch",
        "desc": "Applies customizable dynamic logos and watermarks to batches of images.",
        "state_vars": """
    @Published var opacity: Double = 0.5
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "signature")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("WatermarkMaster")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Batch Stamp")
            }
            
            Text("Drop image folder to stamp dynamic copyright, logo, or transparent signature.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 🧠 5. Local AI & Speech (Apps 109–115)
    {
        "dir": "109-whispersubtitles-srt", "name": "WhisperSubtitlesSRT", "icon": "captions.bubble.fill", "title": "SRT Maker",
        "gradient": "DSTheme.primaryGradient", "category": "ai", "categoryName": "AI & Voice", "hotkey": "WhisperKit",
        "desc": "Generates timestamped .srt and .vtt subtitles locally via WhisperKit in seconds.",
        "state_vars": """
    @Published var subtitleFormat: String = "SubRip (.srt) + WebVTT (.vtt)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "captions.bubble.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("WhisperSubtitles SRT")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("100% Offline")
            }
            
            Text("Drop any .mp4 or .mov video to generate accurate subtitle tracks with zero cloud delay.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "110-summarizeurl-ai", "name": "SummarizeURLAI", "icon": "doc.plaintext.fill", "title": "Summary AI",
        "gradient": "DSTheme.emeraldGradient", "category": "ai", "categoryName": "AI & Voice", "hotkey": "⌥ U",
        "desc": "Offline webpage and article summarizer with 3 bullet takeaways.",
        "state_vars": """
    @Published var takeaways: String = "1. Native architecture • 2. Zero tax • 3. 130 apps"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.plaintext.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("SummarizeURL AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Takeaways")
            }
            
            Text(state.takeaways)
                .font(.system(size: 11))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "111-sqlquery-ai", "name": "SqlQueryAI", "icon": "server.rack", "title": "SQL AI",
        "gradient": "DSTheme.cyanGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "Natural Lang",
        "desc": "Translates plain English requests into optimized SQL queries.",
        "state_vars": """
    @Published var query: String = "SELECT * FROM apps WHERE downloads > 1000 ORDER BY rating DESC;"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("SqlQuery AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("SQL Ready")
            }
            
            Text(state.query)
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "112-localembeddings-search", "name": "LocalEmbeddingsSearch", "icon": "magnifyingglass.circle.fill", "title": "Vector Search",
        "gradient": "DSTheme.primaryGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "Semantic",
        "desc": "Semantic vector search across local folders using local CoreML embeddings.",
        "state_vars": """
    @Published var indexedDocs: Int = 1420
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("LocalEmbeddings Search")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1,420 Vectors")
            }
            
            Text("Find code snippets and markdown notes by concept meaning rather than exact keywords.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "113-diffexplainer-ai", "name": "DiffExplainerAI", "icon": "list.bullet.rectangle.portrait.fill", "title": "Diff AI",
        "gradient": "DSTheme.amberGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "Changelog",
        "desc": "Analyzes git diffs to generate clean release notes and changelogs.",
        "state_vars": """
    @Published var releaseNote: String = "- Added 50 new apps (Suite now total 130 apps)\\n- Optimized build pipeline"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "list.bullet.rectangle.portrait.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("DiffExplainer AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Changelog")
            }
            
            Text(state.releaseNote)
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "114-readaloud-tts", "name": "ReadAloudTTS", "icon": "speaker.wave.3.fill", "title": "Neural TTS",
        "gradient": "DSTheme.roseGradient", "category": "ai", "categoryName": "AI & Voice", "hotkey": "Speech",
        "desc": "Ultra-natural text-to-speech voice reader for selected articles and code comments.",
        "state_vars": """
    @Published var voice: String = "Neural Samantha (Natural HD)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("ReadAloud TTS")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.voice)
                    .font(.system(size: 9))
            }
            
            Text("Listen to articles and documentation hands-free with high-definition offline voice synthesis.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "115-regexgenerator-ai", "name": "RegexGeneratorAI", "icon": "character.cursor.ibeam", "title": "Regex AI",
        "gradient": "DSTheme.cyanGradient", "category": "ai", "categoryName": "AI & Dev", "hotkey": "AI Gen",
        "desc": "Converts plain English descriptions into tested, production-ready regular expressions.",
        "state_vars": """
    @Published var generatedRegex: String = "^[A-Z]{2}[0-9]{4}[a-z]?$"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "character.cursor.ibeam")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("RegexGenerator AI")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Tested ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("Regex: \(state.generatedRegex)")
                .font(.system(size: 11, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 💻 6. Developer & DevOps Tools (Apps 116–123)
    {
        "dir": "116-kubecluster-quick", "name": "KubeClusterQuick", "icon": "shippingbox.circle.fill", "title": "K8s (6 Pods)",
        "gradient": "DSTheme.primaryGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "Minimalist Kubernetes cluster status watcher with 1-click pod log viewing.",
        "state_vars": """
    @Published var podCount: Int = 6
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("KubeCluster Quick")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("6 Pods Healthy")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("ingress-controller • auth-service • api-deployment • redis-master")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "117-redislens", "name": "RedisLens", "icon": "cylinder.fill", "title": "Redis (6379)",
        "gradient": "DSTheme.roseGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Menu Bar",
        "desc": "Menu bar Redis key-value browser, TTL inspector, and memory analyzer.",
        "state_vars": """
    @Published var keyCount: Int = 240
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "cylinder.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("RedisLens")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("240 Keys")
            }
            
            Text("session:user_8912 (TTL: 3400s) • cache:homepage (TTL: 120s)")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "118-gitstash-manager", "name": "GitStashManager", "icon": "tray.2.fill", "title": "Git Stash",
        "gradient": "DSTheme.amberGradient", "category": "dev", "categoryName": "Developer", "hotkey": "⌥ S",
        "desc": "Visual UI for viewing, comparing, applying, and dropping local git stashes.",
        "state_vars": """
    @Published var stashCount: Int = 3
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "tray.2.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("GitStash Manager")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3 Stashes")
            }
            
            Text("stash@{0}: WIP on website storefront catalog • stash@{1}: test fixtures")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "119-portforwarder-pro", "name": "PortForwarderPro", "icon": "arrow.triangle.swap", "title": "SSH Tunnel",
        "gradient": "DSTheme.cyanGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Tunnel",
        "desc": "SSH tunnel and local port forwarding manager with auto-reconnect.",
        "state_vars": """
    @Published var activeTunnel: String = "localhost:5433 -> prod-db:5432"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.triangle.swap")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("PortForwarder Pro")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Connected ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text(state.activeTunnel)
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "120-apimock-server", "name": "ApiMockServer", "icon": "server.rack", "title": "Mock Server",
        "gradient": "DSTheme.emeraldGradient", "category": "dev", "categoryName": "Developer", "hotkey": ":4000",
        "desc": "1-click local mock HTTP server with custom latency and status simulation.",
        "state_vars": """
    @Published var mockEndpoint: String = "http://localhost:4000/api/users"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "server.rack")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ApiMock Server")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Listening :4000")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Simulate 200 OK, 401 Unauthorized, 500 Server Error with 200ms latency.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "121-dotenv-diff", "name": "DotEnvDiff", "icon": "doc.badge.ellipsis", "title": ".env Diff",
        "gradient": "DSTheme.primaryGradient", "category": "dev", "categoryName": "Developer", "hotkey": "Verify",
        "desc": "Compares .env.example against actual .env and flags missing keys before push.",
        "state_vars": """
    @Published var missingKeys: [String] = ["STRIPE_WEBHOOK_SECRET"]
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "doc.badge.ellipsis")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("DotEnv Diff")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("1 Missing Key")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("Missing in .env: STRIPE_WEBHOOK_SECRET (required by .env.example)")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "122-dnslookup-hud", "name": "DnsLookupHUD", "icon": "globe.americas.fill", "title": "DNS Lookup",
        "gradient": "DSTheme.cyanGradient", "category": "dev", "categoryName": "Developer", "hotkey": "DNS",
        "desc": "Instant DNS record inspector (A, CNAME, MX, TXT) with global node propagation test.",
        "state_vars": """
    @Published var ipAddress: String = "76.76.21.21 (Vercel Anycast)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "globe.americas.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("DnsLookup HUD")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Global Propagated")
                    .font(.system(size: 9))
                    .foregroundColor(.green)
            }
            
            Text("indiesuite.app -> A Record: 76.76.21.21 • TTL: 300s")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "123-httpheader-inspector", "name": "HttpHeaderInspector", "icon": "shield.checkered", "title": "HTTP Headers",
        "gradient": "DSTheme.roseGradient", "category": "dev", "categoryName": "Developer", "hotkey": "CORS/SSL",
        "desc": "Tests HTTP/HTTPS response headers, CORS policies, and SSL handshakes.",
        "state_vars": """
    @Published var corsStatus: String = "Access-Control-Allow-Origin: *"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shield.checkered")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("HttpHeader Inspector")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("TLS 1.3")
                    .font(.system(size: 10, weight: .bold))
            }
            
            Text("Strict-Transport-Security • X-Content-Type-Options: nosniff")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # 🎨 7. Design & Graphics Utilities (Apps 124–126)
    {
        "dir": "124-icongrid-overlay", "name": "IconGridOverlay", "icon": "square.grid.3x3.fill", "title": "Icon Grid",
        "gradient": "DSTheme.primaryGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "Grid",
        "desc": "Pixel-perfect icon grid overlay for designing 512x512 and 1024x1024 app icons.",
        "state_vars": """
    @Published var gridType: String = "macOS Squircle (1024x1024)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.primaryGradient)
                    Text("IconGrid Overlay")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text(state.gridType)
                    .font(.system(size: 9))
            }
            
            Text("Superimposes official Apple HIG squircle curvature and safe zone padding.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "125-contrastpalette-studio", "name": "ContrastPaletteStudio", "icon": "paintpalette.fill", "title": "WCAG Studio",
        "gradient": "DSTheme.emeraldGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "WCAG AAA",
        "desc": "Creates accessible, harmonious color systems meeting WCAG AAA requirements.",
        "state_vars": """
    @Published var contrastRating: String = "7.4:1 (WCAG AAA Compliant)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "paintpalette.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("ContrastPalette Studio")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("AAA Pass ✓")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text(state.contrastRating)
                .font(.system(size: 11, weight: .bold))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "126-gradientmesh-maker", "name": "GradientMeshMaker", "icon": "circle.hexagongrid.fill", "title": "Mesh Maker",
        "gradient": "DSTheme.cyanGradient", "category": "media", "categoryName": "Creative & Design", "hotkey": "Mesh",
        "desc": "Visual multi-point gradient mesh generator with real-time SwiftUI curve export.",
        "state_vars": """
    @Published var pointCount: Int = 9
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "circle.hexagongrid.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("GradientMesh Maker")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("3x3 Mesh")
            }
            
            Text("Interactive color anchor drag to generate complex organic fluid gradients.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    # ⚙️ 8. System & Privacy Telemetry (Apps 127–130)
    {
        "dir": "127-diskscleaner-mini", "name": "DisksCleanerMini", "icon": "internaldrive.fill", "title": "Disk (42GB Free)",
        "gradient": "DSTheme.roseGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Scan",
        "desc": "Visualizes large downloads, node_modules, and cache folders for selective 1-click purge.",
        "state_vars": """
    @Published var reclaimableGB: Double = 18.4
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "internaldrive.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.roseGradient)
                    Text("DisksCleaner Mini")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("18.4 GB Cleanable")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Text("node_modules (8.2 GB) • Xcode DerivedData (6.4 GB) • Old DMGs (3.8 GB)")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "128-bluetoothsignal-radar", "name": "BluetoothSignalRadar", "icon": "antenna.radiowaves.left.and.right.circle.fill", "title": "AirPods (-38dBm)",
        "gradient": "DSTheme.cyanGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "RSSI",
        "desc": "Signal strength (RSSI) monitor for AirPods and mice with disconnect alerts.",
        "state_vars": """
    @Published var airpodsRssi: String = "-38 dBm (Strong)"
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "antenna.radiowaves.left.and.right.circle.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.cyanGradient)
                    Text("BluetoothSignal Radar")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Strong Signal")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("AirPods Pro: -38 dBm • Magic Keyboard: -44 dBm • Magic Mouse: -48 dBm")
                .font(.system(size: 10, design: .monospaced))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "129-batterycycle-telemetry", "name": "BatteryCycleTelemetry", "icon": "chart.xyaxis.line", "title": "Battery (97%)",
        "gradient": "DSTheme.emeraldGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "SMC",
        "desc": "Deep SMC battery analytics: degradation curve, wattage telemetry, and cycles.",
        "state_vars": """
    @Published var cycles: Int = 142
    @Published var maxCapacity: Int = 97
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.emeraldGradient)
                    Text("BatteryCycle Telemetry")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("97% Max Capacity")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.green)
            }
            
            Text("142 cycles over 14 months • 0.2% monthly degradation rate (Optimal)")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    },
    {
        "dir": "130-appquarantine-inspector", "name": "AppQuarantineInspector", "icon": "lock.open.shield.fill", "title": "Quarantine",
        "gradient": "DSTheme.amberGradient", "category": "system", "categoryName": "Utilities & System", "hotkey": "Gatekeeper",
        "desc": "Lists quarantine attributes (com.apple.quarantine) with 1-click override.",
        "state_vars": """
    @Published var quarantinedApps: Int = 2
""",
        "body_content": """
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "lock.open.shield.fill")
                        .font(.system(size: 18))
                        .foregroundStyle(DSTheme.amberGradient)
                    Text("AppQuarantine Inspector")
                        .font(.system(size: 15, weight: .bold))
                }
                Spacer()
                Text("Gatekeeper Tool")
            }
            
            Text("1-click clear xattr -d com.apple.quarantine for unsigned developer test builds.")
                .font(.system(size: 10))
                .padding(8)
                .glassCard(cornerRadius: 8)
"""
    }
]

# Scaffold the apps
for app in apps_81_to_130:
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
                Text("Indie Suite Pro • 130 Apps")
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

print(f"✅ Successfully scaffolded {len(apps_81_to_130)} additional apps (Apps 81 through 130)!")
