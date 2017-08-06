# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'dashboards/home'
  get 'dashboards/investiments'
  post 'dashboards' => 'dashboards#home'

  root 'dashboards#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
