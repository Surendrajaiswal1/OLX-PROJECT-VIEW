class User < ApplicationRecord
  # validates :name,format: { with: /\A[a-z A-Z]+\z/ }, presence: true
  # validates :email,presence: true,uniqueness: true,format: {with: /\A[a-zA-Z]+[a-zA-Z0-9._]*@[a-zA-Z]+\.+[a-z]{2,3}/}
  # validates :password,presence: true, format: {with: /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]]) /x}
  has_many :sell_products, dependent: :destroy
  has_many :buy_products,dependent: :destroy
  before_save :remove_spaces

  def remove_spaces
    self.name = name.strip()
    self.email = email.strip()
  end
end
