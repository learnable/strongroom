module Strongroom
  module HasRsaKey

    private

    attr_reader :rsa_key

    def has_rsa_key key
      @rsa_key = resolve_rsa_key key
    end

    def resolve_rsa_key key
      if key.is_a? String
        OpenSSL::PKey::RSA.new(File.read(key))
      else
        key
      end
    end

  end
end
