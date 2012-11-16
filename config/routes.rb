resources :projects do
  member do
    get :prioritization,
      :to => "prioritization#index",
      :as => :prioritizations

    post :prioritization,
      :to => "prioritization#update",
      :as => :update_prioritizations
  end
end
