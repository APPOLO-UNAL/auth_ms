class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    puts "Sign up params: #{sign_up_params}"

    if resource.save  
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        token = generate_jwt_token(resource)
        render json: { message: 'Signed up successfully.', token: token, user: resource }, status: :created  
      else
        expire_data_after_sign_in!
        render json: { message: "Signed up successfully. Please confirm your email address.", user: resource }, status: :ok
      end
    else 
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def generate_jwt_token(user)
    payload = { sub: user.id, exp: Time.now.to_i + 1.day.to_i }
    JWT.encode payload, Rails.application.credentials.devise_jwt_private_key, 'HS256' 
  end 

  def drop_session_cookie
    request.session_options[:skip] = true
  end
end
