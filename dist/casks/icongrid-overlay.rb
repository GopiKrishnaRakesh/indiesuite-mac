cask "icongrid-overlay" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/icongrid-overlay-1.0.0.dmg"
  name "Icongrid-overlay"
  desc "Pixel-perfect icon grid overlay for 512x512 and 1024x1024 icons"
  homepage "https://indiesuite.app/apps/icongrid-overlay"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Icongrid-overlay.app"

  zap trash: [
    "~/Library/Application Support/icongrid-overlay",
    "~/Library/Preferences/com.indiesuite.icongrid-overlay.plist",
  ]
end
