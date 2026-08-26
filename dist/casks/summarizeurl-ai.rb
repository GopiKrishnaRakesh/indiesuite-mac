cask "summarizeurl-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/summarizeurl-ai-1.0.0.dmg"
  name "Summarizeurl-ai"
  desc "Offline webpage and article summarizer with 3 bullet takeaways"
  homepage "https://indiesuite.app/apps/summarizeurl-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Summarizeurl-ai.app"

  zap trash: [
    "~/Library/Application Support/summarizeurl-ai",
    "~/Library/Preferences/com.indiesuite.summarizeurl-ai.plist",
  ]
end
