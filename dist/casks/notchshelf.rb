cask "notchshelf" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/notchshelf-1.0.0.dmg"
  name "Notchshelf"
  desc "Smart drop-zone & staging area inside the MacBook notch"
  homepage "https://indiesuite.app/apps/notchshelf"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Notchshelf.app"

  zap trash: [
    "~/Library/Application Support/notchshelf",
    "~/Library/Preferences/com.indiesuite.notchshelf.plist",
  ]
end
