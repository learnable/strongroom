require "base64"

module Strongroom
  class Enigma

    def initialize parameters
      @cipher = parameters.fetch :cipher
      @ciphertext = parameters.fetch :ciphertext
      @encrypted_key = parameters.fetch :encrypted_key
      @iv = parameters.fetch :iv
    end

    attr_accessor :cipher, :ciphertext, :encrypted_key, :iv

    def to_s
      keys = [ :ciphertext, :encrypted_key, :iv ]
      "#<Strongroom::Enigma #{cipher} %s>" %
        keys.map { |key| "#{key}: #{send(key).length} bytes" }.join(", ")
    end

    def to_hash
      {
        "cipher" => cipher,
        "ciphertext" => Base64.encode64(ciphertext),
        "encrypted_key" => Base64.encode64(encrypted_key),
        "iv" => Base64.encode64(iv)
      }
    end

    def self.from_hash hash
      new(
        cipher: hash["cipher"],
        ciphertext: Base64.decode64(hash["ciphertext"]),
        encrypted_key: Base64.decode64(hash["encrypted_key"]),
        iv: Base64.decode64(hash["iv"])
      )
    end

    def serialize
      to_hash.to_yaml.encode!("US-ASCII")
    end

    def self.deserialize input
      from_hash YAML.load(input)
    end

  end
end
