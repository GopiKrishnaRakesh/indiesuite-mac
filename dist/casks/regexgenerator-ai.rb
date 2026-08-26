cask "regexgenerator-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/regexgenerator-ai-1.0.0.dmg"
  name "Regexgenerator-ai"
  desc "Converts plain English descriptions into tested regex"
  homepage "https://indiesuite.app/apps/regexgenerator-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Regexgenerator-ai.app"

  zap trash: [
    "~/Library/Application Support/regexgenerator-ai",
    "~/Library/Preferences/com.indiesuite.regexgenerator-ai.plist",
  ]
end
