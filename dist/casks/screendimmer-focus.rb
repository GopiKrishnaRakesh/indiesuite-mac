cask "screendimmer-focus" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/screendimmer-focus-1.0.0.dmg"
  name "Screendimmer-focus"
  desc "Spotlights active window and dims background displays"
  homepage "https://indiesuite.app/apps/screendimmer-focus"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Screendimmer-focus.app"

  zap trash: [
    "~/Library/Application Support/screendimmer-focus",
    "~/Library/Preferences/com.indiesuite.screendimmer-focus.plist",
  ]
end
