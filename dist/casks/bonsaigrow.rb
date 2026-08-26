cask "bonsaigrow" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/bonsaigrow-1.0.0.dmg"
  name "Bonsaigrow"
  desc "Virtual Zen Bonsai tree that grows with completed focus sessions"
  homepage "https://indiesuite.app/apps/bonsaigrow"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Bonsaigrow.app"

  zap trash: [
    "~/Library/Application Support/bonsaigrow",
    "~/Library/Preferences/com.indiesuite.bonsaigrow.plist",
  ]
end
