require_relative "spec_helper"

describe Strongroom::Decryptor do

  before do
    @cipher = ::MiniTest::Mock.new
    @cipher.expect :decrypt, nil
    @cipher.expect :key=, "plainkey", [ "plainkey" ]
    @cipher.expect :iv=, "iv", [ "iv" ]
    @cipher.expect :update, "original inp", [ "ciphertext==" ]
    @cipher.expect :final, "ut"

    @key = ::MiniTest::Mock.new
    def @key.is_a?(type); false; end
    @key.expect :private_decrypt, "plainkey", [ "ekey" ]

    @enigma = ::MiniTest::Mock.new
    @enigma.expect :ciphertext, "ciphertext=="
    @enigma.expect :encrypted_key, "ekey"
    @enigma.expect :iv, "iv"

    @cipher_locator = ::MiniTest::Mock.new
    @cipher_locator.expect :for, @cipher, [ @enigma ]
  end

  it "calls OpenSSL methods" do
    Strongroom::Decryptor.new(@key, @cipher_locator).decrypt(@enigma)
    [ @cipher, @key, @enigma ].each &:verify
  end

  it "uses cipher_locator" do
    Strongroom::Decryptor.new(@key, @cipher_locator).decrypt(@enigma)
    @cipher_locator.verify
  end

  it "returns correct plaintext" do
    Strongroom::Decryptor.new(@key, @cipher_locator).decrypt(@enigma).tap do |output|
      output.must_equal "original input"
    end
  end

end
