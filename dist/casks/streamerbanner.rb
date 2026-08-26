cask "streamerbanner" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/streamerbanner-1.0.0.dmg"
  name "Streamerbanner"
  desc "Animated lower-thirds and watermark for screen recordings"
  homepage "https://indiesuite.app/apps/streamerbanner"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Streamerbanner.app"

  zap trash: [
    "~/Library/Application Support/streamerbanner",
    "~/Library/Preferences/com.indiesuite.streamerbanner.plist",
  ]
end
