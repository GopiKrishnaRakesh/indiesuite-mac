cask "micmute-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/micmute-hud-1.0.0.dmg"
  name "Micmute-hud"
  desc "Universal hardware mic mute & camera blackout indicator"
  homepage "https://indiesuite.app/apps/micmute-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Micmute-hud.app"

  zap trash: [
    "~/Library/Application Support/micmute-hud",
    "~/Library/Preferences/com.indiesuite.micmute-hud.plist",
  ]
end
