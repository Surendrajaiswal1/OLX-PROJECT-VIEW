class Category < ApplicationRecord
  has_many :sell_products, dependent: :destroy
  validates :category_name, presence: true,uniqueness: true
  before_save :remove_spaces

  def remove_spaces
    self.category_name = category_name.strip()
  end
end
