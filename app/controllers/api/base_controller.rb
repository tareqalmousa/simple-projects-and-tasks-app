module Api
  class BaseController < ApplicationController

    before_action :authenticate_user!

    def raise_api_error(errors, status)
      render json: {
        'errors': errors
      }, status: status
    end

    def missing_params(params, required_params)
      missing = []
      required_params.each do |r|
        if params.key? r
          missing << r if params[r].blank?
        else
          missing << r
        end
      end
      missing
    end

  end
end
