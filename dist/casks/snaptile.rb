cask "snaptile" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/snaptile-1.0.0.dmg"
  name "Snaptile"
  desc "Hyper-lightweight keyboard & edge window tiling manager"
  homepage "https://indiesuite.app/apps/snaptile"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Snaptile.app"

  zap trash: [
    "~/Library/Application Support/snaptile",
    "~/Library/Preferences/com.indiesuite.snaptile.plist",
  ]
end
