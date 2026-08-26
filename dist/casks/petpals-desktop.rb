cask "petpals-desktop" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/petpals-desktop-1.0.0.dmg"
  name "Petpals-desktop"
  desc "Interactive desktop pet with hydration and posture nudges"
  homepage "https://indiesuite.app/apps/petpals-desktop"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Petpals-desktop.app"

  zap trash: [
    "~/Library/Application Support/petpals-desktop",
    "~/Library/Preferences/com.indiesuite.petpals-desktop.plist",
  ]
end
