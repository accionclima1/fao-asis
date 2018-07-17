class CaDryCorridorController < ApplicationController
    def index 
        @images = ImagesFormModel.new
    end

    def get_images
        @images = ImagesFormModel.new(grain_search_params)
        @images = ImagesSearchService.call(@images)

        respond_to do |format|
            format.html { render :layout => false }
          end
    end

    private 

    def grain_search_params
        params.require(:ca_dry_corridor_images_form).permit(:main_class, :percentage, :crop_type, :period_type, :is_csc, :page)
    end
end
