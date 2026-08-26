cask "portsentry" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/portsentry-1.0.0.dmg"
  name "Portsentry"
  desc "Menu bar active port & zombie process killer"
  homepage "https://indiesuite.app/apps/portsentry"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Portsentry.app"

  zap trash: [
    "~/Library/Application Support/portsentry",
    "~/Library/Preferences/com.indiesuite.portsentry.plist",
  ]
end
