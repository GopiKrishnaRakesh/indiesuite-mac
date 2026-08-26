cask "microjournal-bar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/microjournal-bar-1.0.0.dmg"
  name "Microjournal-bar"
  desc "1-line micro-journaling in the menu bar to log quick thoughts"
  homepage "https://indiesuite.app/apps/microjournal-bar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Microjournal-bar.app"

  zap trash: [
    "~/Library/Application Support/microjournal-bar",
    "~/Library/Preferences/com.indiesuite.microjournal-bar.plist",
  ]
end
