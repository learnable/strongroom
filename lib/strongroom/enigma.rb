class Strongroom
  class Enigma

    def initialize parameters
      @ciphertext = parameters.fetch :ciphertext
      @encrypted_key = parameters.fetch :encrypted_key
      @iv = parameters.fetch :iv
    end

    attr_accessor :ciphertext, :encrypted_key, :iv

  end
end
