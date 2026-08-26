cask "deskduck" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/deskduck-1.0.0.dmg"
  name "Deskduck"
  desc "Floating rubber duck debugger that asks Socratic prompts"
  homepage "https://indiesuite.app/apps/deskduck"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Deskduck.app"

  zap trash: [
    "~/Library/Application Support/deskduck",
    "~/Library/Preferences/com.indiesuite.deskduck.plist",
  ]
end
