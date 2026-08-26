cask "pomodorodragon" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/pomodorodragon-1.0.0.dmg"
  name "Pomodorodragon"
  desc "RPG Pomodoro egg that hatches elemental dragons"
  homepage "https://indiesuite.app/apps/pomodorodragon"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Pomodorodragon.app"

  zap trash: [
    "~/Library/Application Support/pomodorodragon",
    "~/Library/Preferences/com.indiesuite.pomodorodragon.plist",
  ]
end
