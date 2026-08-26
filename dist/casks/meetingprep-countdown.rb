cask "meetingprep-countdown" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/meetingprep-countdown-1.0.0.dmg"
  name "Meetingprep-countdown"
  desc "Popover chime 2 minutes before calls with 1-click join link"
  homepage "https://indiesuite.app/apps/meetingprep-countdown"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Meetingprep-countdown.app"

  zap trash: [
    "~/Library/Application Support/meetingprep-countdown",
    "~/Library/Preferences/com.indiesuite.meetingprep-countdown.plist",
  ]
end
