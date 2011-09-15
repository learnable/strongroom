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
  end

  it "calls OpenSSL methods" do
    Strongroom::Decryptor.new(@cipher, @key).decrypt(@enigma)
    [ @cipher, @key, @enigma ].each &:verify
  end

  it "returns correct plaintext" do
    Strongroom::Decryptor.new(@cipher, @key).decrypt(@enigma).tap do |output|
      output.must_equal "original input"
    end
  end

end
