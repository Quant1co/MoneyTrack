class Favorite < ApplicationRecord
  belongs_to :user

  validates :ticker, presence: true, uniqueness: { scope: :user_id, message: "уже добавлена в избранное" }
  validates :price, presence: true, numericality: true
end
