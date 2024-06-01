class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    # Log request headers
    Rails.logger.debug "Request headers: #{request.headers.inspect}"
    # Log request body
    Rails.logger.debug "Request body: #{request.raw_post.inspect}"
    
    build_resource(sign_up_params)
    puts "Sign up params: #{sign_up_params}"

    if resource.save  
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        token = generate_jwt_token(resource)
      puts "Response: #{response.inspect}"
      puts "User data: #{resource_data(resource)}"
        render json: { message: 'Signed up successfully.', token: token, user: resource_data(resource) }, status: :created  
      else
        expire_data_after_sign_in!
        puts "Response: #{response.inspect}"
        puts "User data: #{resource_data(resource)}"
        render json: { message: "Signed up successfully. Please confirm your email address.", user: resource_data(resource) }, status: :ok
      end
    else 
      clean_up_passwords resource
      set_minimum_password_length
      puts "Response: #{response.inspect}"
      puts "User data: #{resource_data(resource)}"
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
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
    JWT.encode payload, Rails.application.credentials.devise_jwt_private_key, 'HS256' 
  end 

  def drop_session_cookie
    request.session_options[:skip] = true
  end
end
