cask "archiveextractor" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/archiveextractor-1.0.0.dmg"
  name "Archiveextractor"
  desc "Ultra-fast unarchiver supporting 7z, RAR, TAR, GZ, ISO"
  homepage "https://indiesuite.app/apps/archiveextractor"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Archiveextractor.app"

  zap trash: [
    "~/Library/Application Support/archiveextractor",
    "~/Library/Preferences/com.indiesuite.archiveextractor.plist",
  ]
end
