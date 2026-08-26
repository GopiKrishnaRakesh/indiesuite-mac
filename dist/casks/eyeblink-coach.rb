cask "eyeblink-coach" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/eyeblink-coach-1.0.0.dmg"
  name "Eyeblink-coach"
  desc "Soft screen border halo pulse every 15s to remind users to blink"
  homepage "https://indiesuite.app/apps/eyeblink-coach"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Eyeblink-coach.app"

  zap trash: [
    "~/Library/Application Support/eyeblink-coach",
    "~/Library/Preferences/com.indiesuite.eyeblink-coach.plist",
  ]
end
