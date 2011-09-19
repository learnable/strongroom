module Strongroom
  class Decryptor

    include HasRsaKey

    def initialize private_key, cipher_locator = nil
      @cipher_locator = cipher_locator || CipherLocator.new
      has_rsa_key private_key
    end

    def decrypt enigma
      cipher = @cipher_locator.for(enigma)
      cipher.decrypt
      cipher.key = rsa_key.private_decrypt enigma.encrypted_key
      cipher.iv = enigma.iv
      cipher.update(enigma.ciphertext) << cipher.final
    end

    private
    attr_reader :cipher

    class CipherLocator
      def for enigma
        OpenSSL::Cipher.new enigma.cipher
      end
    end

  end
end
