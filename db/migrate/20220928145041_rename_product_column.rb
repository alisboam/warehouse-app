class RenameProductColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :product_models, :heigth, :height
  end
end
