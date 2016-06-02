Visualizeitor::Application.routes.draw do
  resources :documents

  resources :categories

  resources :acforms

  resources :activities

  resources :evaluations

  resources :internships

  resources :contacts

  resources :companies
  devise_for :teachers, :skip => [:registrations]

  devise_for :students
  resources :teachers

  resources :displays

  resources :program_items

  resources :students do
    resources :enrollments, only: [:index, :ira_chart] do
      collection do
        get 'ira_chart'
      end
    end
    collection do
      get 'search'
    end
  end

  resources :enrollments

  resources :courses do
    resources :enrollments, only: [:index, :chart] do
      collection do
        get 'chart'
      end

    end
  end

  resources :programs do
    resources :students
  end

  resources :majors do
    get 'upload_content'
    post 'upload'
    resources :programs do
      resources :students, only: :index
    end
    resources :students

  end

  resources :invites do

  end

  resources :users, only: :index do
    put 'change_role'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'displays#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
