cask "dockerquick-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/dockerquick-hud-1.0.0.dmg"
  name "Dockerquick-hud"
  desc "Lightweight container viewer, log stream, and volume cleanup"
  homepage "https://indiesuite.app/apps/dockerquick-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Dockerquick-hud.app"

  zap trash: [
    "~/Library/Application Support/dockerquick-hud",
    "~/Library/Preferences/com.indiesuite.dockerquick-hud.plist",
  ]
end
