cask "macotron" do
  version "1.0.2"
  sha256 "ebe2a76f62a26c1db7e77829a0fe0d1d446d2e3e3b1ab9d15d46834d7441c976"

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
