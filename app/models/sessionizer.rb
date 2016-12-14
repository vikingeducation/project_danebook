class Sessionizer
  class << self

    def validate_credentials(user, password)
      @user = user
      @password = password

      if locked

        return "locked"

      elsif valid?

        reset_failed

        return "valid"

      else

        failed_attempt

        "invalid"

      end
    end

    private
      CHAR_MAP = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789!@#$%^&*'

      # TODO: Implement JWT tokens for multi browser login
      # def create_jwt
      #   data = {auth: 0, id: @user.id, browser: ""}
      #   sql_key = Digest::SHA256.base64digest((0..32).map{ CHAR_MAP.chars.sample }.join)
      #   cookie_key = Digest::SHA256.base64digest((0..32).map{ CHAR_MAP.chars.sample }.join)
      #   sec = Digest::SHA256.base64digest("#{sql_key}#{cookie_key}#{Rails.application.secrets.secret_key_base}")
      #
      #   cookies[:token_key] = cookie_key
      #   @user.token = sql_key
      #   @user.save
      #
      #   exp = Time.now.to_i + 4 * 3600
      #   iss = 'Project Danbook'
      #   iat = Time.now.to_i
      #   jti_raw = [sec, iat].join(':').to_s
      #   jti = Digest::MD5.hexdigest(jti_raw)
      #   nbf = Time.now.to_i + 10
      #   payload = { data: data, exp: exp, iat: iat, jti: jti, nbf: nbf }
      #
      #   cookies[:token] = JWT.encode payload, sec, 'HS256'
      # end

      def failed_attempt
        if time_limit
          @user.failed += 1
        else
          @user.failed = 1
        end
        @user.last_attempt = Time.now
        @user.save
      end

      def locked
        @user.failed && @user.failed >= 5 && time_limit
      end

      def reset_failed
        @user.failed = 0
        @user.last_attempt = nil
        @user.save
      end

      def time_limit
        @user.last_attempt && @user.last_attempt > 1.hour.ago
      end

      def valid?
        @user && @user.authenticate(@password)
      end

  end
end
