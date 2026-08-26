cask "bandwidthradar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/bandwidthradar-1.0.0.dmg"
  name "Bandwidthradar"
  desc "Real-time per-app network download/upload monitor"
  homepage "https://indiesuite.app/apps/bandwidthradar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Bandwidthradar.app"

  zap trash: [
    "~/Library/Application Support/bandwidthradar",
    "~/Library/Preferences/com.indiesuite.bandwidthradar.plist",
  ]
end
