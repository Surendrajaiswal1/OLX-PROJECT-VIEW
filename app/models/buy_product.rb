class BuyProduct < ApplicationRecord
 validates :contact_number, presence: true, :numericality => true, :length => { :minimum => 10, :maximum => 10 }
  belongs_to :user
  belongs_to :sell_product
  before_save :set_unique_id
  after_save :status_update

  def set_unique_id
   id = SecureRandom.hex[0..7]
    products = BuyProduct.all
    products.each do |product|
      if product.order_id == id
        set_unique_id
      end
    end
    self.order_id = id
  end

  def status_update
    self.sell_product.sold!
  end
end
