Wahllokalfinder::Application.routes.draw do
  resources :stations

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root 'stations#index'

  get 'search' => 'stations#search'

end
