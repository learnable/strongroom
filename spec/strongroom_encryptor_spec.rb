require_relative "spec_helper"

describe Strongroom::Encryptor do

  before do
    @cipher = ::MiniTest::Mock.new
    @cipher.expect :name, "AES-128-TEST"
    @cipher.expect :encrypt, nil
    @cipher.expect :random_key, "rkey"
    @cipher.expect :key=, "rkey", [ "rkey" ]
    @cipher.expect :random_iv, "riv"
    @cipher.expect :iv=, "riv", [ "riv" ]
    @cipher.expect :update, "cipherte", [ "input" ]
    @cipher.expect :final, "xt=="

    @key = ::MiniTest::Mock.new
    def @key.is_a?(type); false; end
    @key.expect :public_encrypt, "encryptedkey", [ "rkey" ]
  end

  it "calls OpenSSL methods" do
    Strongroom::Encryptor.new(@key, @cipher).encrypt("input")
    [ @cipher, @key ].each &:verify
  end

  it "creates correct Enigma" do
    Strongroom::Encryptor.new(@key, @cipher).encrypt("input").tap do |enigma|
      enigma.ciphertext.must_equal "ciphertext=="
      enigma.encrypted_key.must_equal "encryptedkey"
      enigma.iv.must_equal "riv"
      enigma.cipher.must_equal "AES-128-TEST"
    end
  end

end
