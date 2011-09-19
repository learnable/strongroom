require_relative "spec_helper"

describe Strongroom::Decryptor do

  before do
    @cipher = ::MiniTest::Mock.new.tap do |c|
      c.expect :decrypt, nil
      c.expect :key=, "plainkey", [ "plainkey" ]
      c.expect :iv=, "iv", [ "iv" ]
      c.expect :update, "original inp", [ "ciphertext==" ]
      c.expect :final, "ut"
    end
    @key = ::MiniTest::Mock.new.tap do |k|
      k.expect :private_decrypt, "plainkey", [ "ekey" ]
    end
    @enigma = ::MiniTest::Mock.new.tap do |e|
      e.expect :ciphertext, "ciphertext=="
      e.expect :encrypted_key, "ekey"
      e.expect :iv, "iv"
    end
    @cipher_locator = ::MiniTest::Mock.new.tap do |cl|
      cl.expect :for, @cipher, [ @enigma ]
    end
  end

  it "calls OpenSSL methods" do
    Strongroom::Decryptor.new(@key, @cipher_locator).decrypt(@enigma)
    [ @cipher, @key, @enigma ].each &:verify
  end

  it "returns correct plaintext" do
    Strongroom::Decryptor.new(@key, @cipher_locator).decrypt(@enigma).tap do |output|
      output.must_equal "original input"
    end
  end

end
