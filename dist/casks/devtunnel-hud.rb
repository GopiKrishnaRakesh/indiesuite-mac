cask "devtunnel-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/devtunnel-hud-1.0.0.dmg"
  name "Devtunnel-hud"
  desc "Menu bar manager & traffic inspector for tunnels"
  homepage "https://indiesuite.app/apps/devtunnel-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Devtunnel-hud.app"

  zap trash: [
    "~/Library/Application Support/devtunnel-hud",
    "~/Library/Preferences/com.indiesuite.devtunnel-hud.plist",
  ]
end
