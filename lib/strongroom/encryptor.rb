module Strongroom
  class Encryptor

    include HasRsaKey

    def initialize public_key, cipher = nil
      @cipher = cipher if cipher
      has_rsa_key public_key
    end

    def encrypt input
      key = cipher.random_key
      iv = cipher.random_iv

      cipher.encrypt
      cipher.key = key
      cipher.iv = iv

      Enigma.new \
        cipher: cipher.name,
        ciphertext: cipher.update(input) << cipher.final,
        encrypted_key: rsa_key.public_encrypt(key),
        iv: iv
    end

    private

    def cipher
      @cipher ||= OpenSSL::Cipher.new("AES-128-CBC")
    end

  end
end
