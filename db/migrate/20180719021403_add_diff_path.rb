class AddDiffPath < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :is_dif, :boolean, defautl: 0
    add_column :images, :name, :string
  end
end
