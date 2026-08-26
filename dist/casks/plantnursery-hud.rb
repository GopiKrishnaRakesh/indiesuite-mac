cask "plantnursery-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/plantnursery-hud-1.0.0.dmg"
  name "Plantnursery-hud"
  desc "Virtual greenhouse where rare succulents grow with focus"
  homepage "https://indiesuite.app/apps/plantnursery-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Plantnursery-hud.app"

  zap trash: [
    "~/Library/Application Support/plantnursery-hud",
    "~/Library/Preferences/com.indiesuite.plantnursery-hud.plist",
  ]
end
