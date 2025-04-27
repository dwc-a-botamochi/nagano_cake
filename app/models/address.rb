class Address < ApplicationRecord
  belongs_to :customer

  validates :post_code, :address, :name, presence: true         # 空でない
  validates :post_code, format: { with: /\A\d{7}\z/ }           # 郵便番号（ハイフンなし7桁）

  def address_display
    '〒' + post_code + ' ' + address + ' ' + name
  end
  
end