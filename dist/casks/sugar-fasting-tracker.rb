cask "sugar-fasting-tracker" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/sugar-fasting-tracker-1.0.0.dmg"
  name "Sugar-fasting-tracker"
  desc "Visual intermittent fasting timer with ketosis stage alerts"
  homepage "https://indiesuite.app/apps/sugar-fasting-tracker"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Sugar-fasting-tracker.app"

  zap trash: [
    "~/Library/Application Support/sugar-fasting-tracker",
    "~/Library/Preferences/com.indiesuite.sugar-fasting-tracker.plist",
  ]
end
