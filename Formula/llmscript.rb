class Llmscript < Formula
  desc "Write your shell scripts in natural language"
  homepage "https://github.com/statico/llmscript"
  url "https://github.com/statico/llmscript/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "b9f28769ffddf86b4a9ddcaab6808bdf9ee7c6fd92ca65bb7876bf9834c448cb"
  license "MIT"
  head "https://github.com/statico/llmscript.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(output: bin/"llmscript"), "./cmd/llmscript"
  end

  def caveats
    <<~EOS
      llmscript needs an LLM provider. Write a starter config with:
        llmscript --write-config

      Then edit ~/.config/llmscript/config.yaml to pick a provider
      (ollama, claude, openai, gemini, or openrouter) and set its API key.
    EOS
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/llmscript --help 2>&1")
    assert_match "-llm.provider", shell_output("#{bin}/llmscript --help 2>&1")

    # Writing the default config needs no provider or network access.
    system bin/"llmscript", "--write-config"
    assert_path_exists testpath/".config/llmscript/config.yaml"
  end
end
