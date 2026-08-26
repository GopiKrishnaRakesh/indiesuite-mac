cask "brainwave-sync" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/brainwave-sync-1.0.0.dmg"
  name "Brainwave-sync"
  desc "Binaural 40Hz Gamma and Alpha wave generator for hyper-focus"
  homepage "https://indiesuite.app/apps/brainwave-sync"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Brainwave-sync.app"

  zap trash: [
    "~/Library/Application Support/brainwave-sync",
    "~/Library/Preferences/com.indiesuite.brainwave-sync.plist",
  ]
end
