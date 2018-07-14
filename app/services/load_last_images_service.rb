class LoadLastImagesService 
    include Callable 

    def initialize(args={})
    end

    def call
        [
            Image.as_y.order("image_date DESC").first,
            Image.as_t.order("start_year DESC").first,
            Image.mr_y.order("image_date DESC").first,
            Image.mr_t.order("start_year DESC").first,
            Image.pe_y.order("start_year DESC").first
        ]
    end 
end