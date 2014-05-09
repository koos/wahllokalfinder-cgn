class StationsController < ApplicationController

  def index
    @without_wheelchair_stations = Rails.cache.fetch('without_wheelchair_stations', expires_in: 5.hours) {
      Station.where('latitude IS NOT NULL').where(barrier_free: false)
    }
    @with_wheelchair_stations = Rails.cache.fetch('with_wheelchair_stations', expires_in: 5.hours) {
       Station.where('latitude IS NOT NULL').where(barrier_free: true)
    }
  end

  def search
    render json: Address.search(params[:q]).first
  end

end
