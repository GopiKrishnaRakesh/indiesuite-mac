cask "privatellm-bar" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/privatellm-bar-1.0.0.dmg"
  name "Privatellm-bar"
  desc "Ultra-lightweight menu bar local model runner"
  homepage "https://indiesuite.app/apps/privatellm-bar"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Privatellm-bar.app"

  zap trash: [
    "~/Library/Application Support/privatellm-bar",
    "~/Library/Preferences/com.indiesuite.privatellm-bar.plist",
  ]
end
