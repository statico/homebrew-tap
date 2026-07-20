class Llmac < Formula
  desc "Apple's on-device Foundation Models from the command-line"
  homepage "https://github.com/statico/llmac"
  url "https://github.com/statico/llmac/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "c49b3a784fd68e68318bb24c89ab9830e6c22b8fc677958cf4a4bf1c4b2a4033"
  license "MIT"
  head "https://github.com/statico/llmac.git", branch: "main"

  # FoundationModels ships with macOS 26, and the package declares .macOS(.v26).
  depends_on xcode: ["26.0", :build]
  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    # Homebrew stages source in /private/tmp, where Santa-managed Macs may not
    # execute SwiftPM's compiled package manifest or build products.
    build_root = prefix/"swift-build"
    tmp_dir = build_root/"tmp"
    tmp_dir.mkpath
    ENV["TMPDIR"] = tmp_dir
    ENV["SWIFTPM_MODULECACHE_OVERRIDE"] = build_root/"module-cache"

    system "swift", "build", "--disable-sandbox", "-c", "release",
           "--scratch-path", build_root/"scratch",
           "--cache-path", build_root/"cache"
    bin.install build_root/"scratch/release/llmac"
    rm_r build_root
    generate_completions_from_executable(bin/"llmac", "--generate-completion-script")
  end

  def caveats
    <<~EOS
      llmac needs Apple Intelligence enabled:
        System Settings > Apple Intelligence & Siri

      Shell helpers (`ask` and `cmd`):
        eval "$(llmac shell-init zsh)"     # zsh
        llmac shell-init fish | source     # fish
    EOS
  end

  test do
    assert_match "llmac", shell_output("#{bin}/llmac --help")
    assert_match "0.1.0", shell_output("#{bin}/llmac --version")
    # Model configurations are a static catalog, so this works without Apple Intelligence.
    assert_match "content-tagging", shell_output("#{bin}/llmac models")
    assert_match "ask()", shell_output("#{bin}/llmac shell-init zsh")
  end
end
