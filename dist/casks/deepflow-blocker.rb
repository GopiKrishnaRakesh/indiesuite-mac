cask "deepflow-blocker" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/deepflow-blocker-1.0.0.dmg"
  name "Deepflow-blocker"
  desc "Host and DNS-level distraction website and social app blocker"
  homepage "https://indiesuite.app/apps/deepflow-blocker"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Deepflow-blocker.app"

  zap trash: [
    "~/Library/Application Support/deepflow-blocker",
    "~/Library/Preferences/com.indiesuite.deepflow-blocker.plist",
  ]
end
