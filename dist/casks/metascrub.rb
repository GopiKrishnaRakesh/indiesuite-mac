cask "metascrub" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/metascrub-1.0.0.dmg"
  name "Metascrub"
  desc "Instant EXIF, GPS location, and privacy metadata stripper"
  homepage "https://indiesuite.app/apps/metascrub"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Metascrub.app"

  zap trash: [
    "~/Library/Application Support/metascrub",
    "~/Library/Preferences/com.indiesuite.metascrub.plist",
  ]
end
