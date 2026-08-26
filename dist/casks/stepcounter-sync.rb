cask "stepcounter-sync" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/stepcounter-sync-1.0.0.dmg"
  name "Stepcounter-sync"
  desc "Apple Health synced step counter progress bar in menu bar"
  homepage "https://indiesuite.app/apps/stepcounter-sync"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Stepcounter-sync.app"

  zap trash: [
    "~/Library/Application Support/stepcounter-sync",
    "~/Library/Preferences/com.indiesuite.stepcounter-sync.plist",
  ]
end
