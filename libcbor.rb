class Libcbor < Formula
  desc "CBOR format implementation for C"
  homepage "http://libcbor.org/"
  url "https://github.com/PJK/libcbor/archive/v0.4.0.tar.gz"
  version "0.4.0"
  sha256 "1b61e6eba2b5b18b5ec1a29161ad7037689464e77a4ad6cc1c084f888b531acf"

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
