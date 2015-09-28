Rails.application.routes.draw do
  get 'mimabox/help'

  match '*path' => 'static#home', via: [:get, :post]
  root 'static#home'
end
