cask "jsonmaster-pro" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/jsonmaster-pro-1.0.0.dmg"
  name "Jsonmaster-pro"
  desc "JSON, YAML, and TOML formatter with TypeScript interface generator"
  homepage "https://indiesuite.app/apps/jsonmaster-pro"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Jsonmaster-pro.app"

  zap trash: [
    "~/Library/Application Support/jsonmaster-pro",
    "~/Library/Preferences/com.indiesuite.jsonmaster-pro.plist",
  ]
end
