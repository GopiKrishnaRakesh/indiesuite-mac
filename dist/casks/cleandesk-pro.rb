cask "cleandesk-pro" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/cleandesk-pro-1.0.0.dmg"
  name "Cleandesk-pro"
  desc "1-click presentation mode and clutter cleaner"
  homepage "https://indiesuite.app/apps/cleandesk-pro"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Cleandesk-pro.app"

  zap trash: [
    "~/Library/Application Support/cleandesk-pro",
    "~/Library/Preferences/com.indiesuite.cleandesk-pro.plist",
  ]
end
