cask "quickshare-local" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/quickshare-local-1.0.0.dmg"
  name "Quickshare-local"
  desc "P2P local network file dropper between Macs and PCs"
  homepage "https://indiesuite.app/apps/quickshare-local"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Quickshare-local.app"

  zap trash: [
    "~/Library/Application Support/quickshare-local",
    "~/Library/Preferences/com.indiesuite.quickshare-local.plist",
  ]
end
