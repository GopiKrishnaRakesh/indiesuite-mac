cask "presentercam" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/presentercam-1.0.0.dmg"
  name "Presentercam"
  desc "Floating camera overlay with background blur & spotlight"
  homepage "https://indiesuite.app/apps/presentercam"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Presentercam.app"

  zap trash: [
    "~/Library/Application Support/presentercam",
    "~/Library/Preferences/com.indiesuite.presentercam.plist",
  ]
end
