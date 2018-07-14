class Image < ApplicationRecord
    enum main_class: {
        asi: 'AS', sequia: 'MR', probabilidad: 'PE'
    }

    enum period_type: {
        t: 't', y: 'y'
    }

    enum crop_type: {
        rice: 1, corn_beans: 2, perennial_crops: 3, shrub_vegetation: 4
    }

    enum sowing_type: {
        s1: 's1', s2: 's2'
    }

    enum pixel_type: {
        m: 'M', n: 'N'
    }

    scope :as_y, lambda { where(main_class: :asi, period_type: 'y')}
    scope :as_t, lambda { where(main_class: :asi, period_type: 't')}

    scope :mr_y, lambda { where(main_class: :sequia, period_type: 'y')}
    scope :mr_t, lambda { where(main_class: :sequia, period_type: 't')}

    scope :pe_y, lambda { where(main_class: :probabilidad, period_type: 'y')}
    
end
