class CmdMediaPlayer < Formula
  desc "CMD-Media-Player for Homebrew"
  homepage "https://github.com/HNRobert/homebrew-cmdp"
  url "https://github.com/HNRobert/CMD-Media-Player/archive/refs/tags/v1.0.1-beta.2.tar.gz"
  sha256 "30c9fdfb56926cfbb10dd64a1d607c3ff6ba74dd9664e7cd61705928b6f7a18f"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "opencv"
  depends_on "ffmpeg"
  depends_on "sdl2"
  depends_on "ncurses"
  depends_on "readline"

  def install
    args = std_cmake_args

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end

    bin.install_symlink "cmd-media-player" => "cmdp"
  end

  test do
    assert_predicate bin/"cmd-media-player", :exist?
    assert_predicate bin/"cmdp", :exist?
    assert_match "CMD-Media-Player version", shell_output("#{bin}/cmd-media-player --version")
    assert_match "Usage:", shell_output("#{bin}/cmdp --help")
  end
end
