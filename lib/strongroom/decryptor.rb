class Strongroom
  class Decryptor

    include HasRsaKey

    def initialize cipher, private_key
      @cipher = cipher
      has_rsa_key private_key
    end

    def decrypt enigma
      cipher.decrypt
      cipher.key = rsa_key.private_decrypt enigma.encrypted_key
      cipher.iv = enigma.iv
      cipher.update(enigma.ciphertext) << cipher.final
    end

    private
    attr_reader :cipher
  end
end
