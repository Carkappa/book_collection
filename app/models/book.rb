class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :users, through: :user_books

  validates :title, presence: true
  validates :author, presence: true
  validates :price, presence: true
  validates :published_date, presence: true
end
