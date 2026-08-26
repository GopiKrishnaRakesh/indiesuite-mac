cask "tablimiter-pro" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/tablimiter-pro-1.0.0.dmg"
  name "Tablimiter-pro"
  desc "Restricts open tabs to max 5, auto-archiving overflowing tabs"
  homepage "https://indiesuite.app/apps/tablimiter-pro"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Tablimiter-pro.app"

  zap trash: [
    "~/Library/Application Support/tablimiter-pro",
    "~/Library/Preferences/com.indiesuite.tablimiter-pro.plist",
  ]
end
