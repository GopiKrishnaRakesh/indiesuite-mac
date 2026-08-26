cask "appiconforge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/appiconforge-1.0.0.dmg"
  name "Appiconforge"
  desc "Generates all iOS, macOS, watchOS, and Web icon sizes from PNG"
  homepage "https://indiesuite.app/apps/appiconforge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Appiconforge.app"

  zap trash: [
    "~/Library/Application Support/appiconforge",
    "~/Library/Preferences/com.indiesuite.appiconforge.plist",
  ]
end
