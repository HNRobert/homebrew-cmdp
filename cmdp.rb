class Cmdp < Formula
  desc "CMD-Media-Player for Homebrew"
  homepage "https://github.com/HNRobert/CMD-Media-Player"
  
  livecheck do
    url :homepage
    strategy :github_latest
  end
  
  stable do
    version (stable_tag = `git ls-remote --tags --refs --sort=v:refname https://github.com/HNRobert/CMD-Media-Player.git | awk -F '/' '{print $3}' | tail -n1`.chomp)
    url "https://github.com/HNRobert/CMD-Media-Player.git",
        tag:      stable_tag,
        shallow:  true
  end

  license "MIT"

  depends_on "cmake" => :build
  depends_on "opencv"
  depends_on "ffmpeg"
  depends_on "sdl2"
  depends_on "ncurses"
  depends_on "readline"

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
