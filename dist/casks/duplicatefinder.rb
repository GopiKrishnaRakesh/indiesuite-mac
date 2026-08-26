cask "duplicatefinder" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/duplicatefinder-1.0.0.dmg"
  name "Duplicatefinder"
  desc "Hashing-based duplicate file scanner to reclaim disk space"
  homepage "https://indiesuite.app/apps/duplicatefinder"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Duplicatefinder.app"

  zap trash: [
    "~/Library/Application Support/duplicatefinder",
    "~/Library/Preferences/com.indiesuite.duplicatefinder.plist",
  ]
end
