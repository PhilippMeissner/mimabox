Rails.application.routes.draw do
  get 'mpd/help'

  match '*path' => 'static#home', via: [:get, :post]
  root 'static#home'
end
