cask "codecat" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/codecat-1.0.0.dmg"
  name "Codecat"
  desc "Animated cat on active window edge purring on Git commits"
  homepage "https://indiesuite.app/apps/codecat"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Codecat.app"

  zap trash: [
    "~/Library/Application Support/codecat",
    "~/Library/Preferences/com.indiesuite.codecat.plist",
  ]
end
