cask "portforwarder-pro" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/portforwarder-pro-1.0.0.dmg"
  name "Portforwarder-pro"
  desc "SSH tunnel and local port forwarding manager with auto-reconnect"
  homepage "https://indiesuite.app/apps/portforwarder-pro"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Portforwarder-pro.app"

  zap trash: [
    "~/Library/Application Support/portforwarder-pro",
    "~/Library/Preferences/com.indiesuite.portforwarder-pro.plist",
  ]
end
