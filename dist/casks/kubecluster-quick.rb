cask "kubecluster-quick" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/kubecluster-quick-1.0.0.dmg"
  name "Kubecluster-quick"
  desc "Minimalist Kubernetes cluster status watcher with pod logs"
  homepage "https://indiesuite.app/apps/kubecluster-quick"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Kubecluster-quick.app"

  zap trash: [
    "~/Library/Application Support/kubecluster-quick",
    "~/Library/Preferences/com.indiesuite.kubecluster-quick.plist",
  ]
end
