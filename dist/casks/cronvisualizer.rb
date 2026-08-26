cask "cronvisualizer" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/cronvisualizer-1.0.0.dmg"
  name "Cronvisualizer"
  desc "Visual cron expression builder and schedule debugger"
  homepage "https://indiesuite.app/apps/cronvisualizer"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Cronvisualizer.app"

  zap trash: [
    "~/Library/Application Support/cronvisualizer",
    "~/Library/Preferences/com.indiesuite.cronvisualizer.plist",
  ]
end
