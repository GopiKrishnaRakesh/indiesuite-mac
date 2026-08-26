cask "diskscleaner-mini" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/diskscleaner-mini-1.0.0.dmg"
  name "Diskscleaner-mini"
  desc "Visualizes large downloads and node_modules for selective purge"
  homepage "https://indiesuite.app/apps/diskscleaner-mini"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Diskscleaner-mini.app"

  zap trash: [
    "~/Library/Application Support/diskscleaner-mini",
    "~/Library/Preferences/com.indiesuite.diskscleaner-mini.plist",
  ]
end
