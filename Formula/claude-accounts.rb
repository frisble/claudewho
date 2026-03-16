# typed: false
# frozen_string_literal: true

class ClaudeAccounts < Formula
  desc "Manage multiple Claude Code account configurations"
  homepage "https://github.com/frisble/claude-accounts"
  url "https://github.com/frisble/claude-accounts/archive/refs/tags/1.0.0.tar.gz"
  sha256 "5abe616fe108be2637e4021ba3853d37403212a5c197d477db054addf6383fd2"
  license "MIT"
  head "https://github.com/frisble/claude-accounts.git", branch: "main"

  def install
    bin.install "bin/claude-accounts"
  end

  def caveats
    <<~EOS
      To enable account aliases, add this line to your shell config:

        For zsh (~/.zshrc):
          eval "$(claude-accounts shell-init)"

        For bash (~/.bashrc):
          eval "$(claude-accounts shell-init)"

      Then reload your shell:
        source ~/.zshrc  # or source ~/.bashrc

      Quick start:
        claude-accounts add work      # Create 'work' account
        claude-accounts add personal  # Create 'personal' account
        source ~/.zshrc               # Reload shell
        claude-work                   # Launch Claude with 'work' account

      For more information:
        claude-accounts help
    EOS
  end

  test do
    assert_match "claude-accounts #{version}", shell_output("#{bin}/claude-accounts version")
    assert_match "Configured Claude accounts:", shell_output("#{bin}/claude-accounts list 2>&1", 0)
  end
end
