class Addresse < ApplicationRecord
  # belongs_to :customer

  validates :post_code, :address, :name, presence: true        # 空でない
end