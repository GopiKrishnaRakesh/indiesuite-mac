cask "hiddenfiles-toggle" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/hiddenfiles-toggle-1.0.0.dmg"
  name "Hiddenfiles-toggle"
  desc "1-click toggle to show/hide hidden dotfiles in Finder"
  homepage "https://indiesuite.app/apps/hiddenfiles-toggle"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Hiddenfiles-toggle.app"

  zap trash: [
    "~/Library/Application Support/hiddenfiles-toggle",
    "~/Library/Preferences/com.indiesuite.hiddenfiles-toggle.plist",
  ]
end
