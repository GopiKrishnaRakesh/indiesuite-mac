cask "caffeinedecay-curve" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/caffeinedecay-curve-1.0.0.dmg"
  name "Caffeinedecay-curve"
  desc "Calculates active caffeine in bloodstream with cutoff warnings"
  homepage "https://indiesuite.app/apps/caffeinedecay-curve"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Caffeinedecay-curve.app"

  zap trash: [
    "~/Library/Application Support/caffeinedecay-curve",
    "~/Library/Preferences/com.indiesuite.caffeinedecay-curve.plist",
  ]
end
