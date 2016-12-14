class Crypt
  class << self
    def crypt
      @crypt ||= ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    end

    def decrypt(msg)
      crypt.decrypt_and_verify(msg)
    end

    def encrypt(msg)
      crypt.encrypt_and_sign(msg)
    end
  end

end
