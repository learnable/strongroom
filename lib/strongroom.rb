require "openssl"

require_relative "strongroom/enigma"
require_relative "strongroom/encryptor"
require_relative "strongroom/decryptor"

class Strongroom

  def initialize cipher = nil
    @cipher = cipher
  end

  def encryptor public_key
    Encryptor.new cipher, public_key
  end

  def decryptor private_key
    Decryptor.new cipher, private_key
  end

  private

  def cipher
    @cipher ||= OpenSSL::Cipher.new("AES-128-CFB")
  end

end
