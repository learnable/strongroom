require_relative "spec_helper"

describe Strongroom::Encryptor do

  before do
    @cipher = ::MiniTest::Mock.new.tap do |c|
      c.expect :encrypt, nil
      c.expect :random_key, "rkey"
      c.expect :key=, "rkey", [ "rkey" ]
      c.expect :random_iv, "riv"
      c.expect :iv=, "riv", [ "riv" ]
      c.expect :update, "cipherte", [ "input" ]
      c.expect :final, "xt=="
    end
    @key = ::MiniTest::Mock.new.tap do |k|
      k.expect :public_encrypt, "encryptedkey", [ "rkey" ]
    end
  end

  it "calls OpenSSL methods" do
    Strongroom::Encryptor.new(@cipher, @key).encrypt("input")
    [ @cipher, @key ].each &:verify
  end

  it "creates correct Enigma" do
    Strongroom::Encryptor.new(@cipher, @key).encrypt("input").tap do |enigma|
      enigma.ciphertext.must_equal "ciphertext=="
      enigma.encrypted_key.must_equal "encryptedkey"
      enigma.iv.must_equal "riv"
    end
  end

end
