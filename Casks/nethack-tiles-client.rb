cask "nethack-tiles-client" do
  version "0.1.1"
  sha256 "48d1f9b83c0cade58bd15fa4c4eac34e7c99dd2a8c0f46c5aed1697c172271ca"

  url "https://github.com/statico/nethack-tiles-client/releases/download/v#{version}/NetHack.Tiles.Client_#{version}_universal.dmg"
  name "NetHack Tiles Client"
  desc "Play NetHack on the public servers with graphical tiles"
  homepage "https://github.com/statico/nethack-tiles-client"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "NetHack Tiles Client.app"

  zap trash: [
    "~/Library/Application Support/io.statico.nethack-tiles",
    "~/Library/Saved Application State/io.statico.nethack-tiles.savedState",
  ]

  caveats do
    <<~EOS
      Saved server passwords live in the login keychain, not in a file, so they
      survive an uninstall and are not removed by `brew uninstall --zap`.
    EOS
  end
end
