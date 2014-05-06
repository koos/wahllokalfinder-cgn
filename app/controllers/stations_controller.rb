class StationsController < ApplicationController

  def index
    @without_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: false)
    @with_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: true)
  end
end
