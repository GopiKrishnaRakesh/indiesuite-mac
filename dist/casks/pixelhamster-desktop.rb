cask "pixelhamster-desktop" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/pixelhamster-desktop-1.0.0.dmg"
  name "Pixelhamster-desktop"
  desc "Animated pixel hamster running on a wheel in the menu bar"
  homepage "https://indiesuite.app/apps/pixelhamster-desktop"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Pixelhamster-desktop.app"

  zap trash: [
    "~/Library/Application Support/pixelhamster-desktop",
    "~/Library/Preferences/com.indiesuite.pixelhamster-desktop.plist",
  ]
end
