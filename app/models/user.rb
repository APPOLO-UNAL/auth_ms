class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: Denylist

  def on_jwt_dispatch(token, payload)
  log_jwt_dispatch(token, payload)
  end

  private

  # Example method to log the token and payload
  def log_jwt_dispatch(token, payload)
    Rails.logger.info "JWT Token dispatched: #{token}"
    Rails.logger.info "Payload: #{payload.inspect}"
  end

end
