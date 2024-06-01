class Users::SessionsController < Devise::SessionsController
  before_action :drop_session_cookie
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)

    # Log request headers
    Rails.logger.debug "Request headers: #{request.headers.inspect}"
    # Log request body
    Rails.logger.debug "Request body: #{request.raw_post.inspect}"
    
    if resource.persisted? 
      token = generate_jwt_token(resource) 
      puts "Response: #{response.inspect}"
      puts "User data: #{resource_data(resource)}"
      render json: { message: 'Signed in successfully.', token: token, user: resource_data(resource) }, status: :created
    else
      puts "Response: #{response.inspect}"
      puts "User data: #{resource_data(resource)}"
      render json: { message: 'Failed to authenticate with the provided credentials.' }, status: :unauthorized
    end
  end

  def destroy
    sign_out
    puts "Response: #{response.inspect}"
    puts "User data: #{resource_data(resource)}"
    render json: {}, status: :ok
  end

  private 

  def resource_data(resource)
    {
      id: resource.id,
      email: resource.email,
      nickname: resource.nickname,
      keyIdAuth: resource.keyIdAuth,
    }
  end

  def generate_jwt_token(user)
    payload = { sub: user.id, exp: Time.now.to_i + 1.day.to_i } 
    JWT.encode payload, Rails.application.credentials.devise_jwt_private_key, 'HS256' # Update algorithm if needed
  end 

  def drop_session_cookie
    request.session_options[:skip] = true
  end
end
