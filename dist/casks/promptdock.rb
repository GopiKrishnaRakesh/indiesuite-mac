cask "promptdock" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/promptdock-1.0.0.dmg"
  name "Promptdock"
  desc "Global floating prompt HUD and snippet palette"
  homepage "https://indiesuite.app/apps/promptdock"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Promptdock.app"

  zap trash: [
    "~/Library/Application Support/promptdock",
    "~/Library/Preferences/com.indiesuite.promptdock.plist",
  ]
end
