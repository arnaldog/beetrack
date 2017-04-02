module Api
  class BaseController < ActionController::API
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::ValueTooLong,   with: :value_too_long

    def record_not_found
      render json: { error: 'Vehicle with such identifier not found'}, status: 404
    end

    def value_too_long
      render json: { error: 'Vehicle identifier too long'}, status: 404

      return
    end
  end
end