cask "timebridge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/timebridge-1.0.0.dmg"
  name "Timebridge"
  desc "Visual timezone slider and meeting overlap calculator"
  homepage "https://indiesuite.app/apps/timebridge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Timebridge.app"

  zap trash: [
    "~/Library/Application Support/timebridge",
    "~/Library/Preferences/com.indiesuite.timebridge.plist",
  ]
end
