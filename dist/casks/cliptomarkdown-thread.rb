cask "cliptomarkdown-thread" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/cliptomarkdown-thread-1.0.0.dmg"
  name "Cliptomarkdown-thread"
  desc "Converts social posts into clean Obsidian/Notion markdown"
  homepage "https://indiesuite.app/apps/cliptomarkdown-thread"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Cliptomarkdown-thread.app"

  zap trash: [
    "~/Library/Application Support/cliptomarkdown-thread",
    "~/Library/Preferences/com.indiesuite.cliptomarkdown-thread.plist",
  ]
end
