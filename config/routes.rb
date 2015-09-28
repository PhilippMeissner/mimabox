Rails.application.routes.draw do

  namespace :mpd do
    get 'help' #==> get "mpd/help", as: :mpd_help
    get 'status'
    get 'start'
    get 'stop'
    get 'next'
    get 'previous'
    get 'pause'
  end


  match '*path' => 'static#home', via: [:get, :post]
  root 'static#home'
end
