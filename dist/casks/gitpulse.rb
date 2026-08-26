cask "gitpulse" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/gitpulse-1.0.0.dmg"
  name "Gitpulse"
  desc "Multi-repo status bar tracker for git repositories"
  homepage "https://indiesuite.app/apps/gitpulse"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Gitpulse.app"

  zap trash: [
    "~/Library/Application Support/gitpulse",
    "~/Library/Preferences/com.indiesuite.gitpulse.plist",
  ]
end
