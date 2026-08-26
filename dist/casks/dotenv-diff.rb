cask "dotenv-diff" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/dotenv-diff-1.0.0.dmg"
  name "Dotenv-diff"
  desc "Compares .env.example against actual .env and flags missing keys"
  homepage "https://indiesuite.app/apps/dotenv-diff"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Dotenv-diff.app"

  zap trash: [
    "~/Library/Application Support/dotenv-diff",
    "~/Library/Preferences/com.indiesuite.dotenv-diff.plist",
  ]
end
