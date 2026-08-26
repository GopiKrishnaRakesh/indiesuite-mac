cask "breakreminder" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/breakreminder-1.0.0.dmg"
  name "Breakreminder"
  desc "20-20-20 eye strain rule and ergonomic stretch coach"
  homepage "https://indiesuite.app/apps/breakreminder"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Breakreminder.app"

  zap trash: [
    "~/Library/Application Support/breakreminder",
    "~/Library/Preferences/com.indiesuite.breakreminder.plist",
  ]
end
