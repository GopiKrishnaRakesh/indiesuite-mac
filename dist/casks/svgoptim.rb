cask "svgoptim" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/svgoptim-1.0.0.dmg"
  name "Svgoptim"
  desc "Zero-bloat SVG optimizer and SwiftUI/React component generator"
  homepage "https://indiesuite.app/apps/svgoptim"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Svgoptim.app"

  zap trash: [
    "~/Library/Application Support/svgoptim",
    "~/Library/Preferences/com.indiesuite.svgoptim.plist",
  ]
end
