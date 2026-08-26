cask "habitgrid" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/habitgrid-1.0.0.dmg"
  name "Habitgrid"
  desc "GitHub-style 365-day contribution heatmaps for daily habits"
  homepage "https://indiesuite.app/apps/habitgrid"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Habitgrid.app"

  zap trash: [
    "~/Library/Application Support/habitgrid",
    "~/Library/Preferences/com.indiesuite.habitgrid.plist",
  ]
end
