class ChangeDatatypeInSellProduct < ActiveRecord::Migration[7.0]
  def change
    change_column :sell_products, :status, :string
  end
end
