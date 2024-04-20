class Users::SessionsController < Devise::SessionsController
  before_action :drop_session_cookie
  respond_to :json

  # POST /api/v1/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource) if resource.persisted?
    render json: { message: 'Signed in successfully.', user: resource }, status: :created
  end

  # DELETE /api/v1/sign_out
  def destroy
    sign_out
    render json: { message: 'Signed out successfully.' }, status: :ok
  end

  private

  def drop_session_cookie
    request.session_options[:skip] = true
  end
end

  
