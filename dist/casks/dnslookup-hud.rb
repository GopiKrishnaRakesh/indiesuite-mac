cask "dnslookup-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/dnslookup-hud-1.0.0.dmg"
  name "Dnslookup-hud"
  desc "Instant DNS record inspector with global node propagation test"
  homepage "https://indiesuite.app/apps/dnslookup-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Dnslookup-hud.app"

  zap trash: [
    "~/Library/Application Support/dnslookup-hud",
    "~/Library/Preferences/com.indiesuite.dnslookup-hud.plist",
  ]
end
