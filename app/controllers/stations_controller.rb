class StationsController < ApplicationController
  before_action :cities, only: [:city, :index]
  layout 'city', only: [:city]
  def index
    @cities = City.all
  end

  def city
    @city = City.find_by_slug(params[:city_slug])
    redirect_to root_path if @city.nil?
    @without_wheelchair_stations = Rails.cache.fetch("#{@city.slug}_without_wheelchair_stations", expires_in: 5.hours) {
      Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: false)
    }
    @with_wheelchair_stations = Rails.cache.fetch("#{@city.slug}_with_wheelchair_stations", expires_in: 5.hours) {
       Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: true)
    }
  end

  def search
    unless params["c"]==''
      city = City.find_by_slug(params[:c])
      render json: Address.search_city(params[:q], city.zip).first
    else
      render json: Address.search(params[:q]).first
    end
  end

  private
  def cities
    @cities = City.all
  end
end
