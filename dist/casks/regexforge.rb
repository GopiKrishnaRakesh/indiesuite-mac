cask "regexforge" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/regexforge-1.0.0.dmg"
  name "Regexforge"
  desc "Native Swift live regex debugger & visual tester"
  homepage "https://indiesuite.app/apps/regexforge"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Regexforge.app"

  zap trash: [
    "~/Library/Application Support/regexforge",
    "~/Library/Preferences/com.indiesuite.regexforge.plist",
  ]
end
