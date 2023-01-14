class ApplicationController < ActionController::API

  def render_json_response(resource)
    if resource.respond_to?(:errors) && resource.errors.present?
      render json: resource.errors, status: 400
    else
      render json: resource
    end
  end

end
