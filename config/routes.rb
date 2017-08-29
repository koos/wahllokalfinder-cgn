Wahllokalfinder::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'stations#index'
  get '/search' => 'stations#search'
  get '/:city_slug' => 'stations#city', as: 'city'

end
