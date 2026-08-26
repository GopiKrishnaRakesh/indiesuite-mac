cask "teleprompter-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/teleprompter-hud-1.0.0.dmg"
  name "Teleprompter-hud"
  desc "Translucent scrolling teleprompter for presentations and video"
  homepage "https://indiesuite.app/apps/teleprompter-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Teleprompter-hud.app"

  zap trash: [
    "~/Library/Application Support/teleprompter-hud",
    "~/Library/Preferences/com.indiesuite.teleprompter-hud.plist",
  ]
end
