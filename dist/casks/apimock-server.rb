cask "apimock-server" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/apimock-server-1.0.0.dmg"
  name "Apimock-server"
  desc "1-click local mock HTTP server with latency simulation"
  homepage "https://indiesuite.app/apps/apimock-server"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Apimock-server.app"

  zap trash: [
    "~/Library/Application Support/apimock-server",
    "~/Library/Preferences/com.indiesuite.apimock-server.plist",
  ]
end
