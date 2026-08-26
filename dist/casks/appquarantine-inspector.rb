cask "appquarantine-inspector" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/appquarantine-inspector-1.0.0.dmg"
  name "Appquarantine-inspector"
  desc "Lists quarantine attributes with 1-click gatekeeper override"
  homepage "https://indiesuite.app/apps/appquarantine-inspector"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Appquarantine-inspector.app"

  zap trash: [
    "~/Library/Application Support/appquarantine-inspector",
    "~/Library/Preferences/com.indiesuite.appquarantine-inspector.plist",
  ]
end
