class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  #has_many :items, :addresses, :cart_items #dependent: :destroy

  validates :last_name, :first_name, :last_name_kana, :first_name_kana, 
            :post_code, :address, :phone_number, :email, presence: true       # 空でない
end
