cask "antiprocrastinate-friction" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/antiprocrastinate-friction-1.0.0.dmg"
  name "Antiprocrastinate-friction"
  desc "10-second deliberate breathing countdown before opening sites"
  homepage "https://indiesuite.app/apps/antiprocrastinate-friction"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Antiprocrastinate-friction.app"

  zap trash: [
    "~/Library/Application Support/antiprocrastinate-friction",
    "~/Library/Preferences/com.indiesuite.antiprocrastinate-friction.plist",
  ]
end
