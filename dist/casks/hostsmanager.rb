cask "hostsmanager" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/hostsmanager-1.0.0.dmg"
  name "Hostsmanager"
  desc "1-click /etc/hosts profile switcher for dev and staging domains"
  homepage "https://indiesuite.app/apps/hostsmanager"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Hostsmanager.app"

  zap trash: [
    "~/Library/Application Support/hostsmanager",
    "~/Library/Preferences/com.indiesuite.hostsmanager.plist",
  ]
end
