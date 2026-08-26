cask "gradientmesh-maker" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/gradientmesh-maker-1.0.0.dmg"
  name "Gradientmesh-maker"
  desc "Visual multi-point gradient mesh generator with SwiftUI export"
  homepage "https://indiesuite.app/apps/gradientmesh-maker"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Gradientmesh-maker.app"

  zap trash: [
    "~/Library/Application Support/gradientmesh-maker",
    "~/Library/Preferences/com.indiesuite.gradientmesh-maker.plist",
  ]
end
