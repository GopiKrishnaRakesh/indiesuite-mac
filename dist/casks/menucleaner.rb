cask "menucleaner" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/menucleaner-1.0.0.dmg"
  name "Menucleaner"
  desc "Lightweight menu bar icon manager and hider"
  homepage "https://indiesuite.app/apps/menucleaner"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Menucleaner.app"

  zap trash: [
    "~/Library/Application Support/menucleaner",
    "~/Library/Preferences/com.indiesuite.menucleaner.plist",
  ]
end
