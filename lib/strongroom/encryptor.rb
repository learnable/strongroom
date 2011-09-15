class Strongroom
  class Encryptor

    def initialize cipher, public_key
      @public_key = public_key
      @cipher = cipher
    end

    def encrypt input
      key = cipher.random_key
      iv = cipher.random_iv

      cipher.encrypt
      cipher.key = key
      cipher.iv = iv

      Enigma.new \
        ciphertext: cipher.update(input) << cipher.final,
        encrypted_key: public_key.public_encrypt(key),
        iv: iv
    end

    private
    attr_reader :cipher, :public_key
  end
end
