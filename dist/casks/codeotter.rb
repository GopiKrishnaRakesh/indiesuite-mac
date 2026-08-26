cask "codeotter" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/codeotter-1.0.0.dmg"
  name "Codeotter"
  desc "Playful otter swimming along window edges catching fish on test passes"
  homepage "https://indiesuite.app/apps/codeotter"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Codeotter.app"

  zap trash: [
    "~/Library/Application Support/codeotter",
    "~/Library/Preferences/com.indiesuite.codeotter.plist",
  ]
end
