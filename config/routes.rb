Rails.application.routes.draw do
  match '*path' => 'static#home', via: [:get, :post]
  root 'static#home'
end
