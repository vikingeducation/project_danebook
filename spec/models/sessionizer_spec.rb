require 'rails_helper'

describe Sessionizer do
  # attr_reader :params
  #
  # CHAR_MAP = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789!@#$%^&*'
  #
  # def initialize(user, params)
  #   @user = user
  #   @params = params
  # end
  #
  # def create_jwt
  #   data = {auth: 0, id: @user.id, browser: ""}
  #   sql_key = Digest::SHA256.base64digest((0..32).map{ CHAR_MAP.chars.sample }.join)
  #   cookie_key = Digest::SHA256.base64digest((0..32).map{ CHAR_MAP.chars.sample }.join)
  #   sec = Digest::SHA256.base64digest("#{sql_key}#{cookie_key}#{Rails.application.secrets.secret_key_base}")
  #
  #   cookies[:token_key] = cookie_key
  #   @user.token = sql_key
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
  #
  # def failed_attempt
  #   set_failed
  #   @user.last_attempt = Time.now
  #   if locked
  #     flash[:danger] = ["Too many failed attempts.","Your account has been locked for 1 hour for security purposes"]
  #   elsif @user.failed >= 2
  #     flash[:danger] = ["Warning: #{5 - @user.failed} attempts remaining before your account will be put into lockdown mode"]
  #   end
  # end
  #
  # def locked
  #   @user.failed && @user.failed >= 5 && time_limit
  # end
  #
  # def reset_failed
  #   @user.failed = 0
  #   @user.last_attempt = nil
  # end
  #
  # def set_failed
  #   if time_limit
  #     @user.failed += 1
  #   else
  #     @user.failed = 1
  #   end
  # end
  #
  # def time_limit
  #   @user.last_attempt && @user.last_attempt > 1.hour.ago
  # end
  #
  # def valid?
  #   @user && @user.authenticate(params[:password])
  # end
  #
  # def validate_credentials
  #   if locked
  #
  #     flash[:danger] =  [
  #                         "Your account has been locked for due to too many incorrect login attempts.",
  #                         "You may try again in #{(Time.now - @user.last_attempt).strftime("%M")} minutes"
  #                       ]
  #
  #     return "locked"
  #
  #   elsif valid?
  #
  #     reset_failed
  #
  #     return "valid"
  #
  #   else
  #
  #     flash.now[:danger] = ["Incorrect Credentials"]
  #     failed_attempt
  #     "invalid"
  #   end
  # end

end
