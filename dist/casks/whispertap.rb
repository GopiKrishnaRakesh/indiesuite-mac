cask "whispertap" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/whispertap-1.0.0.dmg"
  name "Whispertap"
  desc "Global Push-to-Talk AI Dictation into any text field"
  homepage "https://indiesuite.app/apps/whispertap"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Whispertap.app"

  zap trash: [
    "~/Library/Application Support/whispertap",
    "~/Library/Preferences/com.indiesuite.whispertap.plist",
  ]
end
