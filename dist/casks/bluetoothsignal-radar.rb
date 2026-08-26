cask "bluetoothsignal-radar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/bluetoothsignal-radar-1.0.0.dmg"
  name "Bluetoothsignal-radar"
  desc "Signal strength (RSSI) monitor for AirPods and mice"
  homepage "https://indiesuite.app/apps/bluetoothsignal-radar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Bluetoothsignal-radar.app"

  zap trash: [
    "~/Library/Application Support/bluetoothsignal-radar",
    "~/Library/Preferences/com.indiesuite.bluetoothsignal-radar.plist",
  ]
end
