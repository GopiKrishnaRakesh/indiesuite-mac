cask "aiwallpaper-generator" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/aiwallpaper-generator-1.0.0.dmg"
  name "Aiwallpaper-generator"
  desc "Generates 4K dynamic desktop wallpapers using local CoreML"
  homepage "https://indiesuite.app/apps/aiwallpaper-generator"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Aiwallpaper-generator.app"

  zap trash: [
    "~/Library/Application Support/aiwallpaper-generator",
    "~/Library/Preferences/com.indiesuite.aiwallpaper-generator.plist",
  ]
end
