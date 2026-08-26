cask "whitenoise-mixer" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/whitenoise-mixer-1.0.0.dmg"
  name "Whitenoise-mixer"
  desc "Multi-track customizable soundscape mixer with rain and campfire"
  homepage "https://indiesuite.app/apps/whitenoise-mixer"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Whitenoise-mixer.app"

  zap trash: [
    "~/Library/Application Support/whitenoise-mixer",
    "~/Library/Preferences/com.indiesuite.whitenoise-mixer.plist",
  ]
end
