class StationsController < ApplicationController
  before_action :cities, only: [:city, :index]
  layout 'city', only: [:city]
  def index
    @cities = City.all.order(:name)
  end

  def city
    @city = City.find_by_slug(params[:city_slug])
    redirect_to root_path and return if @city.nil?

    stations_count = Station.count
    puts "________ #{Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: false).count} are without_wheelchair_stations"
    puts "_______ #{Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: true).count} are with_wheelchair_stations"
    @without_wheelchair_stations = Rails.cache.fetch("#{@city.slug}_without_wheelchair_stations_#{stations_count}", expires_in: 5.hours) {
      Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: false)
    }
    @with_wheelchair_stations = Rails.cache.fetch("#{@city.slug}_with_wheelchair_stations_#{stations_count}", expires_in: 5.hours) {
       Station.where('latitude IS NOT NULL').where(zip: @city.zip).where(barrier_free: true)
    }

  end

  def search
    unless params["c"]==''
      render json: Address.search_city(params[:q], City.find_by_slug(params[:c])).first
    else
      render json: Address.search(params[:q]).first
    end
  end

  private
  def cities
    @cities = City.all
  end
end
