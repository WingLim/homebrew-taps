class Nali < Formula
  desc "Offline tool for querying IP geographic information and CDN provider"
  homepage "https://nali.lgf.im"
  url "https://github.com/zu1k/nali.git",
      tag:      "v0.2.4",
      revision: "27600d4af33ce9ebd5119f466ff713c7526cea21"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/winglim/taps"
    sha256 cellar: :any_skip_relocation, catalina: "c0debb14287e471a302abe2ce2663670bffeb88c816f2718a5a375e5a097dec8"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args
  end

  test do
    assert_match "Usage", shell_output("#{bin}/nali -h")
  end
end
