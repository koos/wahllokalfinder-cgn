class StationsController < ApplicationController
  before_action :cities, only: [:city, :index]
  layout 'city', only: [:city]
  def index
    @cities = City.all
  end

  def search
    render json: Address.search(params[:q]).first
  end

  def city
    @city = City.find_by_slug(params[:city_slug])
    redirect_to root_path if @city.nil?
    @without_wheelchair_stations = Rails.cache.fetch('without_wheelchair_stations', expires_in: 5.hours) {
      Station.where('latitude IS NOT NULL').where(barrier_free: false)
    }
    @with_wheelchair_stations = Rails.cache.fetch('with_wheelchair_stations', expires_in: 5.hours) {
       Station.where('latitude IS NOT NULL').where(barrier_free: true)
    }
  end

  private
  def cities
    @cities = City.all
  end

end
