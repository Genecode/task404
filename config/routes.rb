Rails.application.routes.draw do

  root 'users#index'
  resources :users do
    resources :expenses
    resources :incomes
  end
end
