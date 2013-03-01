require_relative "spec_helper"

describe Strongroom::HasRsaKey do

  klass = Class.new do
    include Strongroom::HasRsaKey
    def initialize key
      has_rsa_key key
    end
  end

  it "passes through non-String objects" do
    key = Object.new
    klass.new(key).send(:rsa_key).must_equal key
  end

  it "loads RSA key from filepath" do
    key = fixture_path("public_key")
    klass.new(key).send(:rsa_key).must_be_kind_of OpenSSL::PKey::RSA
  end

end
