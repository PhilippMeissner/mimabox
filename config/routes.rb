Rails.application.routes.draw do

  namespace :mpd do
    get 'help' #==> get "mpd/help", as: :mpd_help
    get 'status'
    get 'start'
    get 'stop'
    get 'next'
    get 'previous'
    get 'pause'
    get 'update'
  end

  root 'static#home'

  #match '*path' => 'static#home', via: [:get, :post]
end
