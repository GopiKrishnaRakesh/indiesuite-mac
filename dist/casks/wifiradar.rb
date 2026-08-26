cask "wifiradar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/wifiradar-1.0.0.dmg"
  name "Wifiradar"
  desc "Displays WiFi channel congestion, RSSI, and speed in menu bar"
  homepage "https://indiesuite.app/apps/wifiradar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Wifiradar.app"

  zap trash: [
    "~/Library/Application Support/wifiradar",
    "~/Library/Preferences/com.indiesuite.wifiradar.plist",
  ]
end
