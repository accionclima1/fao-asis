class ImagesSearchService 
    include Callable 

    def initialize(form)
        @form = form
    end

    def call

        if @form.is_dif
            date = "#{@form.year}-#{@form.dd}"
            images = Image.where("is_dif = 1 AND image_date = '#{date}' ")
            images = images.order("image_date DESC, name DESC")
        else
            images = Image.where(main_class: @form.main_class, crop_type: @form.crop_type, period_type: @form.period_type, is_csc: @form.is_csc.to_i, is_dif: false)
            if @form.main_class == 'probabilidad'
                images = images.where(percentage: @form.percentage)
            end
            images = images.order("CAST(IFNULL(strftime('%Y', image_date), start_year) as integer) DESC, crop_type ASC, sowing_type ASC, period_type ASC")
        end

        page = @form.page || 1

        images = images.page(page.to_i).per(20)

        images
    end 
end