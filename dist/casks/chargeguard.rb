cask "chargeguard" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/chargeguard-1.0.0.dmg"
  name "Chargeguard"
  desc "Battery health optimizer & custom charge threshold limiter"
  homepage "https://indiesuite.app/apps/chargeguard"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Chargeguard.app"

  zap trash: [
    "~/Library/Application Support/chargeguard",
    "~/Library/Preferences/com.indiesuite.chargeguard.plist",
  ]
end
