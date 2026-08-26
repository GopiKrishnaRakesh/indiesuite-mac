cask "memorypurge-pro" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/memorypurge-pro-1.0.0.dmg"
  name "Memorypurge-pro"
  desc "Visual RAM pressure monitor with 1-click inactive memory purge"
  homepage "https://indiesuite.app/apps/memorypurge-pro"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Memorypurge-pro.app"

  zap trash: [
    "~/Library/Application Support/memorypurge-pro",
    "~/Library/Preferences/com.indiesuite.memorypurge-pro.plist",
  ]
end
