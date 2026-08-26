cask "zenpanda" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/zenpanda-1.0.0.dmg"
  name "Zenpanda"
  desc "Meditating panda companion guiding 60-second box-breathing exercises"
  homepage "https://indiesuite.app/apps/zenpanda"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Zenpanda.app"

  zap trash: [
    "~/Library/Application Support/zenpanda",
    "~/Library/Preferences/com.indiesuite.zenpanda.plist",
  ]
end
