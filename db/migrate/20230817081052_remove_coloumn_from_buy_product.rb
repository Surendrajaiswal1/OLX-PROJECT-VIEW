class RemoveColoumnFromBuyProduct < ActiveRecord::Migration[7.0]
  def change
    remove_column :buy_products, :contact_number, :integer
  end
end
