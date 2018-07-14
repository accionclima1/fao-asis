class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.datetime    :image_date
      t.string      :main_class
      t.string      :period_type
      t.integer     :crop_type
      t.string      :sowing_type
      t.string      :pixel_type
      t.string      :full_path
      t.integer     :start_year
      t.integer     :end_year
      t.integer     :percentage
      t.boolean     :is_csc
      t.timestamps
    end

    add_index :images, :full_path, unique: true
    add_index :images, :image_date
    add_index :images, :main_class
    add_index :images, :period_type
    add_index :images, :crop_type
    add_index :images, :sowing_type
    add_index :images, :pixel_type
    add_index :images, :percentage
    add_index :images, :start_year
    add_index :images, :end_year
  end
end
