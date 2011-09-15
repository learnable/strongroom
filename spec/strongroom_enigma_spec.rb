require_relative "spec_helper"

describe Strongroom::Enigma do

  it "stores ciphertext, encrypted_key, iv" do
    Strongroom::Enigma.new(ciphertext: "ct", encrypted_key: "ek", iv: "iv").tap do |e|
      e.ciphertext.must_equal "ct"
      e.encrypted_key.must_equal "ek"
      e.iv.must_equal "iv"
    end
  end

end
