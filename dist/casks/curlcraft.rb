cask "curlcraft" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/curlcraft-1.0.0.dmg"
  name "Curlcraft"
  desc "Converts network cURL commands to Swift, Python, Node, Go code"
  homepage "https://indiesuite.app/apps/curlcraft"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Curlcraft.app"

  zap trash: [
    "~/Library/Application Support/curlcraft",
    "~/Library/Preferences/com.indiesuite.curlcraft.plist",
  ]
end
