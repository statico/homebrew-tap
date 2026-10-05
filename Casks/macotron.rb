cask "macotron" do
  version "0.7.6"
  sha256 "849fdfa6b3a67cd33511e1ff13cf34b4b59609b8c809c5271ffd332d12bd3eb9"

  url "https://github.com/statico/macotron/releases/download/v#{version}/Macotron-#{version}.dmg"
  name "Macotron"
  desc "Customization and automation with a launch bar, hotkeys, and menu bar items"
  homepage "https://macotron.statico.io/"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Macotron updates itself with Sparkle. Without this, brew would offer an
  # upgrade the app has already installed, then disagree about what is there.
  auto_updates true

  depends_on macos: :sequoia

  app "Macotron.app"

  zap trash: [
    "~/Library/Application Support/Macotron",
    "~/Library/Caches/io.statico.macotron",
    "~/Library/Preferences/io.statico.macotron.plist",
    "~/Library/Saved Application State/io.statico.macotron.savedState",
  ]
end
