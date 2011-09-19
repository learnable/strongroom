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

  describe "#to_hash" do
    it "returns hash with string keys for easy serialization" do
      enigma.to_hash.tap do |h|
        h["ciphertext"].must_equal "ct"
        h["encrypted_key"].must_equal "ek"
        h["iv"].must_equal "iv"
      end
    end
  end

  describe ".from_hash" do
    it "accepts hash with string keys for easy deserialization" do
      hash = {
        "ciphertext" => "test_ct",
        "encrypted_key" => "test_ek",
        "iv" => "test_iv"
      }
      Strongroom::Enigma.from_hash(hash).tap do |e|
        e.ciphertext.must_equal "test_ct"
        e.encrypted_key.must_equal "test_ek"
        e.iv.must_equal "test_iv"
      end
    end
  end

end
