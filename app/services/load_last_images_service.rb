class LoadLastImagesService 
    include Callable 

    def initialize(args={})
        @dir_name = 'last_indices'
    end

    def call
        path = Rails.root.join("public", @dir_name)
        files = Dir.glob("#{path}/*").map{|f| "#{@dir_name}/#{File.basename(f)}" }
        files
    end 
end