cask "audiomix" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/audiomix-1.0.0.dmg"
  name "Audiomix"
  desc "Per-app volume mixer & independent audio output routing"
  homepage "https://indiesuite.app/apps/audiomix"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Audiomix.app"

  zap trash: [
    "~/Library/Application Support/audiomix",
    "~/Library/Preferences/com.indiesuite.audiomix.plist",
  ]
end
