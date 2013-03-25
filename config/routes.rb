Imrollin::Application.routes.draw do
  resources :categories
  resources :images

  match 'create_category/:name/:image_id' => 'categories#create'
  match 'delete_category/:name/:image_id' => 'categories#destroy'
  match 'image_categories/:image_id' => 'categories#index'
  match 'images_category/:name' => 'images#index'
  root :to => 'images#index'
end
