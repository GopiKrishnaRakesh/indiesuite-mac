cask "codeexplainer-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/codeexplainer-hud-1.0.0.dmg"
  name "Codeexplainer-hud"
  desc "Highlight cryptic code or errors for plain-English explanation"
  homepage "https://indiesuite.app/apps/codeexplainer-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Codeexplainer-hud.app"

  zap trash: [
    "~/Library/Application Support/codeexplainer-hud",
    "~/Library/Preferences/com.indiesuite.codeexplainer-hud.plist",
  ]
end
