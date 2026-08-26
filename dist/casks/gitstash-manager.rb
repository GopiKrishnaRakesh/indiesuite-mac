cask "gitstash-manager" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/gitstash-manager-1.0.0.dmg"
  name "Gitstash-manager"
  desc "Visual UI for viewing, comparing, applying, and dropping stashes"
  homepage "https://indiesuite.app/apps/gitstash-manager"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Gitstash-manager.app"

  zap trash: [
    "~/Library/Application Support/gitstash-manager",
    "~/Library/Preferences/com.indiesuite.gitstash-manager.plist",
  ]
end
