Rails.application.routes.draw do
  root to: 'home#index'
  
  get "granos_basicos", to: "basic_grains#index", as: :basic_grains
  get "granos_basicos/get_images", to: "basic_grains#get_images", as: :basic_grains_get_images

  get "corredor_seco", to: "ca_dry_corridor#index", as: :ca_dry_corridor
  get "corredor_seco/get_images", to: "ca_dry_corridor#get_images", as: :ca_dry_corridor_get_images
end
