class ImagesSearchService 
    include Callable 

    def initialize(form)
        @form = form
    end

    def call
        images = Image.where(main_class: @form.main_class, crop_type: @form.crop_type, period_type: @form.period_type)

        page = @form.page || 1

        if @form.main_class == 'probabilidad'
            images = images.where(percentage: @form.percentage)
        end

        images = images.order("CAST(IFNULL(DATE(image_date, '%Y'), start_year) as integer) DESC, crop_type ASC, sowing_type ASC, period_type ASC")

        images = images.page(page.to_i).per(20)

        images
    end 
end