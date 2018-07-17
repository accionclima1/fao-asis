class BasicGrainsController < ApplicationController

    def index 
        @grains_images = ImagesFormModel.new
    end

    def get_images
        @grains_images = ImagesFormModel.new(grain_search_params)
        @images = ImagesSearchService.call(@grains_images)

        respond_to do |format|
            format.html { render :layout => false }
          end
    end

    private 

    def grain_search_params
        params.require(:grains_images_form).permit(:main_class, :percentage, :period_type, :crop_type, :is_csc, :page)
    end
end
