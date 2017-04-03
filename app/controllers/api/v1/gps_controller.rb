module Api
  module V1
    class GpsController < Api::BaseController
      before_action :permit_params
      after_action  :enqueue_waypoint, only: :create

      def create
        render json: { success: true } if vehicle.valid?
      end

      def bbox
        render json: Tracking.bbox
      end

      private

      def enqueue_waypoint
        TrackerJob.perform_later(latitude, longitude, sent_at, vehicle)
      end

      def sent_at
        @sent_at ||= params[:sent_at]
        @sent_at ||= DateTime.now
      end

      def latitude
        params[:latitude]
      end

      def longitude
        params[:longitude]
      end

      def vehicle
        @vehicle ||= Vehicle.find_or_create_by(identifier: vehicle_identifier)
      end

      def vehicle_identifier
        params[:vehicle_identifier] || Vehicle.random_vehicle_identifier
      end

      def permit_params
        params.permit(:vehicle_identifier, :latitude, :longitude, :sent_at)
      end
    end
  end
end