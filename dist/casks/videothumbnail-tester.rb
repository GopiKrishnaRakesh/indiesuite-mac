cask "videothumbnail-tester" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/videothumbnail-tester-1.0.0.dmg"
  name "Videothumbnail-tester"
  desc "Previews thumbnails on light/dark mode social feed mocks"
  homepage "https://indiesuite.app/apps/videothumbnail-tester"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Videothumbnail-tester.app"

  zap trash: [
    "~/Library/Application Support/videothumbnail-tester",
    "~/Library/Preferences/com.indiesuite.videothumbnail-tester.plist",
  ]
end
