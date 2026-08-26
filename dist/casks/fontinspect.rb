cask "fontinspect" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/fontinspect-1.0.0.dmg"
  name "Fontinspect"
  desc "Local font viewer, glyph explorer, and variable font tester"
  homepage "https://indiesuite.app/apps/fontinspect"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Fontinspect.app"

  zap trash: [
    "~/Library/Application Support/fontinspect",
    "~/Library/Preferences/com.indiesuite.fontinspect.plist",
  ]
end
