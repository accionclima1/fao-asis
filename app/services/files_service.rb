require 'pathname'
class FilesService 
    include Callable 

    def initialize(args={})
        @inner_folders = %w{ ASt  ASy  MRt  MRy  PEy }
        @image_path = 'ASIS/CENTROAMERICA'
        @image_sub_path = 'SALIDA/QLK/VHt'

        @file_regex = {
            "ASt" => /ot(\d{4})(\d{2})(\d{2})a_m(\d+)(M|N)_(s[2|1]).png/,
            "ASy" => /oy(\d{4})a_m(\d+)(M|N)_(s[2|1]).png/,
            "MRt" => /ot(\d{4})(\d{2})(\d{2})x_m(\d+)(M|N)_(s[2|1]).png/,
            "MRy" => /oy(\d{4})x_m(\d+)(M|N)_(s[2|1]).png/,
            "PEy" => /py(\d{4})_(\d{4})a_t(\d{2})_m(\d+)(M|N)_(s[2|1]).png/
        }
    end

    def call 
        sql_query = <<-SQL
            INSERT OR IGNORE INTO images
            (image_date, main_class, period_type, crop_type, sowing_type, pixel_type, full_path, start_year, end_year, percentage, is_csc, created_at, updated_at)
            VALUES %{values};        
        SQL

        sql_values = []
        @inner_folders.each do |folder|
            files = Dir.glob(Rails.root.join("public", @image_path, @image_sub_path, folder, "*.png"))

            files.each do |f|
                file_name = File.basename(f)
                name_split = file_name.match(@file_regex[folder]).captures
                sql_values << genarate_inser_query(folder, name_split, f, false)
            end

            # CSC folder 
            
            files = Dir.glob(Rails.root.join("public", "#{@image_path}_CSC", @image_sub_path, folder, "*.png"))

            files.each do |f|
                file_name = File.basename(f)
                name_split = file_name.match(@file_regex[folder]).captures
                sql_values << genarate_inser_query(folder, name_split, f, true)
            end
        end
        complete_query = sql_query % { values: sql_values.join(',') }

        ActiveRecord::Base.connection.execute(complete_query)
    end

    private 

    def genarate_inser_query(folder, values, full_path, is_csc)
        insert_string = "(%{image_date}, %{main_class}, %{period_type}, %{crop_type}, %{sowing_type}, %{pixel_type}, %{full_path}, %{start_year}, %{end_year}, %{percentage}, %{is_csc}, date('now'), date('now'))"
        absolute_path = Pathname.new(File.expand_path(full_path))
        relative      = absolute_path.relative_path_from(Rails.root.join("public"))
        case folder
            when "ASt", "MRt"
                return insert_string % {
                    image_date:     "'#{DateTime.new(values[0].to_i, values[1].to_i, values[2].to_i).strftime("%F")}'",
                    main_class:     "'#{folder[0..1]}'",
                    period_type:    "'#{folder[2]}'",
                    crop_type:      values[3],
                    sowing_type:    "'#{values[5]}'",
                    pixel_type:     "'#{values[4]}'",
                    full_path:      "'#{relative}'",
                    start_year:     "null",
                    end_year:       "null",
                    percentage:     "null",
                    is_csc:         is_csc == true ? '1' : '0',
                }
            when "ASy", "MRy"
                return insert_string % {
                    image_date:     "null",
                    main_class:     "'#{folder[0..1]}'",
                    period_type:    "'#{folder[2]}'",
                    crop_type:      "#{values[1]}",
                    sowing_type:    "'#{values[3]}'",
                    pixel_type:     "'#{values[2]}'",
                    full_path:      "'#{relative}'",
                    start_year:     values[0],
                    end_year:       "null",
                    percentage:     "null",
                    is_csc:         is_csc == true ? '1' : '0',
                }
            when "PEy" 
                return insert_string % {
                    image_date:     "null",
                    main_class:     "'#{folder[0..1]}'",
                    period_type:    "'#{folder[2]}'",
                    crop_type:      values[3],
                    sowing_type:    "'#{values[5]}'",
                    pixel_type:     "'#{values[4]}'",
                    full_path:      "'#{relative}'",
                    start_year:     values[0],
                    end_year:       values[1],
                    percentage:     values[2],
                    is_csc:         is_csc == true ? '1' : '0',
                }  
        end    
    end
end