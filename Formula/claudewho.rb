# typed: false
# frozen_string_literal: true

class Claudewho < Formula
  desc "Manage multiple Claude Code account configurations"
  homepage "https://github.com/frisble/claudewho"
  url "https://github.com/frisble/claudewho/archive/refs/tags/2.0.2.tar.gz"
  sha256 "17ff958e7574cf5f382849b473da5d785b35fe2d056956074d5d12a0f6a39862"
  license "MIT"
  head "https://github.com/frisble/claudewho.git", branch: "main"

  def install
    bin.install "bin/claudewho"
  end

  def caveats
    <<~EOS
      To enable account aliases, add this line to your shell config:

        For zsh (~/.zshrc):
          eval "$(claudewho shell-init)"

        For bash (~/.bashrc):
          eval "$(claudewho shell-init)"

      Then reload your shell:
        source ~/.zshrc  # or source ~/.bashrc

      Quick start:
        claudewho add work      # Create 'work' account
        claudewho add personal  # Create 'personal' account
        source ~/.zshrc         # Reload shell
        claudewho-work          # Launch Claude with 'work' account

      For more information:
        claudewho help
    EOS
  end

  test do
    assert_match "claudewho #{version}", shell_output("#{bin}/claudewho version")
    assert_match "Configured Claude accounts:", shell_output("#{bin}/claudewho list 2>&1", 0)
  end
end
