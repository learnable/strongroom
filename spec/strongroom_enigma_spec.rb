require_relative "spec_helper"

describe Strongroom::Enigma do

  def enigma ciphertext = "ct", encrypted_key = "ek", iv = "iv"
    Strongroom::Enigma.new \
      ciphertext: ciphertext,
      encrypted_key: encrypted_key,
      iv: iv
  end

  it "stores ciphertext, encrypted_key, iv" do
    enigma.ciphertext.must_equal "ct"
    enigma.encrypted_key.must_equal "ek"
    enigma.iv.must_equal "iv"
  end

  describe "#to_s" do
    it "returns a string with byte counts" do
      s = enigma("abcd", "12345678", "xzy").to_s
      s.must_equal "#<Strongroom::Enigma ciphertext: 4 bytes, encrypted_key: 8 bytes, iv: 3 bytes>"
    end
  end

end
