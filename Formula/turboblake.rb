class Turboblake < Formula
  desc "BLAKE3 checksums, turbocharged: a drop-in b3sum with a Bend2 engine"
  homepage "https://gunta.github.io/turboblake/"
  license any_of: [
    "CC0-1.0",
    "Apache-2.0",
    { "Apache-2.0" => { with: "LLVM-exception" } },
  ]

  on_macos do
    on_arm do
      url "https://github.com/gunta/turboblake/releases/download/turboblake-v1.8.7/turboblake-1.8.7-aarch64-apple-darwin.tar.gz"
      sha256 "14f851a4e6ff56fed75ac3c74f702c470710dd11f440a5b09da0cd293dad1c89"
    end
    on_intel do
      url "https://github.com/gunta/turboblake/releases/download/turboblake-v1.8.7/turboblake-1.8.7-x86_64-apple-darwin.tar.gz"
      sha256 "6a9bda4bc167e2084567d976fbc6a6d02e89c09f77ac32f4236a418a29dfcdfc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/gunta/turboblake/releases/download/turboblake-v1.8.7/turboblake-1.8.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3b061e27430ac9b244ddd01b74bc2d2f360246429f36845ab62fb282afa91e67"
    end
    on_intel do
      url "https://github.com/gunta/turboblake/releases/download/turboblake-v1.8.7/turboblake-1.8.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1721e836c74b3a1c84db042842987f26cd0e21a9e02770f5d36505b6566431a"
    end
  end

  def install
    bin.install "turboblake"
  end

  test do
    (testpath/"hello.txt").write "hello, world"
    digest = "a1a55887535397bf461902491c8779188a5dd1f8c3951b3d9cf6ecba194e87b0"
    assert_equal "#{digest}  hello.txt", shell_output("#{bin}/turboblake hello.txt").strip
    (testpath/"B3SUMS").write "#{digest}  hello.txt\n"
    assert_equal "hello.txt: OK", shell_output("#{bin}/turboblake --check B3SUMS").strip
    assert_match version.to_s, shell_output("#{bin}/turboblake --version")
  end
end
