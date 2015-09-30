Rails.application.routes.draw do

  namespace :mpd do
    get 'help' #==> get "mpd/help", as: :mpd_help
    get 'status'
    post 'start'
    post 'stop'
    post 'next'
    post 'previous'
    post 'pause'
    post 'update'
    post 'add_song'
  end

  root 'static#home'

  #match '*path' => 'static#home', via: [:get, :post]
end
