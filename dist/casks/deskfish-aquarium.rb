cask "deskfish-aquarium" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/deskfish-aquarium-1.0.0.dmg"
  name "Deskfish-aquarium"
  desc "Translucent floating desk aquarium habit tracker"
  homepage "https://indiesuite.app/apps/deskfish-aquarium"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Deskfish-aquarium.app"

  zap trash: [
    "~/Library/Application Support/deskfish-aquarium",
    "~/Library/Preferences/com.indiesuite.deskfish-aquarium.plist",
  ]
end
