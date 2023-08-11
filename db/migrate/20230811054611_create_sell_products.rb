class CreateSellProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :sell_products do |t|
      t.string :name
      t.integer :status
      t.integer :price
      t.string :alphanumeric_id
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
