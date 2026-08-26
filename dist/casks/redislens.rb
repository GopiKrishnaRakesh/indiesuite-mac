cask "redislens" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/redislens-1.0.0.dmg"
  name "Redislens"
  desc "Menu bar Redis key-value browser, TTL inspector, and memory analyzer"
  homepage "https://indiesuite.app/apps/redislens"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Redislens.app"

  zap trash: [
    "~/Library/Application Support/redislens",
    "~/Library/Preferences/com.indiesuite.redislens.plist",
  ]
end
