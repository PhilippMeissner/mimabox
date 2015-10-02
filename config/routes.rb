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
  end
  # For some reason this path must not be in the namespace?!
  post '/mpd/play_song/:id', to: 'mpd#play_song', as: 'mpd_play_song'



  root 'static#home'

  #match '*path' => 'static#home', via: [:get, :post]
end
