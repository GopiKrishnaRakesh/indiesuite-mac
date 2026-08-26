cask "scratchpad-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/scratchpad-hud-1.0.0.dmg"
  name "Scratchpad-hud"
  desc "Always-on-top markdown floating scratchpad"
  homepage "https://indiesuite.app/apps/scratchpad-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Scratchpad-hud.app"

  zap trash: [
    "~/Library/Application Support/scratchpad-hud",
    "~/Library/Preferences/com.indiesuite.scratchpad-hud.plist",
  ]
end
