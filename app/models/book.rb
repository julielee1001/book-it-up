class Book < ApplicationRecord
    has_and_belongs_to_many :lists

    validates :title, :author, :description, presence: true
    validates :google_id, presence: true, uniqueness: true
end
