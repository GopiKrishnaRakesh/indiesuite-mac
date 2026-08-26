cask "monospace-flow" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/monospace-flow-1.0.0.dmg"
  name "Monospace-flow"
  desc "Minimalist typewriter writing mode with mechanical sound cues"
  homepage "https://indiesuite.app/apps/monospace-flow"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Monospace-flow.app"

  zap trash: [
    "~/Library/Application Support/monospace-flow",
    "~/Library/Preferences/com.indiesuite.monospace-flow.plist",
  ]
end
