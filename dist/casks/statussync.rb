cask "statussync" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/statussync-1.0.0.dmg"
  name "Statussync"
  desc "Auto-syncs Slack, Discord, and Teams status based on active app"
  homepage "https://indiesuite.app/apps/statussync"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Statussync.app"

  zap trash: [
    "~/Library/Application Support/statussync",
    "~/Library/Preferences/com.indiesuite.statussync.plist",
  ]
end
