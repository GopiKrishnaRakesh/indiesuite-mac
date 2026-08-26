cask "readaloud-tts" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/readaloud-tts-1.0.0.dmg"
  name "Readaloud-tts"
  desc "Ultra-natural offline text-to-speech voice reader for articles"
  homepage "https://indiesuite.app/apps/readaloud-tts"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Readaloud-tts.app"

  zap trash: [
    "~/Library/Application Support/readaloud-tts",
    "~/Library/Preferences/com.indiesuite.readaloud-tts.plist",
  ]
end
