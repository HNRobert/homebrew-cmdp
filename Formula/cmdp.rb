class Cmdp < Formula
  desc "CMD-Media-Player for Homebrew"
  homepage "https://github.com/HNRobert/homebrew-cmdp"
  url "https://github.com/HNRobert/CMD-Media-Player/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "8f225bf994822b7ef6912284046b979c96c5c4c4ebb595175444915a94c9633e"

  license "MIT"

  depends_on "cmake" => :build
  depends_on "ffmpeg"
  depends_on "ncurses"
  depends_on "opencv"
  depends_on "readline"
  depends_on "sdl2"

  def install
    args = std_cmake_args
    system "cmake", ".", *args
    system "make", "install"

    bin.install_symlink "cmd-media-player" => "cmdp"
  end

  test do
    assert_predicate bin/"cmd-media-player", :exist?
    assert_predicate bin/"cmdp", :exist?
    assert_match "CMD-Media-Player version", shell_output("#{bin}/cmd-media-player --version")
    assert_match "Usage:", shell_output("#{bin}/cmdp --help")
  end
end
