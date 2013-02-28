require "base64"
require "yaml"

module Strongroom
  class Enigma

    # "ASCII-8BIT" is Ruby's "BINARY" type:
    #   Encoding.aliases["BINARY"] # => "ASCII-8BIT"
    BINARY = "ASCII-8BIT"

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
      Hash[
        to_hash_with_default_encoding.map do |key, value|
          [key.dup.force_encoding(BINARY), value.force_encoding(BINARY)]
        end
      ]
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
      YAML.dump(to_hash).force_encoding(BINARY)
    end

    def self.deserialize input
      from_hash YAML.load(input)
    end

    private

    def to_hash_with_default_encoding
      {
        "cipher" => cipher,
        "ciphertext" => Base64.encode64(ciphertext),
        "encrypted_key" => Base64.encode64(encrypted_key),
        "iv" => Base64.encode64(iv)
      }
    end

  end
end
