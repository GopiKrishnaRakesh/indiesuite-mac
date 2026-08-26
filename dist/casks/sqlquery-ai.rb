cask "sqlquery-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/sqlquery-ai-1.0.0.dmg"
  name "Sqlquery-ai"
  desc "Translates plain English requests into optimized SQL queries"
  homepage "https://indiesuite.app/apps/sqlquery-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Sqlquery-ai.app"

  zap trash: [
    "~/Library/Application Support/sqlquery-ai",
    "~/Library/Preferences/com.indiesuite.sqlquery-ai.plist",
  ]
end
