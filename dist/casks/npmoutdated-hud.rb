cask "npmoutdated-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/npmoutdated-hud-1.0.0.dmg"
  name "Npmoutdated-hud"
  desc "Watches package.json across repos and alerts on vulnerabilities"
  homepage "https://indiesuite.app/apps/npmoutdated-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Npmoutdated-hud.app"

  zap trash: [
    "~/Library/Application Support/npmoutdated-hud",
    "~/Library/Preferences/com.indiesuite.npmoutdated-hud.plist",
  ]
end
