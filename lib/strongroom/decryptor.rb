class Strongroom
  class Decryptor

    def initialize cipher, private_key
      @cipher = cipher
      @private_key = private_key
    end

    def decrypt enigma
      cipher.decrypt
      cipher.key = private_key.private_decrypt enigma.encrypted_key
      cipher.iv = enigma.iv
      cipher.update(enigma.ciphertext) << cipher.final
    end

    private
    attr_reader :cipher, :private_key
  end
end
