cask "quicktweet-x" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/quicktweet-x-1.0.0.dmg"
  name "Quicktweet-x"
  desc "Floating HUD to draft and post to X, Bluesky, and Threads"
  homepage "https://indiesuite.app/apps/quicktweet-x"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Quicktweet-x.app"

  zap trash: [
    "~/Library/Application Support/quicktweet-x",
    "~/Library/Preferences/com.indiesuite.quicktweet-x.plist",
  ]
end
