class ImagesFormModel
    include ActiveModel::Model

    attr_accessor(
        :main_class,
        :percentage,
        :crop_type,
        :period_type,
        :page
    )
end