cask "sleephygiene-nudge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/sleephygiene-nudge-1.0.0.dmg"
  name "Sleephygiene-nudge"
  desc "Automatically warms screen warmth and locks distraction apps"
  homepage "https://indiesuite.app/apps/sleephygiene-nudge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Sleephygiene-nudge.app"

  zap trash: [
    "~/Library/Application Support/sleephygiene-nudge",
    "~/Library/Preferences/com.indiesuite.sleephygiene-nudge.plist",
  ]
end
