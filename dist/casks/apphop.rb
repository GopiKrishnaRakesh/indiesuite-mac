cask "apphop" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/apphop-1.0.0.dmg"
  name "Apphop"
  desc "Quick-switch popup between windows of active workspace"
  homepage "https://indiesuite.app/apps/apphop"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Apphop.app"

  zap trash: [
    "~/Library/Application Support/apphop",
    "~/Library/Preferences/com.indiesuite.apphop.plist",
  ]
end
