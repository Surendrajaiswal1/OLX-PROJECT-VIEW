class SellProduct < ApplicationRecord
  paginates_per 2
  # validates :name,length: {minimum: 2}
  # validates :price,presence: true, :numericality => true
  # validates :description,presence: true,length: {minimum: 10}
  belongs_to :user
  belongs_to :category
  has_many :buy_products, dependent: :destroy
  has_one_attached :image
  before_save :set_unique_id
  before_save :status_update

  enum status: [ :available, :sold ]

  def set_unique_id
    id = SecureRandom.hex[0..7]
    products = SellProduct.all
    products.each do |product|
      if product.alphanumeric_id == id
        set_unique_id
      end
    end
    self.alphanumeric_id = id
  end

  def status_update
    self.status = "available"
  end
end
