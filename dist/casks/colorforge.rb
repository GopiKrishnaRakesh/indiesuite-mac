cask "colorforge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/colorforge-1.0.0.dmg"
  name "Colorforge"
  desc "Native eyedropper, palette builder, and contrast checker"
  homepage "https://indiesuite.app/apps/colorforge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Colorforge.app"

  zap trash: [
    "~/Library/Application Support/colorforge",
    "~/Library/Preferences/com.indiesuite.colorforge.plist",
  ]
end
