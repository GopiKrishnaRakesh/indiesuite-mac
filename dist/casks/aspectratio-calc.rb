cask "aspectratio-calc" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/aspectratio-calc-1.0.0.dmg"
  name "Aspectratio-calc"
  desc "Instant aspect ratio, DPI, and viewport sizing calculator"
  homepage "https://indiesuite.app/apps/aspectratio-calc"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Aspectratio-calc.app"

  zap trash: [
    "~/Library/Application Support/aspectratio-calc",
    "~/Library/Preferences/com.indiesuite.aspectratio-calc.plist",
  ]
end
