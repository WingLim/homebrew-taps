class Micfix < Formula
  desc "Fix Headset/Headphone Micphone in Hackintosh with AppleALC"
  homepage "https://github.com/WingLim/MicFix"
  url "https://github.com/WingLim/MicFix.git",
      tag:      "v1.1.3",
      revision: "e38a3746f59b610d7c2e015f57fe7ad93424715a"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/winglim/taps"
    sha256 cellar: :any_skip_relocation, catalina: "34abd1ae69816ffe499328af2c7f6d5d923cbcc9935aac5b2c2bf3dae144d5ce"
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
