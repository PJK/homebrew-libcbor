class Libcbor < Formula
  desc "CBOR format implementation for C"
  homepage "http://libcbor.org/"
  url "https://github.com/PJK/libcbor/archive/v0.5.0.tar.gz"
  version "0.5.0"
  sha256 "9bbec94bb385bad3cd2f65482e5d343ddb97e9ffe261123ea0faa3bfea51d320"

  depends_on "cmake" => :build

  def install
   	mkdir "build" do
	    system "cmake", "-G", "Unix Makefiles", "..", *std_cmake_args
	    system "make"
	    system "make", "install"
 	  end
  end

  test do
    (testpath/"example.c").write <<-EOS.undent
      #include "cbor.h"
      #include <stdio.h>

      int main(int argc, char * argv[])
      {
        printf("Hello from libcbor %s\\n", CBOR_VERSION);
        printf("Custom allocation support: %s\\n", CBOR_CUSTOM_ALLOC ? "yes" : "no");
        printf("Pretty-printer support: %s\\n", CBOR_PRETTY_PRINTER ? "yes" : "no");
        printf("Buffer growth factor: %f\\n", (float) CBOR_BUFFER_GROWTH);
      }
    EOS

    system "cc -std=c99 #{(testpath/"example.c")} -lcbor -o example"
    system testpath/"example"
    puts `#{testpath/"example"}`
  end
end
