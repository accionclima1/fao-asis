module StateOfVegetationHelper

    def get_vegetation_type(veg_type)
        case veg_type 
            when 'rice'
                "Estado de la vegetación"
            when 'corn_beans'
                "Estado de la vegetación por área administrativa"
        end
    end
end
