class Nali < Formula
  desc "Offline tool for querying IP geographic information and CDN provider"
  homepage "https://nali.lgf.im"
  url "https://github.com/zu1k/nali.git",
      tag:      "v0.2.4",
      revision: "27600d4af33ce9ebd5119f466ff713c7526cea21"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/winglim/taps"
    sha256 cellar: :any_skip_relocation, catalina: "d5c3c67a68827949bdea8597f29b7c49b8e7e77e88373a2afe5e04349bb980e2"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "Usage", shell_output("#{bin}/nali -h")
  end
end
