cask "postureguard" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/postureguard-1.0.0.dmg"
  name "Postureguard"
  desc "Offline Vision posture estimation to prevent slouching"
  homepage "https://indiesuite.app/apps/postureguard"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Postureguard.app"

  zap trash: [
    "~/Library/Application Support/postureguard",
    "~/Library/Preferences/com.indiesuite.postureguard.plist",
  ]
end
