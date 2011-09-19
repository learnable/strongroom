class Strongroom
  class Enigma

    def initialize parameters
      @ciphertext = parameters.fetch :ciphertext
      @encrypted_key = parameters.fetch :encrypted_key
      @iv = parameters.fetch :iv
    end

    attr_accessor :ciphertext, :encrypted_key, :iv

    def to_s
      keys = [ :ciphertext, :encrypted_key, :iv ]
      "#<Strongroom::Enigma %s>" %
        keys.map { |key| "#{key}: #{send(key).length} bytes" }.join(", ")
    end

    def to_hash
      {
        "ciphertext" => ciphertext,
        "encrypted_key" => encrypted_key,
        "iv" => iv
      }
    end

    def self.from_hash hash
      new(
        ciphertext: hash["ciphertext"],
        encrypted_key: hash["encrypted_key"],
        iv: hash["iv"]
      )
    end

  end
end
