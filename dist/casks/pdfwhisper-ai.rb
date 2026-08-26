cask "pdfwhisper-ai" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/pdfwhisper-ai-1.0.0.dmg"
  name "Pdfwhisper-ai"
  desc "Instant local Q&A with PDFs via Apple Silicon embeddings"
  homepage "https://indiesuite.app/apps/pdfwhisper-ai"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Pdfwhisper-ai.app"

  zap trash: [
    "~/Library/Application Support/pdfwhisper-ai",
    "~/Library/Preferences/com.indiesuite.pdfwhisper-ai.plist",
  ]
end
