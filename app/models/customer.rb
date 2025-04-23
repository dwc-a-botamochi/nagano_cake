class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :addresses
  has_many :orders
  has_many :cart_items

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, 
            :post_code, :address, :phone_number, :email, presence: true       # 空でない
  validates :post_code, format: { with: /\A\d{7}\z/ }                         # 郵便番号（ハイフンなし7桁）
end
