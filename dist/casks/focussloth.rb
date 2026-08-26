cask "focussloth" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/focussloth-1.0.0.dmg"
  name "Focussloth"
  desc "Animated sloth climbing a branch in the notch during focus time"
  homepage "https://indiesuite.app/apps/focussloth"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Focussloth.app"

  zap trash: [
    "~/Library/Application Support/focussloth",
    "~/Library/Preferences/com.indiesuite.focussloth.plist",
  ]
end
