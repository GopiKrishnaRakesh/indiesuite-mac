cask "waterdrop-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/waterdrop-hud-1.0.0.dmg"
  name "Waterdrop-hud"
  desc "Smart hydration tracker with 1-click logging and reminders"
  homepage "https://indiesuite.app/apps/waterdrop-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Waterdrop-hud.app"

  zap trash: [
    "~/Library/Application Support/waterdrop-hud",
    "~/Library/Preferences/com.indiesuite.waterdrop-hud.plist",
  ]
end
