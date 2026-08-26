cask "taillogs" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/taillogs-1.0.0.dmg"
  name "Taillogs"
  desc "Menu bar multi-file live log tailer with regex highlighting"
  homepage "https://indiesuite.app/apps/taillogs"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Taillogs.app"

  zap trash: [
    "~/Library/Application Support/taillogs",
    "~/Library/Preferences/com.indiesuite.taillogs.plist",
  ]
end
