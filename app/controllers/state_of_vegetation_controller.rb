class StateOfVegetationController < ApplicationController
    def index 
        @images = ImagesFormModel.new
    end

    def get_images
        @images = ImagesFormModel.new(state_of_vegetation_params)
        @images = ImagesSearchService.call(@images)

        respond_to do |format|
            format.html { render :layout => false }
          end
    end

    private 

    def state_of_vegetation_params
        params.require(:state_of_vegetation_images_form).permit(:year, :dd, :is_dif, :page)
    end
end
