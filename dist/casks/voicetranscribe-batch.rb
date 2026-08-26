cask "voicetranscribe-batch" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/voicetranscribe-batch-1.0.0.dmg"
  name "Voicetranscribe-batch"
  desc "Batch audio transcriber for podcasts and meeting files"
  homepage "https://indiesuite.app/apps/voicetranscribe-batch"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Voicetranscribe-batch.app"

  zap trash: [
    "~/Library/Application Support/voicetranscribe-batch",
    "~/Library/Preferences/com.indiesuite.voicetranscribe-batch.plist",
  ]
end
