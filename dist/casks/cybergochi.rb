cask "cybergochi" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/cybergochi-1.0.0.dmg"
  name "Cybergochi"
  desc "Retro Tamagotchi virtual pet that eats completed to-do items"
  homepage "https://indiesuite.app/apps/cybergochi"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Cybergochi.app"

  zap trash: [
    "~/Library/Application Support/cybergochi",
    "~/Library/Preferences/com.indiesuite.cybergochi.plist",
  ]
end
