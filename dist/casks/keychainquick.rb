cask "keychainquick" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/keychainquick-1.0.0.dmg"
  name "Keychainquick"
  desc "Fast search and copy for developer SSH keys and GPG tokens"
  homepage "https://indiesuite.app/apps/keychainquick"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Keychainquick.app"

  zap trash: [
    "~/Library/Application Support/keychainquick",
    "~/Library/Preferences/com.indiesuite.keychainquick.plist",
  ]
end
