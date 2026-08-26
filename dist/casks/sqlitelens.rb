cask "sqlitelens" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/sqlitelens-1.0.0.dmg"
  name "Sqlitelens"
  desc "Instant SQLite database file inspector and query runner"
  homepage "https://indiesuite.app/apps/sqlitelens"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Sqlitelens.app"

  zap trash: [
    "~/Library/Application Support/sqlitelens",
    "~/Library/Preferences/com.indiesuite.sqlitelens.plist",
  ]
end
