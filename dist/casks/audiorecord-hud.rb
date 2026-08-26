cask "audiorecord-hud" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/audiorecord-hud-1.0.0.dmg"
  name "Audiorecord-hud"
  desc "1-click system audio + microphone recorder with MP3 export"
  homepage "https://indiesuite.app/apps/audiorecord-hud"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Audiorecord-hud.app"

  zap trash: [
    "~/Library/Application Support/audiorecord-hud",
    "~/Library/Preferences/com.indiesuite.audiorecord-hud.plist",
  ]
end
