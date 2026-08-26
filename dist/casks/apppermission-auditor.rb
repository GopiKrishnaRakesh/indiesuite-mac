cask "apppermission-auditor" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/apppermission-auditor-1.0.0.dmg"
  name "Apppermission-auditor"
  desc "Inspects apps granted Camera, Mic, or Accessibility"
  homepage "https://indiesuite.app/apps/apppermission-auditor"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Apppermission-auditor.app"

  zap trash: [
    "~/Library/Application Support/apppermission-auditor",
    "~/Library/Preferences/com.indiesuite.apppermission-auditor.plist",
  ]
end
