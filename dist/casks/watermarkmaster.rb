cask "watermarkmaster" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/watermarkmaster-1.0.0.dmg"
  name "Watermarkmaster"
  desc "Applies customizable dynamic logos and watermarks to image batches"
  homepage "https://indiesuite.app/apps/watermarkmaster"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Watermarkmaster.app"

  zap trash: [
    "~/Library/Application Support/watermarkmaster",
    "~/Library/Preferences/com.indiesuite.watermarkmaster.plist",
  ]
end
