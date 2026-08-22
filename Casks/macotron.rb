cask "macotron" do
  version "0.2.0"
  sha256 "b6f101e5157c15ffb4c444af4ef553ff1d89516f1b08f2274c7e14011355fb69"

  url "https://github.com/statico/macotron/releases/download/v#{version}/Macotron-#{version}.dmg"
  name "Macotron"
  desc "Scriptable macOS automation with JavaScript plugins"
  homepage "https://macotron.statico.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sequoia

  app "Macotron.app"

  zap trash: [
    "~/Library/Application Support/Macotron",
    "~/Library/Preferences/io.statico.macotron.plist",
    "~/Library/Saved Application State/io.statico.macotron.savedState",
  ]
end
