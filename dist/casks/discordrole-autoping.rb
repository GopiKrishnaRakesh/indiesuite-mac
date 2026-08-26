cask "discordrole-autoping" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/discordrole-autoping-1.0.0.dmg"
  name "Discordrole-autoping"
  desc "Quick organizer for Discord markdown, roles, and embeds"
  homepage "https://indiesuite.app/apps/discordrole-autoping"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Discordrole-autoping.app"

  zap trash: [
    "~/Library/Application Support/discordrole-autoping",
    "~/Library/Preferences/com.indiesuite.discordrole-autoping.plist",
  ]
end
