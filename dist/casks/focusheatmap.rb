cask "focusheatmap" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/focusheatmap-1.0.0.dmg"
  name "Focusheatmap"
  desc "Live visual heatmap overlay showing app and window attention"
  homepage "https://indiesuite.app/apps/focusheatmap"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Focusheatmap.app"

  zap trash: [
    "~/Library/Application Support/focusheatmap",
    "~/Library/Preferences/com.indiesuite.focusheatmap.plist",
  ]
end
