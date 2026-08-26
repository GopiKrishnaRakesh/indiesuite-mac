cask "diffexplainer-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/diffexplainer-ai-1.0.0.dmg"
  name "Diffexplainer-ai"
  desc "Analyzes git diffs to generate clean release notes and changelogs"
  homepage "https://indiesuite.app/apps/diffexplainer-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Diffexplainer-ai.app"

  zap trash: [
    "~/Library/Application Support/diffexplainer-ai",
    "~/Library/Preferences/com.indiesuite.diffexplainer-ai.plist",
  ]
end
