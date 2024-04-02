class Users::SessionsController < Devise::SessionsController
    
    before_action :drop_session_cookie

    private

    def drop_session_cookie
      request.session_options[:skip] = true
    end

    respond_to :json
  
    def create
      super do |resource|
        render json: { message: 'Signed in successfully.', user: resource }, status: :created
      end
    end
  
    def destroy
      super do
        render json: { message: 'Signed out successfully.' }, status: :ok
      end
    end
  end
  