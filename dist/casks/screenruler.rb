cask "screenruler" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/screenruler-1.0.0.dmg"
  name "Screenruler"
  desc "Precision on-screen pixel measurement ruler & crosshair"
  homepage "https://indiesuite.app/apps/screenruler"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Screenruler.app"

  zap trash: [
    "~/Library/Application Support/screenruler",
    "~/Library/Preferences/com.indiesuite.screenruler.plist",
  ]
end
