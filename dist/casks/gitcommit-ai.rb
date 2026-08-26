cask "gitcommit-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/gitcommit-ai-1.0.0.dmg"
  name "Gitcommit-ai"
  desc "1-click conventional git commit message generator from diffs"
  homepage "https://indiesuite.app/apps/gitcommit-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Gitcommit-ai.app"

  zap trash: [
    "~/Library/Application Support/gitcommit-ai",
    "~/Library/Preferences/com.indiesuite.gitcommit-ai.plist",
  ]
end
