cask "nethack-tiles-client" do
  version "0.1.8"
  sha256 "cd13e5a4534fbf9271b3be8d708861007944d3bd051999f2e12805252b72e01e"

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
