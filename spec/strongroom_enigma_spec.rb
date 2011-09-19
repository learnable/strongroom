require_relative "spec_helper"

describe Strongroom::Enigma do

  # binary guaranteed to be invalid as US-ASCII or UTF-8
  def binary input
    "\xFF" << input
  end

  # input has non-valid-character-encoding byte added, then base64 encoded
  def bin64 input
    Base64.encode64 binary(input)
  end

  def enigma ciphertext = "ct", encrypted_key = "ek", iv = "iv"
    Strongroom::Enigma.new \
      cipher: "AES-128-TEST",
      ciphertext: binary(ciphertext),
      encrypted_key: binary(encrypted_key),
      iv: binary(iv)
  end

  it "stores ciphertext, encrypted_key, iv" do
    enigma.ciphertext.must_equal binary("ct")
    enigma.encrypted_key.must_equal binary("ek")
    enigma.iv.must_equal binary("iv")
  end

  describe "#to_s" do
    it "returns a string with byte counts" do
      s = enigma("abc", "1234567", "xz").to_s
      s.must_equal "#<Strongroom::Enigma AES-128-TEST ciphertext: 4 bytes, encrypted_key: 8 bytes, iv: 3 bytes>"
    end
  end

  describe "#to_hash" do
    it "has string keys, binary values base64 encoded" do
      enigma.to_hash.tap do |h|
        h["cipher"].must_equal "AES-128-TEST"
        h["ciphertext"].must_equal bin64("ct")
        h["encrypted_key"].must_equal bin64("ek")
        h["iv"].must_equal bin64("iv")
      end
    end
    it "has US-ASCII keys and values" do
      enigma.to_hash.tap do |h|
        h.each do |key, value|
          key.encoding.name.must_equal "US-ASCII"
          key.valid_encoding?.must_equal true
          value.encoding.name.must_equal "US-ASCII"
          value.valid_encoding?.must_equal true
        end
      end
    end
  end

  describe ".from_hash" do
    it "accepts hash with string keys for easy deserialization" do
      hash = {
        "cipher" => "AES-128-TEST",
        "ciphertext" => bin64("test_ct"),
        "encrypted_key" => bin64("test_ek"),
        "iv" => bin64("test_iv")
      }
      Strongroom::Enigma.from_hash(hash).tap do |e|
        e.cipher.must_equal "AES-128-TEST"
        e.ciphertext.must_equal binary("test_ct")
        e.encrypted_key.must_equal binary("test_ek")
        e.iv.must_equal binary("test_iv")
      end
    end
  end

  describe "#serialize" do
    def s; enigma.serialize; end
    it "returns a String" do
      s.must_be_kind_of String
    end
    it "is not empty" do
      s.wont_be_empty
    end
    it "has is valid US-ASCII" do
      s.encoding.name.must_equal "US-ASCII"
      s.valid_encoding?.must_equal true
    end
  end

  describe ".deserialize" do
    it "correctly deserializes output from #serialize" do
      Strongroom::Enigma.deserialize(enigma.serialize).tap do |e|
        e.cipher.must_equal "AES-128-TEST"
        e.ciphertext.must_equal binary("ct")
        e.encrypted_key.must_equal binary("ek")
        e.iv.must_equal binary("iv")
      end
    end
  end

end
