cask "singletask-spotlight" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/singletask-spotlight-1.0.0.dmg"
  name "Singletask-spotlight"
  desc "Forces 1 single active window, hiding dock and menu bar"
  homepage "https://indiesuite.app/apps/singletask-spotlight"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Singletask-spotlight.app"

  zap trash: [
    "~/Library/Application Support/singletask-spotlight",
    "~/Library/Preferences/com.indiesuite.singletask-spotlight.plist",
  ]
end
