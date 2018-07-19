require 'pathname'
class FilesService 
    include Callable 

    def initialize(args={})
        @inner_folders = %w{ ASt  ASy  MRt  MRy  PEy }
        @image_path = 'ASIS/CENTROAMERICA'
        @image_sub_path = 'SALIDA/QLK/VHt'
        @image_dif_path = 'SALIDA/QLK/DIF/VHt'

        @file_regex = {
            "ASt"  => /ot(\d{4})(\d{2})(\d{2})a_m(\d+)(M|N)_(s[2|1]).png/,
            "ASy"  => /oy(\d{4})a_m(\d+)(M|N)_(s[2|1]).png/,
            "MRt"  => /ot(\d{4})(\d{2})(\d{2})x_m(\d+)(M|N)_(s[2|1]).png/,
            "MRy"  => /oy(\d{4})x_m(\d+)(M|N)_(s[2|1]).png/,
            "PEy"  => /py(\d{4})_(\d{4})a_t(\d{2})_m(\d+)(M|N)_(s[2|1]).png/,
            "DIFF" => /ot(\d{4})(\d{2})(\d{2})h[_]?(mNN)?.png/
        }
    end

    def call 
        sql_query = <<-SQL
            INSERT OR IGNORE INTO images
            (name, image_date, main_class, period_type, crop_type, sowing_type, pixel_type, full_path, start_year, end_year, percentage, is_csc, is_dif, created_at, updated_at)
            VALUES %{values};        
        SQL

        sql_values = []
        @inner_folders.each do |folder|
            files = Dir.glob(Rails.root.join("public", @image_path, @image_sub_path, folder, "*.png"))

            files.each do |f|
                file_name = File.basename(f)
                name_split = file_name.match(@file_regex[folder]).captures
                sql_values << genarate_inser_query(folder, name_split, f, file_name, false)
            end

            # CSC folder 
            
            files = Dir.glob(Rails.root.join("public", "#{@image_path}_CSC", @image_sub_path, folder, "*.png"))

            files.each do |f|
                file_name = File.basename(f)
                name_split = file_name.match(@file_regex[folder]).captures
                sql_values << genarate_inser_query(folder, name_split, f, file_name, true)
            end
        end

        #Diff path
        dif_files = Dir.glob(Rails.root.join("public", "#{@image_path}", @image_dif_path, "*.png"))

        dif_files.each do |f|
            file_name = File.basename(f)
            name_split = file_name.match(@file_regex["DIFF"]).captures
            sql_values << genarate_inser_query('DIFF', name_split, f, file_name, true)
        end


        complete_query = sql_query % { values: sql_values.join(',') }

        ActiveRecord::Base.connection.execute(complete_query)
    end

    private 

    def genarate_inser_query(folder, values, full_path, file_name, is_csc)
        insert_string = "(%{name}, %{image_date}, %{main_class}, %{period_type}, %{crop_type}, %{sowing_type}, %{pixel_type}, %{full_path}, %{start_year}, %{end_year}, %{percentage}, %{is_csc}, %{is_dif}, date('now'), date('now'))"
        absolute_path = Pathname.new(File.expand_path(full_path))
        relative      = absolute_path.relative_path_from(Rails.root.join("public"))
        case folder
            when "ASt", "MRt"
                return insert_string % {
                    name:           "'#{file_name}'",
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
                    is_dif:         0
                }
            when "ASy", "MRy"
                return insert_string % {
                    name:           "'#{file_name}'",
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
                    is_dif:         0
                }
            when "PEy" 
                return insert_string % {
                    name:           "'#{file_name}'",
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
                    is_dif:         0
                }  
            when "DIFF" 
                is_vegetation_state = values[3].present?
                name_capture = file_name.match(/(ot[\d]{8})h(_mNN)?.png/).captures
                return insert_string % {
                    name:           "'#{name_capture[0]}'",
                    image_date:     "'#{DateTime.new(values[0].to_i, values[1].to_i, values[2].to_i).strftime("%F")}'",
                    main_class:     "'#{folder}'",
                    period_type:    "null",
                    crop_type:      is_vegetation_state ? 1 : 2,
                    sowing_type:    "null",
                    pixel_type:     "null",
                    full_path:      "'#{relative}'",
                    start_year:     "null",
                    end_year:       "null",
                    percentage:     "null",
                    is_csc:         is_csc == true ? '1' : '0',
                    is_dif:         1
                }  
        end    
    end
end