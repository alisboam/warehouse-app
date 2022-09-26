class CreateSuppliers < ActiveRecord::Migration[7.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :company_name
      t.integer :cnpj
      t.string :address
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
