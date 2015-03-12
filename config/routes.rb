Rails.application.routes.draw do
  root 'search#map'
  get 'search/' => 'search#do_search'
end
