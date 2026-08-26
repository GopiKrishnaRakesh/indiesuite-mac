cask "quickpoll-creator" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/quickpoll-creator-1.0.0.dmg"
  name "Quickpoll-creator"
  desc "Generates formatted poll layouts for Twitter, LinkedIn, and Slack"
  homepage "https://indiesuite.app/apps/quickpoll-creator"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Quickpoll-creator.app"

  zap trash: [
    "~/Library/Application Support/quickpoll-creator",
    "~/Library/Preferences/com.indiesuite.quickpoll-creator.plist",
  ]
end
