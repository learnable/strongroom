require_relative "spec_helper"

describe Strongroom do

  describe "round trip encryption" do

    # generate a key pair in memory
    def key_pair
      Struct.new(:private, :public).new(
        pk = OpenSSL::PKey::RSA.new(1024),
        pk.public_key
      )
    end

    { short: 16, medium: 16 * 1024, long: 2**20 }.each do |name, length|

      describe "with #{name} input (#{length} bytes)" do
        before do
          @input = "abcd1234" * (length / 8)
          @input.length.must_equal length
        end

        it "round-trips with real Cipher and RSA keys" do
          key = key_pair
          enigma = Strongroom::Encryptor.new(key.public).encrypt(@input)
          output = Strongroom::Decryptor.new(key.private).decrypt(enigma)
          output.must_equal @input
        end
      end

    end

  end
end
