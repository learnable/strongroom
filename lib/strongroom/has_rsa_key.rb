class Strongroom
  module HasRsaKey

    private

    attr_reader :rsa_key

    def has_rsa_key key
      @rsa_key = key
    end

    attr_reader :rsa_key

  end
end
