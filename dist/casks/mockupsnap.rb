cask "mockupsnap" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/mockupsnap-1.0.0.dmg"
  name "Mockupsnap"
  desc "1-click wraps screenshots inside 3D MacBook and iPhone frames"
  homepage "https://indiesuite.app/apps/mockupsnap"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Mockupsnap.app"

  zap trash: [
    "~/Library/Application Support/mockupsnap",
    "~/Library/Preferences/com.indiesuite.mockupsnap.plist",
  ]
end
