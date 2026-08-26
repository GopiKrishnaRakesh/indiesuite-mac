cask "emojiforge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/emojiforge-1.0.0.dmg"
  name "Emojiforge"
  desc "Floating emoji picker with Slack/Discord custom emoji resizer"
  homepage "https://indiesuite.app/apps/emojiforge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Emojiforge.app"

  zap trash: [
    "~/Library/Application Support/emojiforge",
    "~/Library/Preferences/com.indiesuite.emojiforge.plist",
  ]
end
