cask "purgeapp" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/purgeapp-1.0.0.dmg"
  name "Purgeapp"
  desc "Deep uninstaller tracking hidden caches and plists"
  homepage "https://indiesuite.app/apps/purgeapp"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Purgeapp.app"

  zap trash: [
    "~/Library/Application Support/purgeapp",
    "~/Library/Preferences/com.indiesuite.purgeapp.plist",
  ]
end
