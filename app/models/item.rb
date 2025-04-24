class Item < ApplicationRecord
    has_many :cart_items, dependent: :destroy
    belongs_to :genre
    
    validates :genre_id, :name, :introduction, :price,  presence: true
    validates :is_active, inclusion: { in: [true, false] }

    has_one_attached :image

    def get_image (width, height)
        unless image.attached?
          file_path = Rails.root.join('app/assets/images/no_image.jpg')
          image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        image.variant(resize_to_limit: [width, height]).processed
    end

end
