cask "caffeinebar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/caffeinebar-1.0.0.dmg"
  name "Caffeinebar"
  desc "Keeps Mac awake indefinitely with custom display sleep rules"
  homepage "https://indiesuite.app/apps/caffeinebar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Caffeinebar.app"

  zap trash: [
    "~/Library/Application Support/caffeinebar",
    "~/Library/Preferences/com.indiesuite.caffeinebar.plist",
  ]
end
