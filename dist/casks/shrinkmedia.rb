cask "shrinkmedia" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/shrinkmedia-1.0.0.dmg"
  name "Shrinkmedia"
  desc "Fast batch video/audio/image compressor & GIF converter"
  homepage "https://indiesuite.app/apps/shrinkmedia"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Shrinkmedia.app"

  zap trash: [
    "~/Library/Application Support/shrinkmedia",
    "~/Library/Preferences/com.indiesuite.shrinkmedia.plist",
  ]
end
