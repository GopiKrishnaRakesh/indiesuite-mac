cask "podcastchapter-marker" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/podcastchapter-marker-1.0.0.dmg"
  name "Podcastchapter-marker"
  desc "Audio waveform scrubber to drop and export ID3 chapter markers"
  homepage "https://indiesuite.app/apps/podcastchapter-marker"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Podcastchapter-marker.app"

  zap trash: [
    "~/Library/Application Support/podcastchapter-marker",
    "~/Library/Preferences/com.indiesuite.podcastchapter-marker.plist",
  ]
end
