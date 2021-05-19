class Micfix < Formula
  desc "Fix Headset/Headphone Micphone in Hackintosh with AppleALC"
  homepage "https://github.com/WingLim/MicFix"
  url "https://github.com/WingLim/MicFix.git",
      tag:      "v1.1.2",
      revision: "ea2ae830e699b524290fa4b001e56f6546e57ee8"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/winglim/taps"
    sha256 cellar: :any_skip_relocation, catalina: "87659fc44e0ca91fef2b11581956a92c005552af66771938de1c8be173452fb7"
  end

  depends_on xcode: :build

  def install
    xcodebuild "-configuration", "Release", "SYMROOT=build"
    bin.install "build/Release/MicFix"
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
