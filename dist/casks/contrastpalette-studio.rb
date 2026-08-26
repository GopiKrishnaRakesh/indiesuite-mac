cask "contrastpalette-studio" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/contrastpalette-studio-1.0.0.dmg"
  name "Contrastpalette-studio"
  desc "Creates accessible color systems meeting WCAG AAA"
  homepage "https://indiesuite.app/apps/contrastpalette-studio"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Contrastpalette-studio.app"

  zap trash: [
    "~/Library/Application Support/contrastpalette-studio",
    "~/Library/Preferences/com.indiesuite.contrastpalette-studio.plist",
  ]
end
