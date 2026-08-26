cask "morningkickoff-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/morningkickoff-hud-1.0.0.dmg"
  name "Morningkickoff-hud"
  desc "3-minute morning launchpad popup showing MITs and weather"
  homepage "https://indiesuite.app/apps/morningkickoff-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Morningkickoff-hud.app"

  zap trash: [
    "~/Library/Application Support/morningkickoff-hud",
    "~/Library/Preferences/com.indiesuite.morningkickoff-hud.plist",
  ]
end
