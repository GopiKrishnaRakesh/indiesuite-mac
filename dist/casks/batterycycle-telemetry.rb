cask "batterycycle-telemetry" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/batterycycle-telemetry-1.0.0.dmg"
  name "Batterycycle-telemetry"
  desc "Deep SMC battery analytics"
  homepage "https://indiesuite.app/apps/batterycycle-telemetry"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Batterycycle-telemetry.app"

  zap trash: [
    "~/Library/Application Support/batterycycle-telemetry",
    "~/Library/Preferences/com.indiesuite.batterycycle-telemetry.plist",
  ]
end
