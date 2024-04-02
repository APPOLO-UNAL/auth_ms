class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
  
    def create
      build_resource(sign_up_params)
  
      resource.save
      if resource.persisted?
        if resource.active_for_authentication?
          sign_up(resource_name, resource)
          render json: { message: 'Signed up successfully.', user: resource }, status: :created
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
  
    def drop_session_cookie
      request.session_options[:skip] = true
    end
  end
  