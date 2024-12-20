class Book < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :book_lists, dependent: :destroy
    has_many :lists, through: :book_lists

    validates :title, :author, :description, presence: true
    validates :google_id, presence: true, uniqueness: true
end
