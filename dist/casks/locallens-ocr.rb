cask "locallens-ocr" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/locallens-ocr-1.0.0.dmg"
  name "Locallens-ocr"
  desc "Instant screen-to-code, LaTeX, JSON, and table extractor"
  homepage "https://indiesuite.app/apps/locallens-ocr"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Locallens-ocr.app"

  zap trash: [
    "~/Library/Application Support/locallens-ocr",
    "~/Library/Preferences/com.indiesuite.locallens-ocr.plist",
  ]
end
