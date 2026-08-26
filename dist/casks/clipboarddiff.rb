cask "clipboarddiff" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/clipboarddiff-1.0.0.dmg"
  name "Clipboarddiff"
  desc "Compares current clipboard with previous clipboard with diff"
  homepage "https://indiesuite.app/apps/clipboarddiff"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Clipboarddiff.app"

  zap trash: [
    "~/Library/Application Support/clipboarddiff",
    "~/Library/Preferences/com.indiesuite.clipboarddiff.plist",
  ]
end
