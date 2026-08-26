cask "zenaudio-ambience" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/zenaudio-ambience-1.0.0.dmg"
  name "Zenaudio-ambience"
  desc "Binaural beats, brown noise, and rain 432Hz focus generator"
  homepage "https://indiesuite.app/apps/zenaudio-ambience"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Zenaudio-ambience.app"

  zap trash: [
    "~/Library/Application Support/zenaudio-ambience",
    "~/Library/Preferences/com.indiesuite.zenaudio-ambience.plist",
  ]
end
