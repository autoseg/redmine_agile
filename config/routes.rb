resources :projects do
  member do
    get :prioritization,
      :to => "prioritization#index",
      :as => :prioritizations

    put :prioritization,
      :to => "prioritization#update",
      :as => :update_prioritizations
  end
end
