class StationsController < ApplicationController

  def index
    @without_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: false).where(vote_district_id: params[:number])
    @with_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: true).where(vote_district_id: params[:number])
    if (@without_wheelchair_stations.empty? && @with_wheelchair_stations.empty?) || params[:number]== ''
      @without_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: false)
      @with_wheelchair_stations = Station.where('latitude IS NOT NULL').where(barrier_free: true)
    end
  end
end
