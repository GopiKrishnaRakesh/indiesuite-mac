cask "httpheader-inspector" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/httpheader-inspector-1.0.0.dmg"
  name "Httpheader-inspector"
  desc "Tests HTTP response headers, CORS policies, and SSL handshakes"
  homepage "https://indiesuite.app/apps/httpheader-inspector"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Httpheader-inspector.app"

  zap trash: [
    "~/Library/Application Support/httpheader-inspector",
    "~/Library/Preferences/com.indiesuite.httpheader-inspector.plist",
  ]
end
