cask "standup-timer" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/standup-timer-1.0.0.dmg"
  name "Standup-timer"
  desc "Standing desk timer with smart Bluetooth desk sync"
  homepage "https://indiesuite.app/apps/standup-timer"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Standup-timer.app"

  zap trash: [
    "~/Library/Application Support/standup-timer",
    "~/Library/Preferences/com.indiesuite.standup-timer.plist",
  ]
end
