cask "envvault" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/envvault-1.0.0.dmg"
  name "Envvault"
  desc "Secure .env & API key workspace manager"
  homepage "https://indiesuite.app/apps/envvault"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Envvault.app"

  zap trash: [
    "~/Library/Application Support/envvault",
    "~/Library/Preferences/com.indiesuite.envvault.plist",
  ]
end
