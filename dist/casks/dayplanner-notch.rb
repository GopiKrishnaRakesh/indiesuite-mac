cask "dayplanner-notch" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/dayplanner-notch-1.0.0.dmg"
  name "Dayplanner-notch"
  desc "Visual timeline of calendar events in the MacBook notch"
  homepage "https://indiesuite.app/apps/dayplanner-notch"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Dayplanner-notch.app"

  zap trash: [
    "~/Library/Application Support/dayplanner-notch",
    "~/Library/Preferences/com.indiesuite.dayplanner-notch.plist",
  ]
end
