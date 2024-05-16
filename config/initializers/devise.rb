Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth, :params_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other

  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.devise_jwt_private_key
    jwt.decoding_secret = Rails.application.credentials.devise_jwt_public_key

    jwt.dispatch_requests = [
      ['POST', %r{^/api/v1/sign_in$}],  # Adjusted for sign-in endpoint
      ['POST', %r{^/api/v1/sign_up$}]   # Added for sign-up endpoint
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/api/v1/sign_out$}]  # Adjusted for sign-out endpoint
    ]
    jwt.expiration_time = 1.day.to_i
    jwt.aud_header = 'JWT_AUD'  # Use default aud_header
  end
  
end
