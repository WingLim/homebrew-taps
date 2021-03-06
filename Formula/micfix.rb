class Micfix < Formula
  desc "Fix Headset/Headphone Micphone in Hackintosh with AppleALC"
  homepage "https://github.com/WingLim/MicFix"
  url "https://github.com/WingLim/MicFix.git",
      tag:      "v1.2.0",
      revision: "81a73926e549dab7461d9f76d200a6f3a98e82b2"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/winglim/taps"
    sha256 cellar: :any_skip_relocation, catalina: "0646bdb71cad944ff318deb8ead3b73fe5e28f7734e496addfaedcc38e28146d"
  end

  depends_on xcode: :build

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/MicFix"
  end

  plist_options manual: "MicFix"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>KeepAlive</key>
          <true/>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/MicFix</string>
          </array>
          <key>StandardErrorPath</key>
          <string>/dev/null</string>
          <key>StandardOutPath</key>
          <string>/dev/null</string>
        </dict>
      </plist>
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/MicFix version")
  end
end
