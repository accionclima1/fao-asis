module BasicGrainsHelper
    def get_index_type(index)
        case index 
            when 'asi'
                "Índice de estrés agrícola (ASI)"
            when 'sequia'
                "Categoría de sequía"
            when 'probabilidad'
                "Probabilidad histórica de sequía"
        end
    end

    def get_crop_type(crop)
        case crop 
            when 'rice'
                "Arroz"
            when 'corn_beans'
                "Maíz/Frijoles"
            when 'perennial_crops'
                "Cultivos Perennes"
            when 'shrub_vegetation'
                "Vegetación Arbustiva"
        end
    end

    def get_sowing_type(sowing)
        case sowing 
            when 's1'
                "Primera"
            when 's2'
                "Postrera"
        end
    end

    def get_period_type(period)
        case period 
            when 't'
                "Decadía (10 días)"
            when 'y'
                "Año"
        end
    end
end
