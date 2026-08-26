cask "whispersubtitles-srt" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/whispersubtitles-srt-1.0.0.dmg"
  name "Whispersubtitles-srt"
  desc "Generates timestamped .srt and .vtt subtitles locally"
  homepage "https://indiesuite.app/apps/whispersubtitles-srt"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Whispersubtitles-srt.app"

  zap trash: [
    "~/Library/Application Support/whispersubtitles-srt",
    "~/Library/Preferences/com.indiesuite.whispersubtitles-srt.plist",
  ]
end
