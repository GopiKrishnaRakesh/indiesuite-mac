cask "localembeddings-search" do
  version "1.0.0"
  sha256 :no_check

  url "https://indiesuite.app/downloads/localembeddings-search-1.0.0.dmg"
  name "Localembeddings-search"
  desc "Semantic vector search across local folders using CoreML"
  homepage "https://indiesuite.app/apps/localembeddings-search"

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Localembeddings-search.app"

  zap trash: [
    "~/Library/Application Support/localembeddings-search",
    "~/Library/Preferences/com.indiesuite.localembeddings-search.plist",
  ]
end
