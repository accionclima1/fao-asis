Rails.application.routes.draw do
  root to: 'home#index'
  
  get "informacion_agronomica/fenologia", to: "agronomic_information#phenoilogy", as: :phenoilogy
  get "informacion_agronomica/cobertura", to: "agronomic_information#cover", as: :cover

  get "granos_basicos", to: "basic_grains#index", as: :basic_grains
  get "granos_basicos/get_images", to: "basic_grains#get_images", as: :basic_grains_get_images

  get "corredor_seco", to: "ca_dry_corridor#index", as: :ca_dry_corridor
  get "corredor_seco/get_images", to: "ca_dry_corridor#get_images", as: :ca_dry_corridor_get_images

  get "estado_de_la_vegetacion", to: "state_of_vegetation#index", as: :state_of_vegetation
  get "estado_de_la_vegetacion/get_images", to: "state_of_vegetation#get_images", as: :state_of_vegetation_get_images
  
  get "referencias", to: "references#index", as: :references
end