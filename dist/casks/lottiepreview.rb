cask "lottiepreview" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/lottiepreview-1.0.0.dmg"
  name "Lottiepreview"
  desc "Native dotLottie & JSON animation player with GIF exporter"
  homepage "https://indiesuite.app/apps/lottiepreview"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Lottiepreview.app"

  zap trash: [
    "~/Library/Application Support/lottiepreview",
    "~/Library/Preferences/com.indiesuite.lottiepreview.plist",
  ]
end
