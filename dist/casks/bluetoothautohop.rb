cask "bluetoothautohop" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/bluetoothautohop-1.0.0.dmg"
  name "Bluetoothautohop"
  desc "Smart Bluetooth auto-disconnect and reconnect manager"
  homepage "https://indiesuite.app/apps/bluetoothautohop"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Bluetoothautohop.app"

  zap trash: [
    "~/Library/Application Support/bluetoothautohop",
    "~/Library/Preferences/com.indiesuite.bluetoothautohop.plist",
  ]
end
