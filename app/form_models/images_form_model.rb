class ImagesFormModel
    include ActiveModel::Model

    attr_accessor(
        :main_class,
        :percentage,
        :crop_type,
        :period_type,
        :is_csc,
        :is_dif,
        :year,
        :dd,
        :page
    )
end