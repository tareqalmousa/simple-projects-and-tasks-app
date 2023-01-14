class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?

    render_json_response(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password)
  end
end
