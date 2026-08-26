cask "tokenwatch" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/tokenwatch-1.0.0.dmg"
  name "Tokenwatch"
  desc "Menu bar real-time LLM API spend & rate-limit monitor"
  homepage "https://indiesuite.app/apps/tokenwatch"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Tokenwatch.app"

  zap trash: [
    "~/Library/Application Support/tokenwatch",
    "~/Library/Preferences/com.indiesuite.tokenwatch.plist",
  ]
end
