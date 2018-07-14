Rails.application.routes.draw do
  root to: 'home#index'
  
  get "basic_grains", to: "basic_grains#index", as: :basic_grains
  get "basic_grains/get_images", to: "basic_grains#get_images", as: :basic_grains_get_images

  get "ca_dry_corridor", to: "ca_dry_corridor#index", as: :ca_dry_corridor
  get "ca_dry_corridor/get_images", to: "ca_dry_corridor#get_images", as: :ca_dry_corridor_get_images
end
