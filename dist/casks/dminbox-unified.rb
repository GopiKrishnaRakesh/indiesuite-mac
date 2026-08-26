cask "dminbox-unified" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/dminbox-unified-1.0.0.dmg"
  name "Dminbox-unified"
  desc "Unified menu bar badge and preview for Slack, Discord, WhatsApp"
  homepage "https://indiesuite.app/apps/dminbox-unified"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Dminbox-unified.app"

  zap trash: [
    "~/Library/Application Support/dminbox-unified",
    "~/Library/Preferences/com.indiesuite.dminbox-unified.plist",
  ]
end
