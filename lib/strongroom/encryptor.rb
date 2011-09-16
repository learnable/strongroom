class Strongroom
  class Encryptor

    include HasRsaKey

    def initialize cipher, public_key
      @cipher = cipher
      has_rsa_key public_key
    end

    def encrypt input
      key = cipher.random_key
      iv = cipher.random_iv

      cipher.encrypt
      cipher.key = key
      cipher.iv = iv

      Enigma.new \
        ciphertext: cipher.update(input) << cipher.final,
        encrypted_key: rsa_key.public_encrypt(key),
        iv: iv
    end

    private
    attr_reader :cipher
  end
end
