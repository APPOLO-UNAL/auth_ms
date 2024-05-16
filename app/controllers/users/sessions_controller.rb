class Users::SessionsController < Devise::SessionsController
  before_action :drop_session_cookie
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)

    if resource.persisted? 
      token = generate_jwt_token(resource) 
      render json: { message: 'Signed in successfully.', token: token, user: resource }, status: :created
    else
      render json: { message: 'Failed to authenticate with the provided credentials.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out
    render json: {}, status: :ok
  end

  private 

  def generate_jwt_token(user)
    payload = { sub: user.id, exp: Time.now.to_i + 1.day.to_i } 
    # Use the appropriate algorithm based on your devise-jwt setup 
    JWT.encode payload, Rails.application.credentials.devise_jwt_private_key, 'HS256' # Update algorithm if needed
  end 

  def drop_session_cookie
    request.session_options[:skip] = true
  end
end
