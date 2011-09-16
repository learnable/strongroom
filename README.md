Strongroom
==========

Strong public-key encryption for arbitrary length data.


Overview
--------

Strongroom combines RSA public-key encryption and AES symmetric-key encryption to encrypt arbitrary length data with a public key, such that it can only be decrypted with the corresponding private key.

Ruby's OpenSSL bindings do all the heavy lifting; Strongroom acts as simple glue-code and as a central point for testing, documentation, collaboration and peer review.


Usage
-----

```ruby
# Encrypt with public key:
public_key = OpenSSL::PKey::RSA.new(File.read("public_key"))
enigma = Strongroom.new.encryptor(public_key).encrypt("secret message")
# => #<Strongroom::Enigma:0x007fb7dc80e878>

# Decrypt with private key:
private_key = OpenSSL::PKey::RSA.new(File.read("private_key"))
Strongroom.new.decryptor(private_key).decrypt(enigma)
# => "secret message"
```


Status
------

[![http://travis-ci.org/pda/strongroom.png](http://travis-ci.org/pda/strongroom.png)](http://travis-ci.org/#!/pda/strongroom)

Implementation is functionally complete. Documentation is work in progress.


Reading List
------------

* [Hybrid cryptosystem](http://en.wikipedia.org/wiki/Hybrid_cryptosystem)
* [Advanced Encryption Standard](http://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
* [RSA public-key encryption](http://en.wikipedia.org/wiki/RSA)
* [Block cipher modes of operation](http://en.wikipedia.org/wiki/Block_cipher_modes_of_operation)
* [OWASP Cryptographic Storage Cheat Sheet](https://www.owasp.org/index.php/Cryptographic_Storage_Cheat_Sheet)
* [OpenSSL::Cipher (Ruby stdlib)](http://ruby-doc.org/stdlib/libdoc/openssl/rdoc/classes/OpenSSL/Cipher.html)
* [OpenSSL::PKey::RSA (Ruby stdlib)](http://ruby-doc.org/stdlib/libdoc/openssl/rdoc/classes/OpenSSL/PKey/RSA.html)


License
-------

© 2011 Learnable Pty Ltd  
Open Source under the [The MIT License](http://www.opensource.org/licenses/mit-license.php).
