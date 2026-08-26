cask "shadowstudio" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/shadowstudio-1.0.0.dmg"
  name "Shadowstudio"
  desc "Realistic multi-layer shadow designer with SwiftUI code export"
  homepage "https://indiesuite.app/apps/shadowstudio"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Shadowstudio.app"

  zap trash: [
    "~/Library/Application Support/shadowstudio",
    "~/Library/Preferences/com.indiesuite.shadowstudio.plist",
  ]
end
